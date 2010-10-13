class CreateDiningHalls < ActiveRecord::Migration
  def self.up
    create_table :dining_halls do |t|
      t.boolean :open
      t.string :meal
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :dining_halls
  end
end
