class CreateAgents < ActiveRecord::Migration
  def change
    create_table :agents do |t|
      t.belongs_to :user, index:true
      t.string :name, limit: 50, null: false
      t.integer :status, null:false, default: 1
      t.timestamps null: false
    end
  end
end
