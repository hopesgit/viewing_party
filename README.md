# Viewing Party

## About This Project

Viewing party is an application in which users can explore movie options and create a viewing party event for themself and their friends. Create an account and browse for your favorite movies. Search for the most popular movies or for the specific movie you want.

## Credits and Attributions:

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

### Organization

* Tables:
  * Users
  * Friends
  * Movies
  * Events
  * Participants
