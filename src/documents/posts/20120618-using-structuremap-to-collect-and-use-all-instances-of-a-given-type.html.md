```
title: Using StructureMap to collect and use all instances of a given type
link: http://codetype.wordpress.com/2012/06/18/using-structuremap-to-collect-and-use-all-instances-of-a-given-type/
author: mablair2
description:
post_id: 98
created: 2012/06/18 14:27:41
created_gmt: 2012/06/18 06:27:41
comment_status: open
post_name: using-structuremap-to-collect-and-use-all-instances-of-a-given-type
status: publish
tags: post, development, software, web, html, JavaScript, CoffeeScript, C#, .NET
layout: post
```

# Using StructureMap to collect and use all instances of a given type

Had an issue at work where I wanted to store my rules and handlers for a class outside of the class definition, so I could better test the component. Found an easy way to add all your rules into [StructureMap](http://docs.structuremap.net/), and then retrieve those rules as a list via constructor injection.

``` cs
using System.Collections.Generic;
using System.Linq;
using System.Text;
using StructureMap;
using StructureMap.Configuration.DSL;

public class TravelRegistry : Registry
{
    public TravelRegistry()
    {
        For<ITransportHandler>().Add<ApprovedAccommodationHandler>();
        For<ITransportHandler>().Add<ApprovedCharterFlightHandler>();
        For<ITransportHandler>().Add<ApprovedCommercialFlightHandler>();
        For<ITransportHandler>().Add<ApprovedGroundTransportHandler>();

        For<IEnumerable<ITransportHandler>>().Use(x => x.GetAllInstances<ITransportHandler>());

        For<ITravelRule>().Add<StartLessThanEndRule>();
        For<ITravelRule>().Add<CurrentEndsAfterPreviousRule>();
        For<ITravelRule>().Add<CurrentStartAfterPreviousEndRule>();
        For<ITravelRule>().Add<UniqueEndsRule>();
        For<ITravelRule>().Add<UniqueStartAndEndRule>();
        For<ITravelRule>().Add<UniqueStartsRule>();

        For<IEnumerable<ITravelRule>>().Use(x => x.GetAllInstances<ITravelRule>());

    }
}
```

