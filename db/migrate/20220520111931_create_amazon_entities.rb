class CreateAmazonEntities < ActiveRecord::Migration[7.0]
  def change
    create_table :amazon_entities do |t|
      t.string :amazon_id
      t.integer :amount
      t.timestamp :entry_date
      t.timestamps
    end
  end
end
