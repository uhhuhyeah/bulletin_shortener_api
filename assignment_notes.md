# Bulletin Assignment

## Summary

Make a JSON API 
  - for shortening URLs
  - redirecting shortened URLs to their original URL
  - listing all shortened URLs
Include instructions for how to test and run the API locally

## Thoughts

- Use Rails? Easy development of JSON APIs, testing is well supported, DB ORMs out of the box.
- Requirements ask for standardized shortened URL. What does that mean? Generate shortened URLs of the same length?
- How many URLs should this support (matters for shortened URL lenght)
- For listing shortened URLs, will we need to paginate the response at some point?
- Need to generate the shortened URL in the request cycle

Schema thoughts
- Original, submitted URL
- shortened URL - which is probably just the path
- created_at timestamp
- What is this entity called? Links? They are shortened URLs/links/addresses. I'll go with Links for now.


 Setup notes
 - Ensure Ruby and Rails is installed
 - Checkout repo
 - gem install bundler
 - bundle install --path vendor/bundle
 - bin/rails db:migrate
 - bin/rails db:migrate RAILS_ENV=test
 - bundle exec rspec ./spec

 # Tradeoffs
 - In randomly generating a "slug" for the shortened URL, it is possible that the code
   will randomly generate a slug that's already in the db. The code _could_ handle this
   by rescuing from the non-unique error, but for the interests of time and simplicity 
   I've chosen to just allow the error to be raised