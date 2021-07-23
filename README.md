[![CircleCI](https://circleci.com/gh/uhhuhyeah/bulletin_shortener_api.svg?style=svg)](https://circleci.com/gh/uhhuhyeah/bulletin_shortener_api)


# README

## Commentary
Hello!
This codebase is for the Bulletin Takehome. The ask was to build a JSON API for shortening URLs.
The codebase doesn't represent production-level, high-scale/high availability readiness. I don't think that's appropriate to attempt in a take home exercise like this. And even so, there's no information about what type of deployment environment or traffic demands it would face and so any attempt ompimize on that would be woefully premature.

Instead, this codebase represents an excellent point to meet with the business owner/product owner and talk through what has been built. Does this correctly embody the features and functionality you wanted? Have a play with it. Does it behave in the way you expect? Did you find a way to break it? Once this API does meet your criteria, what is next? Does it need to integrate with other services that you're running. The requirements doc said not to worry about user authentication, but is that "for now" or "forever"?
In the real world, I'd like to have that conversion and then take that feedback and incorporate it. Getting a peer review will also be an excellent thing to do prior to calling this "done".

A couple of tradeoffs I wanted to call out:
* One requirement was that "time since creation" be included in the JSON response. 
    * There's no details about how that is expected to look. Is that time in words ("3 hours ago"), or number of milliseconds? I made the assumption that time in words is probably right.
    * Relatedly, I built the JSON Index response by leveraging what the Rails framework provides out of the box (being pragramitic about time vs effort), but the "time since creation" pushes what we can do with that. Given more time, I would create a JSON presenter layer instead of using the built in `.as_json` helper. This will enable us to a) keep view logic out of the model class, b) provide us with a more extendable and modifiable codebase for customizing the JSON response.
* It's theoretically possible that a new URL will fail to save in the event that the randomly generated `slug` matches that of one already in the database for a different URL. I designed it to fail in that circumstance as the client getting a failure and having to retry their request was a better experience in my mind to allowing two or more shortened URLs share a slug! 
    * Given more time, it would be trivial to add in a retry control flow that the client wouldn't even be aware of


## Rails
I used Rails because it's very easy to build and prototype things. It comes with out-of-the-box support for databases with seamless ORMs. It provides easy support for writing automated tests. It integrates JSON quite tightly. As a web framework it supports the type of work we're doing here. 

## Running Locally

### Setup
* Checkout this repository `git clone git@github.com:uhhuhyeah/bulletin_shortener.git` and `cd` into the root directory of the project
* It was built with the current version of Ruby, version `2.6.3`, so please instal that.
* To manage the dependencies, we'll want to install `bundler` with `gem install bundler`. After that has installed, run `bundle install`
* To set up the test and development databases, run `bundle exec rake db:migrate:` and `bundle exec rake db:migrate RAILS_ENV=test`

### Tests
Test status on Circle CI:
[![CircleCI](https://circleci.com/gh/uhhuhyeah/bulletin_shortener_api.svg?style=svg)](https://circleci.com/gh/uhhuhyeah/bulletin_shortener_api)


You should now be able to run the automated tests and verify the setup.
* `bundle exec rspec`

If it worked, you should see something like
```
Finished in 0.16718 seconds (files took 0.80916 seconds to load)
12 examples, 0 failures
```

### Running locally
To interact with the API locally, you just need to start the built in web server
* `bin/rails s` (or `bin/rails server`)
You should see some output about "Booting Puma". You can interact with the API on `localhost:3000` or `127.0.0.1:3000`.

## API

### Creating a shortened Link
Send a POST request to `/links` providing the URL you want to save as a `url` param.
Eg
```
curl --header "Content-Type: application/json" \
  --request POST \
  --data '{"url":"http://bulletin.co/something"}' \
  http://localhost:3000/links
```

### Retriving all shortened Links
Send a GET request to `/links`
Eg
```
curl --header "Content-Type: application/json" \
  http://localhost:3000/links
```

### Request long Link for a given shortend URL
Given a shortedn URL (a `slug`) of `'abcd`, send a GET request to `/s/abcd`
Eg (have curl follow the redirect with `-L` or `--location`)
```
curl --header "Content-Type: application/json" \
  --location \
  http://localhost:3000/s/abcd
```

Eg (have curl show you the redirect with `-I` or `--head`)
```
curl --header "Content-Type: application/json" \
  --head \
  http://localhost:3000/s/abcd
```
