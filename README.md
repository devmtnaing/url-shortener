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

### Details Instructions

Details instructions on how to run can be found under [GUIDE.md](GUIDE.md)

### Potential attack vectors

- phising, malewares and any kind of malicious links could get unknowingly accessed by end users via shortened url. The harmful link can hide behind the shortened_ur from any well-respected shortening url service providers. To mitigate this, service provider should implement background crwaling and flagging harmful links to ensure the removal of those malicious links from the system ASAP.
- Rate limit should be implemented especailly on creating shortened_urls so that we can control and prepare the storge load and url shortening logic to ensure we have enough for new urls.

### Scalability

- User oriented url shortening
- Save storage by tracking annonymous users via cookies and return the same existing hash for any long_url that has already been shortened by this particular user.
- Database index on the shortened_urls has already been added so that `/decode` endpoint should be somewhat faster to fetch.
  However, large traffic of read would still add up and slow down the response time in total, whereby putting too much workload on the database.
  In that case, caching layer would be a goto solution. Preferable redis with Least Recently Used eviction mechanism.
- Generation of unique_key could be improved alot. Current implementation has no retry mechanism. It will check uniqueness of the newly generated key unti it is actually unique to be saved in database. It could end up in request timing out and many database connetions being used up and occupied. Firstly, retry mechanism should be implemented.
  However, some users could still end up getting a API error message of not being able to obtain an unique key after a few retries which lead of bad user experience. In that case, based on the average write load of the system, we should be pre-populating unique keys in the database and each request would lock one from the pool and mark it as used.
- When the service become to attract facebook level traffic then the above solution would still work but require way better infra such as:
  - Load Balancers between client - server, server - database, server - cache server.
  - some pre-populated unique keys should also be moved from database to memory level for even faster access
  - Database partitioning would become very crucial at this stage. The pre-populated unique keys can even rely on the partitioning logic of the database. Server A would have database partation of say 0 - 1000000. Server A would have its own deticated caching layer and prepoluated unique keys should be moved to application server related database and cache servers.
  - With all that infra, reliabality and synchronization of those servers become the most importantance.

### CodeSubmit

Please organize, design, test and document your code as if it were going into production - then push your changes to the master branch. After you have pushed your code, you may submit the assignment on the assignment page.

All the best and happy coding,

The nami.ai Team
