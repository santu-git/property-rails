class CreateFeatures < ActiveRecord::Migration
  def change
    create_table :features do |t|
      t.belongs_to :listing, index: true
      t.string :value, null: false
      t.timestamps null: false
    end
  end
end
