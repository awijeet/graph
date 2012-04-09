class CreateReceipts < ActiveRecord::Migration
  def self.up
    create_table :receipts do |t|
      t.integer :receipt_id
      t.string :date      
      t.integer :location_id # TODO Here we could have some  relationship
      t.float :avg
      t.integer :q_1
      t.integer :q_2
      t.integer :q_3
      t.string :approved # TODO This can also be keept into another table and then association 
      t.timestamps
    end
  end

  def self.down
    drop_table :receipts
  end
end
