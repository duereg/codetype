```
title: Auto Creation of jQuery Buttons using Knockout Templates
link: http://codetype.wordpress.com/2011/10/19/auto-creation-of-jquery-buttons-using-knockout-templates/
author: mablair2
description:
post_id: 59
created: 2011/10/19 17:14:56
created_gmt: 2011/10/19 09:14:56
comment_status: open
post_name: auto-creation-of-jquery-buttons-using-knockout-templates
status: publish
layout: post
```

# Auto Creation of jQuery Buttons using Knockout Templates

While converting ASP.NET Webforms to be more clienty using HTML 5, Knockout, and jQuery, I came across a problem.

I want to use jQuery buttons on my Knockout-rendered rows, but whenever a new row gets added via a template, the buttons were not created as jQuery buttons. The issue was that I was calling a method to create the buttons after the page was fully rendered but never again. All the new rows wouldn't have the .button method run on them, and thus no sparkly jQuery buttons.

What to do? I've got button markup that looks like this:

``` html
 <div class="jButton" data-icon-name="refresh" data-bind="click: refresh"> Refresh </div>
```

 And some existing code, that given an element with class "jButton" and optionally the data-icon-name set the icon you want, creates buttons out of divs. I saw one person handle this via a new binding on the button, but I didn't want to have to change to my existing template to get the behavior I was looking at.

 I tried a couple of different options, and while looking through the Knockout examples for other options came across the afterAdd option in the template binding. A quick change to my template binding:

``` html
 <tbody data-bind="template: {name:'rowCostItem', foreach: CostItems, afterAdd: function(elem) { var row = $(elem); Buttons.createFrom(row); }}">
```

 Now I get nice jQuery buttons for all my new rows. P.S. The heart of the Buttons.createFrom() method:

``` js
 var btn = $(this);
 var iconName = btn.data("iconName");

 if (iconName) {
 	btn.button({ icons: { primary: 'ui-icon-' + iconName} });
 } else {
 	btn.button();
 }
```

