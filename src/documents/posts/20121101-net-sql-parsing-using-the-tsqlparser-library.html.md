```
title: .Net SQL Parsing - Using the TSqlParser library
link: http://codetype.wordpress.com/2012/11/01/net-sql-parsing-using-the-tsqlparser-library/
author: mablair2
description:
post_id: 458
created: 2012/11/01 18:01:34
created_gmt: 2012/11/01 10:01:34
comment_status: open
post_name: net-sql-parsing-using-the-tsqlparser-library
status: publish
layout: post
```

# .Net SQL Parsing - Using the TSqlParser library

As a bit of a preface to this post: it is hard to find a free SQL Parser for .NET. There is a company that has a terrible library that they charge $150 bucks for. There are a couple of incomplete implementations done for school projects or for narrowly focused tasks. So if you want a no-strings attached free parser for SQL, you're out of luck. However, since most people who want a .NET parser are writing code on a Windows machine, and use Visual Studio, there is (lightly documented) hope: the TSqlParser library that ships with Visual Studio.

This is a fully featured parsing library for SQL Server SQL syntax. I'm not sure about the support of other DB's SQL syntax, but I would imagine it's poor. On an x64 Windows machine, using Visual Studio 2010, the dll's which contain the TSqlParser library are located at: `C:\Program Files (x86)\Microsoft Visual Studio 10.0\VSTSDB` The class `TSql100Parser` in `Microsoft.Data.Schema.ScriptDom.Sql` gets you the parser for Sql Server 2008. To instantiate an instance of the `TSql100Parser` class, you have to supply the constructor with one parameter:

``` cs
 public TSql100Parser(bool initialQuotedIdentifiers )
```

 The docs for this are better than trying to figure out what `initialQuotedIdentifiers` means:

> Specifies whether quoted identifier handling is on.

I'm guessing this has to do with declaring aliases for columns like this:

``` sql
select bar as 'This is the alias for foo.bar' from tblFoo \--instead of like this: select bar as [This is the alias for foo.bar] from tblFoo
```

 Using the parser is relatively simple. Once you reference the correct dll's in your project:

``` cs
 var parser = new TSql100Parser(true);
 var script = parser.Parse(reader, out errors) as TSqlScript;
 foreach (TSqlBatch batch in script.Batches) {
  foreach (TSqlStatement statement in batch.Statements) {
    //At this point, you have a collection of SQL Statements...
    //that can contain collections of SQL Statements...
  }
}
```

 My comment in the code above is to help you understand something about parsing SQL - almost every relationship is expressed as a tree, where something contains more of the same thing, and that thing may contain more of the same thing, or maybe not. Which means the easiest way to navigate the data is recursively. In other words, the Rules for using TSqlParser:

  1. LEARN TO LOVE THE RECURSION.
  2. Refer to the Rules for using TSqlParser

I'll give you an example scenario to show you what you're up against. One common scenario is searching your code for SELECT statements. Select statements can be contained in:

  * Stored Procedures
  * If Statements
  * While Statements
  * BEGIN statements
  * Try/Catch Blocks

I'm sure I'm missing some cases. So it's not as simple as saying "give me all the statements that are select statements". Instead, you have to write something like:

``` cs
    function ProcessStatements(statements)

        foreach(statement in statements)
            if statement is a Stored Procedure
               ProcessStatements(statement.MyStatements)
            if statement is an If Statement
               ProcessStatements(statement.MyStatements)
            if statement is a While Statement
               ProcessStatements(statement.MyStatements)
            if statement is a Select Statement
               ProcessSelect( statement)
```

So once you get your select statement (or your collection of select statements), how do you process them? Well unfortunately it's not straightforward. The `SelectStatement` class contains a field called `QueryExpression` \- this field contains what kind of Select we're dealing with. As far as I can determine, there are three types of QueryExpressions:

  * QuerySpecification

This is an actual SELECT statement

  * BinaryQueryExpression

This is a UNION or similar expression between two SELECT statements

  * QueryParenthesis

This is a SELECT surrounded by parenthesis. In other words, a sub-select

So again, if you only want SELECT statements, you have to weed through the three types of QueryExpressions until you get to the underlying SELECT statements. So eventually you'll get to a list of QuerySpecifications (which represent the SELECT statements from your original query). Now here comes the good stuff: you can now weed through the SELECT fields programmatically and get out whatever information you want. Here are some of the fields on `QuerySpecification`:

    |FromClauses|     Gets a list of FROM clauses.|
    |GroupByClause|   Gets or sets a GROUP BY clause.|
    |HavingClause|    Gets or sets a HAVING clause.|
    |Into|            Gets or sets the into table name.|
    |SelectElements|  Gets a list of the selected columns or set variables.|
    |TopRowFilter|    Gets or sets the usage of the top row filter.|
    |UniqueRowFilter| Gets or sets the unique row filter value.|
    |WhereClause|     Gets or sets a WHERE clause.|

Just tons of SELECT goodness. However, be warned: each of these fields contains lists with multiple subclasses. So more recursive diving if you want to get something very specific out of this select data. To get farther you might have to dive into the docs. [Link to MSDN Namespace Docs](http://msdn.microsoft.com/en-us/library/dd194286\(v=vs.90\).aspx)