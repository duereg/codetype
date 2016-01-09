[![Build Status](https://travis-ci.org/duereg/codetype.svg)](https://travis-ci.org/duereg/codetype)
[![Dependencies](https://david-dm.org/duereg/codetype.svg)](https://david-dm.org/duereg/codetype)
[![devDependencies](https://david-dm.org/duereg/codetype/dev-status.svg)](https://david-dm.org/duereg/codetype#info=devDependencies&view=table)

## How to run my blog (not sure why you'd want to)

1. [Install DocPad](https://github.com/bevry/docpad)

2. Clone the project and run the server

``` bash
git clone git://github.com/duereg/codetype.git
cd codetype
npm install
docpad run
```

3. [Open http://localhost:9778/](http://localhost:9778/)

## To Deploy

Make sure to set up the `target` remote to point at the `duereg.github.io` project:

`git remote add target https://github.com/duereg/duereg.github.io.git`

`npm run deploy`

