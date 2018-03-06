![Build Status](https://codeship.com/projects/cf55f960-0226-0136-96bd-4620837faf22/status?branch=master)
[![Maintainability](https://api.codeclimate.com/v1/badges/ffa43eb675b61a831d4b/maintainability)](https://codeclimate.com/github/jdmacmurtrie/sinatra-blackjack/maintainability)
[![Coverage Status](https://coveralls.io/repos/github/jdmacmurtrie/blackjack-by-dave/badge.svg?branch=master)](https://coveralls.io/github/jdmacmurtrie/blackjack-by-dave?branch=master)

# Blackjack by Dave

Blackjack by Dave is an exercise in OOP reworked into a Sinatra web app.  The original exercise was given as an assignment at Launch Academy, a web development bootcamp, and the transformation was begun as a side project in the precious free time during the program.  While it is still a work in progress, this project has been an excellent opportunity to teach myself how to use and test `sessions`, configure a Sinatra app to deploy to Heroku, and have a stab at more advanced CSS.

## Getting Started

In order to run this application locally, you must at least have Ruby 2.3.3 installed.
```
$ ruby -v
=> ruby 2.3.3
```

### Installing

This project uses `Bundler` as its dependency manager.  To install the necessary gems:
```
$ bundle
```

### Setting Up

In order to run the app in a development server, run the following command in your terminal:

```sh
$ ruby server.rb
```
Then, navigate to `localhost:4567`.


## The Test Suite

The automated testing system is run with RSpec, with some help from Capybara and some other minor testing Gems.
To run the test suite:
```sh
$ rspec
```
**NOTE:** RSpec may get stuck on a CSS selector on one of the feature tests.  This bug happens only on the first run of that particular test and then never again.  I am currently working on a fix for this.

## Deployment

This application is deployed using Heroku using these instructions: https://devcenter.heroku.com/articles/git

## Contributing

Submit a PR!  I'd love any and all constructive feedback.

## License

This project is licensed under the MIT License - see the [LICENSE.md](https://github.com/jdmacmurtrie/blackjack-by-dave/blob/master/LICENSE.md) file for details

## Acknowledgments

Thanks to Launch Academy, and especially to [Kylee Acker](github.com/kjoya) for giving me the tools to get this off the ground.
