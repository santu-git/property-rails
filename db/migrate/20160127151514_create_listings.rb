class CreateListings < ActiveRecord::Migration
  def change
    create_table :listings do |t|
      t.belongs_to :branch, index: true
      t.belongs_to :age, index: true
      t.belongs_to :availability, index: true
      t.belongs_to :department, index: true
      t.belongs_to :frequency, index: true
      t.belongs_to :qualifier, index: true
      t.belongs_to :sale_type, index: true
      t.belongs_to :style, index: true
      t.belongs_to :tenure, null:true, index: true
      t.belongs_to :type, null: true, index: true
      t.string :address_1, limit: 50, null: false
      t.string :address_2, limit: 50, null: true
      t.string :address_3, limit: 50, null: true
      t.string :address_4, limit: 50, null: true
      t.string :town_city, limit: 50, null: false
      t.string :county, limit: 50, null: false
      t.string :postcode, limit: 10, null: false
      t.string :country, limit: 50, null: false
      t.decimal :latitude, precision: 10, scale: 6, null: false
      t.decimal :longitude, precision: 10, scale: 6, null: false
      t.string :display_address, limit:200, null:false
      t.integer :bedrooms, null: false, default: 0
      t.integer :bathrooms, null: false, default: 0
      t.integer :ensuites, null: false, default: 0
      t.integer :receptions, null: false, default: 0
      t.integer :kitchens, null: false, default: 0
      t.text :summary, null: false
      t.text :description, null: false
      t.decimal :price, precision: 12, scale: 2, null: false, default: 0
      t.boolean :price_on_application, null: false, default: false
      t.boolean :development, null: false, default: false
      t.boolean :investment, null: false, default: false
      t.decimal :estimated_rental_income, precision: 9, scale: 2, null: false, default: 0
      t.decimal :rent, precision: 9, scale: 2, null: false, default: 0
      t.boolean :rent_on_application, null: false, default: false
      t.boolean :student, null: false, default: false
      t.text :rental_detail, null: true
      t.boolean :featured, null: false, default: false
      t.integer :status, null: false, default: 1
      t.timestamps null: false
    end
  end
end
