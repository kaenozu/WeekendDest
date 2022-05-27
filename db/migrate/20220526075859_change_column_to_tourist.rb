class ChangeColumnToTourist < ActiveRecord::Migration[7.0]
  def change
    change_column :tourists, :latitude, :string
    change_column :tourists, :longitude, :string
  end
end
