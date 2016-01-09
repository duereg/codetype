```
title: Replaying changes from one git branch onto another
description: Replaying changes from one git branch onto another
created: 2015/02/16 02:16:20
post_name: git-replay-changes
status: publish
tags: post, development, software, coding, git, source control, branches, rebase, merge, replay, squash, commit, git-symbolic-ref, symbolic-ref
layout: post
```

## Or rebasing without rebasing

Where I work, we use git (like everyone else), and we follow this common pattern for development:

1.  Create a feature branch off of master
2.  Work on your feature in the branch
3.  When getting ready to submit a Pull Request, squash your commits
4.  Rebase master against your branch
5.  Open PR
6.  Get feedback
7.  After feedback corrected (if present), merge branch into master

Pretty standard practice. 99% of the time, this is a frictionless process.

The other day I picked up a story which, while small in scope, touched a ton of files.

### The path to failure

I created a branch, did the work, but never squashed my commits - I basically skipped step 3 - and tried to rebase master against my branch. I got the common enemy of every PR - merge conflicts.

### Compounding failure

I had 5+ commits in the branch. The idea of wading through multiple failing rebase steps left me queasy, so I abandoned the rebase and went to merge master.

So to add to my failure at step 3, now I had skipped step 4 as well.

After getting the code working I pushed my PR. I received some minor feedback, updated my code, and went to merge master again. More merge conflicts.

I fixed those conflicts, but now I had a convoluted history of un-squashed commits and two merges. This was both out of practice and felt sloppy.

### Finding a solution

When you have a messed up git history, you normally do a `git rebase --interactive`, fix your commit history, and move on.

But with the merges scattered between commits, an interactive rebase would be difficult.

It also won't give you what you want - a single commit.

### The solution

Enter [git symbolic-ref](https://git-scm.com/docs/git-symbolic-ref).

This command, while well documented, doesn't give away the true beauty of this command.

Hiding on this line is the heart of the command:

>  Given two arguments, creates or updates a symbolic ref <name> to point at the given branch <ref>.

What does this do? Let's say you're working on a sloppy branch. You want to carry over those changes onto another branch (like master), without changing the history of the that branch.

`git symbolic-ref HEAD refs/heads/master` sets the state of the current branch onto master. You haven't changed the history - git modifies the files on master to match the state of your branch. The commit history doesn't change. What this means is that doing something like this:

```
git checkout super-sloppy-work-branch
//this causes you to 'checkout' master, but with your current file changes from the sloppy branch
git symbolic-ref HEAD refs/heads/master
git checkout -b new-branch-that-is-great
git add -A
git commit -m 'I totally did this work in one pass'
```

Will give you a one-commit branch with all the work you did in the sloppy branch, but against the latest version of master. Pretty cool!









