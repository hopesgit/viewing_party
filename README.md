# Viewing Party

## About This Project

Viewing party is an application in which users can explore movie options and create a viewing party event for themself and their friends. Create an account and browse for your favorite movies. Search for the most popular movies or for the specific movie you want.

## Credits and Attributions:
<img src="http://media.tumblr.com/6df8b0d6154a26601b9a3ef1c9662de7/tumblr_inline_mn2e2keoSG1qz4rgp.png" alt="build passing"/>

* Hosted on [Heroku](https://viewing-party-thj.herokuapp.com/)
* API data pulled from [The Movie Database API](https://www.themoviedb.org/documentation/api) (API used for educational purposes)
* Continuous integration provided by [TravisCI](travis-ci.com)
* Using Ruby 2.5.3 / Rails 5.2.4.3

## Team Members:

* Hope Gochnour | [GitHub](https://github.com/hopesgit) | [LinkedIn](https://www.linkedin.com/in/hope-gochnour-3056aa1ba/)
* Taylor Phillips | [GitHub](https://github.com/taphill) | [LinkedIn](https://www.linkedin.com/in/taylorscottphillips/)
* James Belta | [GitHub](https://github.com/JBelta) | [LinkedIn](https://www.linkedin.com/in/james-belta-93377b1b5/)

## Local Setup

1. Fork and Clone the repo
2. Install gem packages: `bundle install`
3. Setup the database: `rails db:{drop,create,migrate,seed}`

## Organization

* Tables:
  * Users
  * Friends
  * Movies
  * Events
  * Participants

## Current Functionality

* User Login/Logout/Register
* Users can add friends (done from the dashboard page once you log in)
  * As of right now, searching using a user's email address will add them to your friends list and vice-versa with no confirmation from the invitee.
* Dashboard page:
  * Adding friends (see above)
    * Friends will be listed on this page once added
  * View Viewing Parties that you're either hosting or invited to
  * View a list of upcoming movies
  * Search for movies
    * Can look for Top Rated movies (top 40 according to The Movie DB)
    * Can search for movies by title keywords (top 40 search results from TMDB)
    * Clicking on a movie's title brings user to a page with more information about that movie
* Movie show page:
  * Has information including:
    * Title
    * Runtime
    * Genres
    * Cast members (up to 10) and their roles in the movie
    * Reviews for the movie
    * Related movies that you might like
  * Has a button to create a watch party for this movie
* New Watch Party page
  * Choose a date/time and duration (can't be shorter than the movie's length)
  * Choose friends to invite (they have to already be registered as your friends)

## Challenges/What We Learned

* [Self-referential relationships](misc/screenshots/Screen Shot 2020-12-09 at 10.53.40 PM.png)
