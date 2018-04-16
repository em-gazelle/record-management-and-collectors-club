Record Collection Management System:
* users can manage their records, allowing them to track record conditions, personal ratings, and favorites
* personalized recommendations for new records
* insights into highly rated, popular, and rare, but highly rated records
* artist analysis of records within users' collections

Application written in Rails 5 and Ruby 2.3.1 with a Postgres database.

Ensuring that Rails and Postgres are installed, create the Postgres databases found in `config/database.yml`. 

Add the following lines to `secrets.yml` with your personal postgres login settings:

    user: postgres_username
    password: postgres_password

Set up the application with `bundle install` and `rake db:create db:migrate db:seed`.

Run `rspec` to run tests

`rails s` to start the server

Application is authenticated with Devise. Create your own account, or use sample account:
user name:
password:

