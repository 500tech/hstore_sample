# Hstore with Rails 4

## Installation

New rails project

    rails new hstore

Move to Postgres

Add ```gem "pg"``` to your ```Gemfile```

    bundle update

Update ```config/database.yml```

    development:
      adapter:  postgresql
      database: hstore_test
      username: ?
      password: ?

Create the database

    rake db:create

Enable Hstore

    rails g migration enable_hstore

Edit the created migration file to be:

    def up
      enable_extension :hstore
    end

    def down
      disable_extension :hstore
    end

Mirate the DB

    rake db:migrate


## Create sample Model

Create Cat model

    rails g model Cat name:string
    rake db:migrate

And a sample cat

    rails c
    > Cat.create! name: 'Kipi'

## Add Hstore column

Create migration

    rails g migration add_data_to_cats data:hstore
    rake db:migrate

Open up ```app/models/cat.rb```

    class Cat < ActiveRecord::Base
      store_accessor :details, :family, :neutered, :age
    end

In the console: ```rails c```

    cat = Cat.first

    cat.details
    => nil

    cat.details = { age: 100 }
    => {:age=>100}

    cat.details = { age: 100, family: 'Aegean' }
    => {:age=>100, :family=>"Aegean"}

    cat.family
    => "Aegean"

## Add some validations

Open up ```app/models/cat.rb```

    validates_presence_of :family

## Accessing boolean

Hstore is all strings

    def neutered
      super == 'true' or super == true
    end

## Query

    Cat.where("details -> 'family' = ?", 'Aegean').count
    => 1

    Cat.where("details -> 'age' = ?", 100)
    => Error

    Cat.where("details -> 'age' = ?", 100.to_s)
    => 1
