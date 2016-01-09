```
title: Upgrade your Open Source work to use Node 4
description: Upgrading Travis to work with Node 4
created: 2015/09/10 04:11:00
post_name: upgrade-travis-and-OS-for-node-4
status: publish
tags: post, development, software, coding, javascript, function, decoupling, state, this, global, decompiled
layout: post
```

Now that [Node 4 has been released](https://nodejs.org/en/blog/release/v4.0.0/), isn't it time you upgraded your OS (Open Source) projects to use it?

## Step 1 - package.json

If you're not already using it, the [engines](https://docs.npmjs.com/files/package.json#engines) field in your `package.json` allows you to specify what version of node you designed your package to run on. The `engines` field is not strict - you can't force your consumers to use a preferred engine, but you can warn them if your package uses features that aren't available in all version of node.

Most people won't need to upgrade this to use Node 4, but it's good to be aware of.

## .travis.yml

I use [travis](https://travis-ci.org/) to build and test my open source projects. To get my OS work running on thew new version of node, I needed to update my `.travis.yml` files to specify the new version of node.

The first part was easy:

```
node_js:
  - "4"
```

I pushed my travis change, and I was hoping for a big fat green build message. Not so fast. Errors.

Long story short - to compile native modules in Node 4, you need a C++ compiler. Luckily you can configure travis to use one.

Add the following to your `.travis.yml` files

```
env:
  - CXX=g++-4.8
addons:
  apt:
    sources:
      - ubuntu-toolchain-r-test
    packages:
      - g++-4.8
```

BOOM!!! Big green build. Hope this helps folks out there.

