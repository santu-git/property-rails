class CreateStyles < ActiveRecord::Migration
  def change
    create_table :styles do |t|
      t.string :value, limit: 50, null: false
      t.timestamps null: false
    end
  end
end
