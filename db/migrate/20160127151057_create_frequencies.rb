class CreateFrequencies < ActiveRecord::Migration
  def change
    create_table :frequencies do |t|
      t.string :value, limit: 50, null: false
      t.timestamps null: false
    end
  end
end
