### API documentation

To encode a url

```curl
curl -H "Content-Type: application/json" -X POST\
     -d '{"original_url": "google.com"}'\
      http://localhost:3000/encode
```

To decode a url

```curl
curl -H "Content-Type: application/json" -X GET\
      http://localhost:3000/decode/{hash}
```

### How to run Locally

Adjust the `database.yml` file as needed

```ruby
# run the following command to db:create, db:schema:load and db:migrate
rake bootstrap
```

Then start server

```ruby
rails server
```

To run spec

```ruby
bundle exec rspec
```

### How to run on Docker

First, build the docker images

```ruby
docker-compose build
```

Bootstrap the database

```ruby
# For development env
docker-compose run url_shortener_app rake bootstrap

# For test env
docker-compose run url_shortener_test rake bootstrap
```

Then start server

```ruby
# It will run on port 3000
docker-compose up
```

To run Spec

```ruby
docker-compose run url_shortener_test rspec
```
