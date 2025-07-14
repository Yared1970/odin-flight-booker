class AddCodeToAirports < ActiveRecord::Migration[8.0]
  def change
    add_column :airports, :code, :string, null: false
    add_index  :airports, :code, unique: true
  end
end
