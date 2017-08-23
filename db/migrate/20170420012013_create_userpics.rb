class CreateUserpics < ActiveRecord::Migration

  def self.up
     create_table :userpics do |t|
      t.references :admin_user
      t.integer :parent_id
      t.string :content_type, :filename, :thumbnail
      t.integer :size, :width, :height

      t.timestamps
    end
  end


  def self.down
  	drop_table :userpics
  end

end
