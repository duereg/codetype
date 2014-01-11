```
title: Derby.js - Starting out with Components; Creating a Twitter Bootstrap Input Component
link: http://codetype.wordpress.com/2012/08/25/derby-js-starting-out-with-components-creating-a-twitter-bootstrap-input-component/
author: mablair2
description: 
post_id: 256
created: 2012/08/25 00:20:23
created_gmt: 2012/08/24 16:20:23
comment_status: open
post_name: derby-js-starting-out-with-components-creating-a-twitter-bootstrap-input-component
status: publish
layout: post
```

# Derby.js - Starting out with Components; Creating a Twitter Bootstrap Input Component

In working with [Twitter Bootstrap Forms](http://twitter.github.com/bootstrap/base-css.html#forms), one of my favorite ways to lay out a form is using the Horizontal form layout. The layout requires a bit of css/html to get each of the form elements (the text boxes and what not) to play nicely. To add form elements to the horizontal form layout, you need the following html structure for each field: 

``` html
<div class="control-group"><!-- additional classes here to change state -->
  <label class="control-label">INPUT_LABEL_TEXT_HERE</label>
  <div class="controls">
    <input type="text" /> <!-- This is the control you want to display -->
    <span class="help-inline">ERROR_OR_INFORMATIONAL_MESSAGE_HERE</span>
  </div>
</div> 
```

 That's a hefty amount of markup to copy and paste all over your pristine views. Which makes this a great place to use a [Component](http://derbyjs.com/#components). 

## So what's a [Component](http://derbyjs.com/#components)?

A component is basically a derby template you can supply parameters to. Those parameters are supplied in the form of HTML attributes and HTML content. There are two types of components: application and library. Application components can only be used in a single project. Library components can be re-used across multiple projects. For my project I'm going to create an application component. Eventually if I need the component on another project I'll add it to a component library. But that process is more complicated and less documented so I'll save that for another day. There are two ways to create an application component: 

  * **Inline**
If your component is only being used on a single view, you can add it to the same file as your view. 
  * **External**
If your component is going to be used on multiple views, you should create a separate file for your component.  Apparently there are two ways to create a library component as well: 

> The ui directory contains a component library, which can be used to create custom components for the containing project. These are re-usable templates, scripts, and styles that can be used to create custom HTML tags for use in applications. General purpose component libraries can be created as separate npm modules. 

All components run under the scope of the context in which they are called. Which means you can bind model data to your component without having to pass your component any values. For example: 

``` html
<h2>All toys:</h2>
  {each toys as :toy} <!-- Alias :toy available to the component -->
    <app:toyStatus> <!-- All application components live in the app namespace -->
  {/}
 
<toyStatus:>  <!-- this tag says I am a component -->
  <!-- I'm using alias :toy here, defined above -->
  <span>The toy is located at {:toy.location}</span> 
```

 If all of this "Model-Bindy" stuff is foreign to you, check out my post [Working with Views, Models, and Bindings](http://codetype.wordpress.com/2012/08/07/derby-js-working-with-view-templates-models-and-bindings/). 

## I don't like the way you used a scoped alias from your view in your component. What if my component is in another file? What if I want to use a field with a different name? Is there a better way to pass values to a component?

From the derby documentation: 

> Literal values or variable values can be passed to components. These component attributes are available through “macro” template tags, which have triple curly braces. 

What does that look like? Again, from the docs: 

``` html
<Body:> 
	<h1>
		<app:greeting message="Hello">
	</h1> 
<greeting:> 
	I was passed this message as an attribute: {{{message}}} 
```

 You can also pass html to your component as well. That is a two-part trick: First, write your component with an opening and closing tag. Put the value you want to pass to your component between the tags. Then, in your component, you use the special triple-curly bracket {{{content}}} macro-tag to reference what you passed in. For example: 

``` html
<Body:>
  <app:fancyButton>
    <b>Click me now!</b>
  </app:fancyButton>
 
<fancyButton: nonvoid>
  <button class="fancy">
    {{{content}}}
  </button>
```

## But I already knew all that. How do I make a component?

The easiest way is to just add the component to your page, as show in the simple example above. This example is taken from the derby website, and it shows you how to reference a component in a separate file: 

### shared.html

#### (This is your component, which is located in your views folder.)


``` html
 <profile:> <div class="profile">...</div> 
```

### home.html

#### (This is the view that will use your component.)

``` html
	<!-- This line imports your component into the view -->
	<import: src="shared">
	 
	<Body:>
	  Welcome to the home page
	  <!-- include component from an imported namespace -->
	  <app:shared:profile>
```

 The <import> ``tag at the top, used to include your component into your view, can be called with variety of parameters. For more information on the  <import> `` tag go to <http://derbyjs.com/#importing_templates>. 

## Didn't you say something about Twitter Bootstrap?

Oh yeah. Got sidetracked there. As you can see, creating a component is relatively easy. Since I already have all the Twitter Bootstrap markup ready, I might as well create a Twitter Bootstrap Component for Derby. To do this, all you have to do is figure out what you want to be able to customize. 

### boot.html


``` html
<input:>
{{{#with data}}}
  <div class="control-group {{cssClass}}">
    <label class="control-label">{{label}}</label>
    <div class="controls">
      <input type="{{type}}" value="{{value}}" />
      <span class="help-inline">{{message}}</span>
    </div>
  </div>
{{{/}}}
```

 As you can see, I added bindings for `{{cssClass}}, {{label}}, {{type}}, {{value}}, and {{message}}`. Why did I use a #with block to set the scope of my object being passed in? There is a bug in the derby code right now (documented [here](https://github.com/codeparty/derby/issues/138)) where you can't reference an object's child properties with the triple curly brackets syntax. So {{{data}}} will work, but {{{data.value}}} won't. The object being bound to the component: 
 
``` js
var data = function(value, label, type) {
    this.label = label;
    this.value = value;
    this.message = "";
    this.cssClass = "";
    this.type = type || "text";
};
```

 And I call it in my view like this: 
``` html
 <app:boot:input data="{:person.firstName}"> 
```

 Where `firstName` is an object like `data` described above. So, in a just a little bit of markup and code, I have a great reusable component that I can use to style the look and feel of my application without having to copy and paste code everywhere. I hope this it helps some of the fledging Derby developers out there.