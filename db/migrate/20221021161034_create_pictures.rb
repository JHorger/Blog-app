class CreatePictures < ActiveRecord::Migration[7.0]
  def up
    create_table :pictures do |t|
      t.references :article, null: false, foreign_key: true
      t.string   :picture_file_name
      t.string   :picture_content_type
      t.integer  :picture_file_size
      t.datetime :picture_updated_at

      t.timestamps
    end
  end

  def down
    drop_table :pictures
  end
end
