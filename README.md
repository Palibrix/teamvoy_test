# README

## What is this?

This is a test task for a Ruby trainee position at Teamvoy.

## What is it about?

I'm given a JSON with programming languages data. My goal is to make it searchable.
[Here is my objectives and requirements](https://gist.github.com/g3d/d0b84a045dd6900ca4cb).

## How to start?

Firstly, clone this project:
- `git clone https://github.com/Palibrix/teamvoy_test.git`
- `cd teamvoy_test`

There is no additional gems, but run this anyway:
- `bundle install`

Finally. start the server:
- `rails server`

## How it works
The SearchController has two main methods: index and search.

The index method fetches live data from a remote JSON file and transforms the data to lowercase. 
It also retrieves the search query from the parameters and passes the data and the query to the search method.

The search method takes the data and the query as arguments. 
It splits the query into terms and filters the data based on these terms. 
Each entry is given a score based on how well it matches the terms. Also "B" will have higher score than "Bash", if you search it directly
The method then groups the entries by their scores and returns the groups, which then processed by view.

## JavaScript

Not my cleanest part, I think. I created function showPage, that will divide big results into groups of 10 for a page. 
Imagine scrolling all 71 results, when you typed "B" in the search☠️.

Also I added hover feature, so you will see all language data only when your mouse 
(generally it is little triangle with a tail on your screen) is over it's name.


## Common questions:
1. Is everything done? - I supposed so
2. Tea or coffee? - Of course, tea. Why would you even ask?
3. Cats or dogs? - Meow
