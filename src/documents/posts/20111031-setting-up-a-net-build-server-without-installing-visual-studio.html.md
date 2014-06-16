```
title: Setting up a .NET build server WITHOUT installing Visual Studio
link: http://codetype.wordpress.com/2011/10/31/setting-up-a-net-build-server-without-installing-visual-studio/
author: mablair2
description:
post_id: 79
created: 2011/10/31 13:54:07
created_gmt: 2011/10/31 05:54:07
comment_status: open
post_name: setting-up-a-net-build-server-without-installing-visual-studio
status: publish
tags: post, development, software, web, html, C#, .NET, Visual Studio, Build, Server, continuous deployment, deployment
layout: post
```

# Setting up a .NET build server WITHOUT installing Visual Studio

My client tasked me with upgrading their build server. Today, their platform builds VS 2080 solutions in .NET 3.5 - and I've been pushing to upgrade everyone to Visual Studio (VS) 2010 and eventually .NET 4.0. I want to upgrade the server to build a VS 2010 solution in .NET 3.5.

This will allow everyone to upgrade to VS 2010 while leaving the task of upgrading the production web servers to another day. I tried the easy approach. I install .NET 4.0 on the build server and run the MSBuild scripts that already exist. Nothing good happens.

I do a little digging and find out that you need to install the Windows SDK to get MSBuild to work. I get the Windows SDK - [Microsoft Windows SDK for Windows 7 and .NET Framework 4](http://www.microsoft.com/download/en/details.aspx?id=8279) \- and install it. Nothing good happens.

I dig a little further and find out that by default MSBuild installs pointing at the VS version of the Windows SDK whether it is there or not. Also, the Windows SDK does not care about the settings of MSBuild, so when you install the SDK it doesn't fix this or update this. Which I understand from the SDK team's point of view, but it would have been a nice fix.

![Registry View of the MSBuild Settings for .NET 4.0](/images/posts/registry-msbuild.jpg)

The important thing to note is the keys which have "7.0a" in their values. 7.0a is the version of the Windows SDK that ships with Visual Studio 2010. If you download the SDK from Microsoft you get version 7.1. I go in and manually change all those 7.0a to 7.1. It builds! But it fails.

For some reason, I can't get any of the XmlSerializers dll (web projects that have web services or WCF need these) to generate correctly. The normal dll's compile into .NET 3.5 versions (which is what I want), but the XmlSerializers dlls all generate in .NET 4.0. What's going on here? Another bug.

The Windows SDK installer, by default, installs the WRONG keys into the registry. This apparently only affects certain edge cases, like trying to generate XmlSerializer dll's with MSBuild from .NET 4.0 into .NET 3.5. I'm guessing the Visual Studio installer fixes this when it runs. The issue is documented here: [Windows 7.1 SDK targeting .NET 3.5 generates wrong embedded Resources](http://connect.microsoft.com/VisualStudio/feedback/details/594338/tfs-2010-build-agent-and-windows-7-1-sdk-targeting-net-3-5-generates-wrong-embedded-resources).

So, another trip to the registry. This time, to the Microsoft-SDKS section. There are two bugs here:

1)  All the keys need to have a dash after the "WinSDK" portion
2)  Some of the fields have an "-86" in their key, which needs to be "-x86"
![A view of the registry for the Windows SDK](/images/posts/registry-windows-sdk.jpg)

One more try. Build successful. :)

### Valuable Old Comment Note:

**[Antek](#109 "2013-10-10 04:00:32"):** Unfortunately the changes in the MsBuild/ToolVersions/4.0 section can (and will) be lost when .NET patches are applied through Windows Update.

