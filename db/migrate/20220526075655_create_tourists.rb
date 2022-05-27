class CreateTourists < ActiveRecord::Migration[7.0]
  def change
    create_table :tourists do |t|
      t.string :place_name
      t.float :latitude
      t.float :longitude
      t.string :address
      t.string :notice

      t.timestamps
    end
  end
end
