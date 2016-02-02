class CreateAssets < ActiveRecord::Migration
  def change
    create_table :assets do |t|
      t.belongs_to :listing, index: true
      t.belongs_to :media_type, index: true
      t.attachment :upload
      t.integer :status, null: false, default: 1
      t.timestamps null: false
    end
  end
end
