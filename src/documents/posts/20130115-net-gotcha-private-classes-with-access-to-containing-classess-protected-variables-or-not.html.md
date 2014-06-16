```
title: .Net Gotcha - Private Classes With Access To Containing Classes's Protected Variables (Or Not)
link: http://codetype.wordpress.com/2013/01/15/net-gotcha-private-classes-with-access-to-containing-classess-protected-variables-or-not/
author: mablair2
description:
post_id: 532
created: 2013/01/15 12:57:56
created_gmt: 2013/01/15 04:57:56
comment_status: open
post_name: net-gotcha-private-classes-with-access-to-containing-classess-protected-variables-or-not
status: publish
tags: post, development, software, coding, web, html, JavaScript, CoffeeScript, EMCAScript, C#, .NET
layout: post
```

# .Net Gotcha - Private Classes With Access To Containing Classes's Protected Variables (Or Not)

A friend and I were working on some code together when we found an interesting edge case in .Net that neither of us knew about. This is what we knew: if you have a class with a protected field in it, if you declare a private class inside of that class, the private class can access the protected variable. The example below shows what this looks like.
``` cs
 public class ParentClassWithProtectedField {
 	protected readonly int protectedField;
 	private class PrivateClassInParentClass {
 		public void Method(ParentClassWithProtectedField parent) {
 			Console.WriteLine(parent.protectedField); //Me Work Good!
 		}
 	}
 }
```

 And this is what we learned: If you create a child class that inherits from the parent class, and declare another Private class in the child class, you cannot access the parent's protected field from the private class in the child class. I know that was a ton of Parent/Child/Private classes in a short sentence, so here's an example, building on the previous one, of what won't work in .NET.

``` cs
 public class ChildClassOfParentClass : ParentClassWithProtectedField {
 	private class PrivateClassInChildClass {
 		public void Method(ParentClassWithProtectedField parent) {
 			Console.WriteLine(parent.protectedField); // NO WORK!
 		}
 	}
 }
```

