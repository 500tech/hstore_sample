class Cat < ActiveRecord::Base
  store_accessor :details, :family, :neutered, :age
end
