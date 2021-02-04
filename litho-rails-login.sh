#!/bin/bash

project_name=""
last_arg=""
for arg in "$@"
do
    if [[ $arg == "-h" ]] || [[ $arg == "--help" ]] || [[ $arg == "help" ]] || [[ $arg == "-?" ]]; then
        echo "Usage of litho-rails-login"
        echo "cd into the project root directory and run this script."
        echo "litho-rails-login.sh -n ProjectName"
    fi
    if [[ $last_arg == "-n" ]]; then
        project_name=$arg
    fi
    
    last_arg=$arg
done

rails new $project_name --api --database=postgresql
cd $project_name

git add .
git commit -m "after rails new --api"

bundle add bcrypt
bundle add jbuilder

bundle add axe-matchers --group "development, test"
bundle add bullet --group "development, test"
bundle add bundler-audit --group "development, test"
bundle add rspec --group "development, test"
bundle add factory_bot_rails --group "development, test"
bundle add gnar-style --group "development, test"
bundle add json_matchers --group "development, test"
bundle add pronto-brakeman --group "development, test"
bundle add pronto-rubocop --group "development, test"
bundle add pry-byebug --group "development, test"
bundle add pry-rails --group "development, test"
bundle add rspec-its --group "development, test"
bundle add rspec-rails --group "development, test"
bundle add shoulda-matchers --group "development, test"
bundle add simplecov --group "development, test"

bundle install

rails g model User email first_name last_name password_digest api_key

SCRIPT_DIR=`dirname "$BASH_SOURCE"`
echo $SCRIPT_DIR

echo "default: &default" > ./config/database.yml
echo "  adapter: postgresql" >> ./config/database.yml
echo "  pool: <%= ENV.fetch(\"RAILS_MAX_THREADS\") { 5 } %>" >> ./config/database.yml
echo "  database: <%= ENV['DATABASE_NAME'] %>" >> ./config/database.yml
echo "  username: <%= ENV['DATABASE_USERNAME'] %>" >> ./config/database.yml
echo "  password: <%= ENV['DATABASE_PASSWORD'] %>" >> ./config/database.yml
echo "  host: <%= ENV['DATABASE_HOST'] %>" >> ./config/database.yml
echo "  port: <%= ENV['DATABASE_PORT'] %>" >> ./config/database.yml
echo "  timeout: 5000" >> ./config/database.yml
echo "" >> ./config/database.yml
echo "development:" >> ./config/database.yml
echo "  <<: *default" >> ./config/database.yml
echo "  database: db/${project_name}_development" >> ./config/database.yml
echo "" >> ./config/database.yml
echo "test:" >> ./config/database.yml
echo "  <<: *default" >> ./config/database.yml
echo "  database: db/${project_name}_test" >> ./config/database.yml
echo "" >> ./config/database.yml
echo "production:" >> ./config/database.yml
echo "  <<: *default" >> ./config/database.yml
echo "  database: db/${project_name}_production" >> ./config/database.yml

cp -r "$SCRIPT_DIR/rails/config/routes.rb" ./config/routes.rb

cp -r "$SCRIPT_DIR/rails/controllers/" ./app/controllers/

cp -r "$SCRIPT_DIR/rails/models/user.rb" ./app/models/user.rb

cp -r "$SCRIPT_DIR/rails/views/" ./app/views/

cp -r "$SCRIPT_DIR/rails/spec" .

rake db:create
rake db:migrate

rspec

rm -rf test
