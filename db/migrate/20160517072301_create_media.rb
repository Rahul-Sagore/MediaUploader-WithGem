class CreateMedia < ActiveRecord::Migration
  def self.up
    create_table :media do |t|
      t.string :name,  :null => false
      t.string :filename
      t.string :mime_type

      t.references :user
      t.timestamps
    end
  end

  def self.down
    drop_table :media
  end
end