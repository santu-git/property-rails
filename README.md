# Ruby on Rails Property / Real Estate Portal App

A work in progress to learn ruby on rails

Ruby 2.2.0 or later
Rails 4.2.5
ImageMagick

Uses the following gems:

* dotenv-rails
* passenger
* devise
* geocoder
* bootstrap-sass
* will_paginate-bootstrap
* will_paginate
* nilify_blanks
* paperclip
* aws-sdk
* font-awesome-rails
* cocoon
* active_model_serializers
* pundit
* ckeditor

Will need a .env file created in the root of the application to run with the following keys:

* S3_BUCKET_NAME
* AWS_ACCESS_KEY_ID
* AWS_SECRET_ACCESS_KEY
* AWS_S3_HOSTNAME
* GOOGLE_MAP_API_KEY
* GOOGLE_MAP_API_REGION
* DEFAULT_DATABASE_USERNAME
* DEFAULT_DATABASE_PASSWORD
* (x)PRODUCTION_DATABASE_USERNAME
* (x)PRODUCTION_DATABASE_PASSWORD
* DEVELOPMENT_SECRET_KEY_BASE
* TEST_SECRET_KEY_BASE
* (x)PRODUCTION_SECRET_KEY_BASE

Run rake db:migrate to create database

Run rake db:seed to seed database with initial values

Tests run and are in Rspec. There is 99% coverage according to rcov. Currently I need to mock calls to Google geocoder as haven't yet and tests will cause over-limit requests to Google...
