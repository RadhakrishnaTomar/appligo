# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Install Docker

* Create .env file on your local & set enviornment variables mentioned in database.yml

* Then run command
```
docker-compose up --build
```

* Run migration once docker compose is up
```
docker-compose exec web bundle exec rails db:migrate 
```

* Run seed once docker compose is up
```
docker-compose exec web bundle exec rails db:seed
```