class AddDetailsToCats < ActiveRecord::Migration
  def change
    add_column :cats, :details, :hstore
  end
end
