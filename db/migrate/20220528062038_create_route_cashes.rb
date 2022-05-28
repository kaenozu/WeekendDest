class CreateRouteCashes < ActiveRecord::Migration[7.0]
  def change
    create_table :route_cashes do |t|
      t.string :src
      t.string :dest
      t.float :highway
      t.float :localway
      t.timestamps
    end
  end
end
