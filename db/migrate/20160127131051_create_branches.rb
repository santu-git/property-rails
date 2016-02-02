class CreateBranches < ActiveRecord::Migration
  def change
    create_table :branches do |t|
      t.belongs_to :agent, index: true
      t.string :name, limit: 50, null: false
      t.string :address_1, limit: 50, null: false
      t.string :address_2, limit: 50, null: true
      t.string :address_3, limit: 50, null: true
      t.string :address_4, limit: 50, null: true
      t.string :town_city, limit: 50, null: false
      t.string :county, limit: 50, null: false
      t.string :postcode, limit: 10, null: false
      t.string :country, limit: 50, null: false
      t.decimal :latitude, {:precision=>10, :scale=>6}
      t.decimal :longitude, {:precision=>10, :scale=>6}
      t.string :display_address, limit:200, null:false
      t.integer :status, default: 1
      t.timestamps null: false
    end
  end
end
