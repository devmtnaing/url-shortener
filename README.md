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

- phising, malewares and any kind of malicious links could get unknowingly accessed by end users via shortened url. The harmful link can hide behind the shortened_ur from any well-respected shortening url service providers. To mitigate this, service provider should implement background crwaling and flagging harmful links to ensure the removal of those malicious links from the system ASAP.
- Rate limit should be implemented especailly on creating shortened_urls so that we can control and prepare the storge load and url shortening logic to ensure we have enough for new urls.

### Scalability

- Track annonymous users via cookies and return the same existing hash for any long_url that has already been shortened by this particular user.
- I have already added database index on the shortened_urls so that `/decode` endpoint should be fast. However, If we have so much data and so many rquests, it would add up and become slow. I should add caching layer in that case. Preferable redis with Least Recently Used eviction mechanism.
- There is now a unique key for the shortened_url at database level, but now many users could endup failing to create shortened URLs due to inability to obtain unique key. Even unique key could be generated it would take a long time to generate one as database records start to grow. In that case, I should start pre-populating unique keys for daily use somewhere in the database and each request would lock one from that pool and mark it as used.
- When the service become to attrack facebook level traffic then the above solution would still work but require way better infra such as:
  - Load Balancers between client - server, server - database, server - cache server.
  - some pre-populated unique keys should also be moved from database level to memory level for even faster access
  - Database partitioning would become very crucial at this stage. They pre-populated unique keys can even rely on the partitioning logic of database.
  - With all that infra, reliabality and synchronization of those servers become the most importantance.

### CodeSubmit

Please organize, design, test and document your code as if it were going into production - then push your changes to the master branch. After you have pushed your code, you may submit the assignment on the assignment page.

All the best and happy coding,

The nami.ai Team
