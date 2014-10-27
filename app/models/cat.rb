class Cat < ActiveRecord::Base
  store_accessor :details, :family, :neutered, :age

  validates_presence_of :family
end
