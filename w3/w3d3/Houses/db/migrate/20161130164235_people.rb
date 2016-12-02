class People < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :name
      t.integer :age
      t.string :house
      t.timestamps
    end
  end


end
