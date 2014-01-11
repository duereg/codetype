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
layout: post
```

# Enable/Disable jQuery buttons in Knockout with a Custom Binding Handler

Still working on those jQuery buttons, trying to update old ASP.Net Webforms using jQuery, Knockout, and Amplify. New problem today. I was having problems getting Knockout to enable/disable my jQuery buttons using the Knockout 'enable' bindingHandler. It would enable/disable the underlying element that I had run the .button() method on, but it had no idea about the div that jQuery had wrapped my element in, or how to handle it. 

I wrote a custom bindingHandler for Knockout to handle this case. It also can handle non-jQuery elements as well, so you could change the declaration from 'jEnable' to 'enable', and this would work as a all-comers enable function. However, since this method uses jQuery (and therefore is much expensive than the plain old 'enable'), I figured the extra binding was the best approach. 

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

 A gist of this code is located [here](https://gist.github.com/4023196).

## Comments

**[soheil ashtiani](#6 "2012-04-24 21:26:10"):** Hi, I am new in knockout and sending this email from paris. i think this is exactly what i am looking for. i would like to make disable the button. It works well with out jquery ui, but can't make it disable with jquery ui buttons. I put your code in knockout.js file and tried nothing happened!!! Would u please tell me how should i do, Thank's Soheil.

**[Matt](#7 "2012-04-25 10:48:22"):** I have updated the post with an example that I hope will help you try this out.

**[joaovieirabr](#88 "2012-11-12 05:56:11"):** Hi, I had the same problem and your code solved-it. Many thanks

**[Joshko](#102 "2013-04-19 22:34:39"):** Hi, i had the same problem, but on IE9. Your solution helped me aswell. Many thanks.

