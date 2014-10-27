class Cat < ActiveRecord::Base
  store_accessor :details, :family, :neutered, :age

  validates_presence_of :family

  def neutered
    super == 'true' or super == true
  end
end
