class CreateAges < ActiveRecord::Migration
  def change
    create_table :ages do |t|
      t.string :value, limit: 50, null: false
      t.timestamps null: false
    end
  end
end
