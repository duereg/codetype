```
title: Posting an IEnumerable of Interfaces back from your Views by extending the DefaultModelBinder
link: http://codetype.wordpress.com/2012/04/26/posting-an-ienumerable-of-interfaces-back-from-your-views-by-extending-the-defaultmodelbinder/
author: mablair2
description:
post_id: 145
created: 2012/04/26 18:03:47
created_gmt: 2012/04/26 10:03:47
comment_status: open
post_name: posting-an-ienumerable-of-interfaces-back-from-your-views-by-extending-the-defaultmodelbinder
status: publish
tags: post, development, software, coding, web, IEnumerable, C#, .NET, ASP.NET, MVC, ViewModel, DefaultModelBinder, Views, Interface
layout: post
```

# Posting an IEnumerable of Interfaces back from your Views by extending the DefaultModelBinder

> **Please note I came across a bug in the code, and revised this post on 31/07/2012.**

Came across an interesting problem today. In ASP.Net MVC, you can easily pass an enumerable of interfaces to your views from your controllers. As long as you have `DisplayTemplates` and `EditorTemplates` defined for the subclasses, then those classes will be rendered correctly from your enumerable of the parent interfaces.

However, if you then POST to a controller method that accepts an `IEnumerable`, you'll get the error message:

> Cannot create an instance of an Interface

In looking for a solution, I found some examples online that handled abstract classes. Unfortunately, none of those examples had a way to post data back without modifying the views, and I couldn't figure out a way either.

Here is my solution:

1) Modify your EditorTemplates to use the `Type` extension method defined below. This will write a hidden field to the view that defines the class being used. Example:

> ` @Html.Type(Model) `

2) Register the `SectionModelBinder` below in Global.asax. Example:

> ` ModelBinders.Binders.DefaultBinder = new SectionModelBinder(); `

3) That's it! You should be on your way to POSTing a generic list of different subclasses to a controller method.

``` cs
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;

namespace ProofOfConcept
{
    public class SectionModelBinder : DefaultModelBinder
    {
        public const string ModelTypeNameKey = "ModelTypeName";

        ///<summary>
        /// Creates the model.
        /// </summary>
        /// The controller context.
        /// The binding context.
        /// Type of the base.
        /// The instantiated model
        ///
        /// You must create a hidden field named 'ModelTypeName' on the View,
        /// where the value is the Full name of the class you are trying to create.
        /// The HtmlHelper extension method 'Type' was designed to create this field
        /// and hide the implementation details.
        ///
        /// Currently the model you trying to create must inherit from a base class
        /// that is the same assembly.
        ///
        protected override object CreateModel(ControllerContext controllerContext, ModelBindingContext bindingContext, Type baseType)
        {
            if (baseType.IsInterface &&
                (baseType != typeof(IEnumerable)) &&
                !baseType.GetInterfaces().Any(t => t == typeof(IEnumerable)) &&
                !(baseType.IsGenericType && baseType.GetGenericTypeDefinition() == typeof(IEnumerable)))
            {
                var modelTypeValue = bindingContext.ValueProvider.GetValue(bindingContext.ModelName + "." + ModelTypeNameKey);

                if (modelTypeValue == null)
                    throw new Exception("View does not contain " + bindingContext.ModelName + "." + ModelTypeNameKey + " field.");

                var subclassName = modelTypeValue.AttemptedValue;

                if(string.IsNullOrWhiteSpace(subclassName ))
                    throw new Exception("View for " + bindingContext.ModelName + " does not have a value set for the " + ModelTypeNameKey + " field.");

                var subclassType = baseType.Assembly.GetTypes().SingleOrDefault(x => (x.FullName == subclassName));

                var model = CreateInstance(baseType, subclassType, subclassName);

                if (model != null)
                {
                    bindingContext.ModelMetadata = ModelMetadataProviders.Current.GetMetadataForType(() => model, subclassType);
                }

                return model;
            }

            return base.CreateModel(controllerContext, bindingContext, baseType);
        }

        protected virtual object CreateInstance(Type baseType, Type subclassType, string subclassName)
        {
            if (subclassName == null)
                throw new ArgumentNullException("subclassName");

            if (subclassType == null)
                throw new Exception("Could not find model " + subclassName);

            if (!subclassType.GetInterfaces().Any(t => t == baseType))
                throw new Exception("The model of type " + subclassName + " does not implement " + baseType.FullName);

            return Activator.CreateInstance(subclassType);
        }
    }
}
```

``` cs
namespace System.Web.Mvc.Html
{
    public static class HtmlHelperExtension
    {
        public static MvcHtmlString Type(this HtmlHelper htmlHelper, object value)
        {
            if (htmlHelper == null) throw new ArgumentNullException("htmlHelper");
            if (value == null) throw new ArgumentNullException("value");

            return htmlHelper.Hidden(SectionModelBinder.ModelTypeNameKey, value.GetType().FullName);
        }
    }
}
```

