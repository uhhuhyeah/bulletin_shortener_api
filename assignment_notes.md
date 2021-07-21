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


 