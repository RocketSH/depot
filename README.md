# Depot

I learned from *Agile Web Development with Rails 6* by Sam Ruby and David Bryant Copeland.

### Features:
 - Users may browse and check the introduction of each item/ product without login
 - Users may add an item to their own shopping cart after signing up and log in
 - Creating a new product needs an admin user
    - an admin account for testing
      > email: lllatia_hyatt@welch.com / password: qazwsx
 - Users may checkout their shopping cart and create an order after inputting all necessary information (payment always assumes succeeded)
 - Order email address will receive a notification email, subject: 'Świat Zabawek Store Order Confirmation')

### Main Gems:
 - `devise` for authentication
 - `sidekiq` for background processing
 - `shrine` for image attachment
 - `image_processing`, through this gem I can process images with either ImageMagick/GraphicsMagick or libvips libraries. 
 - `sendgrid-ruby` integrates Sendgrid email outbound service
 - `rspec` replaces mini-test
 - `capybara` achieves scenario tests, especially for Javascript function test

 - slightly played with `activeadmin` to have a basic understanding about backend interface for an admin user


### Dependencies:
 - local install `ruby 2.6.5` [Installation Method] (https://www.ruby-lang.org/en/documentation/installation/)
 - local install `rails 6.0.4`
 - local install `postgresql`
 - local install `yarn`
 - local install `redis` [Installing Redis] (https://redis.io/docs/getting-started/installation/)

### master.key
 Well, I can't share my key with the public, the AWS config can be skipped by adjusting `shrine.rb` to use ActiveStorage (please check rails guides), Sendgrid config can be skipped by using the `letter_opener` gem in the development environment.

 Or, you will need to run `EDITOR="vim" bin/rails credentials:edit` to create a new `master.key` and `credentials.yml.enc` in your local folder.

 Next, you need to generate your own account info from both sendgrid and aws. Also, save them in the below format into your rails credentials.
 ```
 sendgrid:
  username: 
  password: 
  email: 

 aws:
  access_key_id:
  secret_access_key:
  bucket_name: 
  region:
 ```

### Local Usage:
 - run `bundle install` to install all rails gems
 - run `yarn` to install all frontend dependecies
 - run `bin/rails db:create` to create two local databases, depot_development and depot_test (according to config/database.yml) 
 - run `bin/rails db:migrate` to config database tables, constraints and associations according to db/schema.rb
 - run `bin/rails db:seed` to feed the initial product, and user data for using the website immediately
 - run `sh booster.sh` that will run `redis-server`, `bin/webpack-dev-server`, `bin/rails server`, and `bundle exec sidekiq` at the same time automatically
 
 
 Voila, open localhost:3000 in your browser.
