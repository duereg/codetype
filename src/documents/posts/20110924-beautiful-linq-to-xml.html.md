```
title: Beautiful LINQ to Xml
link: http://codetype.wordpress.com/2011/09/24/beautiful-linq-to-xml/
author: mablair2
description:
post_id: 28
created: 2011/09/24 18:23:33
created_gmt: 2011/09/24 10:23:33
comment_status: open
post_name: beautiful-linq-to-xml
status: publish
tags: post, development, software, coding, LINQ, XML, C#, .NET,
layout: post
```

# Beautiful LINQ to Xml

Is there anything better in life than finding a better way to do something? An easier commute, a better night's sleep, a tastier cake recipe? In starting the Nike+ importer for www.runningahead.com, I knew I was going to have to deal with a bit of XML. Which used to mean XPath. Not so much anymore. LINQ to XML, you rock my world. It turns XML like this...
``` xml
 <extendedDataList>
 	<extendedData dataType="distance" intervalType="time" intervalUnit="s" intervalValue="10">
 		0.0, 0.0372, 0.0705, 0.1041, ....
 	</extendedData>
 	<extendedData dataType="speed" intervalType="time" intervalUnit="s" intervalValue="10">
 		0.0, 13.3866, 12.6856, 12.4970, ....
 	</extendedData>
 	<extendedData dataType="heartRate" intervalType="time" intervalUnit="s" intervalValue="10">
 		0, 88, 108, 115, ....
 	</extendedData>
 </extendedDataList>
```

 With a little bit of code like this:
``` cs
 work.Snapshots =
 	from n in extendedData.Elements("extendedData")
 	select 	new Workout.SnapShot {
 				DataType = n.Attribute("dataType").Value,
 				Interval = (int) n.Attribute("intervalValue"),
 				IntervalType = n.Attribute("intervalType").Value,
 				IntervalUnit = n.Attribute("intervalUnit").Value,
 				Intervals = n.Value.Split(',').Select(p => Convert.ToSingle(p.Trim())) };
```

 into something useful. The best part - no more XPath string literals in your code. 2nd best part - that (int) cast. That isn't really a cast - it's actually an indirect call to Convert.ToInt32. It parses the underlying value contained in the Attribute (or Element), then converts it into the correct type. That's the kind of coding magic I like.
