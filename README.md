### Objective

Your assignment is to implement a URL shortening service using Ruby. You can use any framework you want (or no framework at all, it is up to you).

### Brief

ShortLink is a URL shortening service where you enter a URL such as https://codesubmit.io/library/react and it returns a short URL such as http://short.est/GeAi9K.

### Tasks

- Implement assignment using:
  - Language: **Ruby**
  - Two endpoints are required
    - /encode - Encodes a URL to a shortened URL
    - /decode - Decodes a shortened URL to its original URL.
  - Both endpoints should return JSON
- There is no restriction on how your encode/decode algorithm should work. You just need to make sure that a URL can be encoded to a short URL and the short URL can be decoded to the original URL.
- Your application needs to be able to decode previously encoded URLs after a restart.
- Provide detailed instructions on how to run your assignment in a separate markdown file.
- Provide tests for both endpoints (and any other tests you may want to write).
- You need to think through potential attack vectors on the application, and document them in the README.
- You need to think through how your implementation may scale up, and document your approach in the README. **You do not need to build a scalable service for this challenge but you need to document how you would approach building a scalable version of it.**

### Evaluation Criteria

- **Ruby** best practices
- API implemented featuring a /encode and /decode endpoint
- Completeness: did you complete the features? Are all the tests running?
- Correctness: does the functionality act in sensible, thought-out ways?
- Maintainability: is it written in a clean, maintainable way?
- Security: have you thought through potential issues and mitigated or documented them?
- Scalability: what scalability issues do you foresee in your implementation and how do you plan to work around those issues?

### Potential attack vectors

### Saclability

### CodeSubmit

Please organize, design, test and document your code as if it were going into production - then push your changes to the master branch. After you have pushed your code, you may submit the assignment on the assignment page.

All the best and happy coding,

The nami.ai Team
