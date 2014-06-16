```
title: Enable/Disable jQuery buttons in Knockout with a Custom Binding Handler
link: http://codetype.wordpress.com/2011/10/21/enabledisable-jquery-buttons-in-knockout-with-a-custom-binding-handler/
author: mablair2
description:
post_id: 41
created: 2011/10/21 12:40:39
created_gmt: 2011/10/21 04:40:39
comment_status: open
post_name: enabledisable-jquery-buttons-in-knockout-with-a-custom-binding-handler
status: publish
tags: post, development, software, web, html, JavaScript, CoffeeScript, C#, .NET
layout: post
```

# Enable/Disable jQuery buttons in Knockout with a Custom Binding Handler

Still working on those jQuery buttons. Trying to update old ASP.Net Webforms using jQuery, Knockout, and Amplify.

New problem today.

I was having problems getting Knockout to enable/disable my jQuery buttons using the Knockout 'enable' bindingHandler. It would enable/disable the underlying element that I had run the .button() method on, but it had no idea about the div that jQuery had wrapped my element in, or how to handle it.

I wrote a custom bindingHandler for Knockout to handle this case. It also can handle non-jQuery elements as well, so you could change the declaration from 'jEnable' to 'enable', and this would work as a all-comers enable function.

Since this method uses jQuery (and is more expensive than the plain old 'enable'), I figured the extra binding was the best approach.

``` js
	if (ko && ko.bindingHandlers) {
		ko.bindingHandlers['jEnable'] = { 'update': function(element, valueAccessor) {
				var value = ko.utils.unwrapObservable(valueAccessor());
				var $element = $(element);
				$element.prop("disabled", !value);
				if ($element.hasClass("ui-button")) {
					$element.button("option", "disabled", !value);
				}
			}
		};
	}
```

 An example on how to use this:
``` html
	<input id="btnToEnable" type="button" data-bind="jEnable: isEnabled" />
	<script>
		$("#btnToEnable").button();
		var viewModel = { isEnabled: ko.observable(true) };
		ko.applyBindings(viewModel);
	</script>
```

 A gist of this code is [here](https://gist.github.com/4023196).
