class CreateSrcGeoCashes < ActiveRecord::Migration[7.0]
  def change
    create_table :src_geo_cashes do |t|
      t.string :place_name
      t.float :latitude
      t.float :longitude
      t.timestamps
    end
  end
end
