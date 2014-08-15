class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :title
      t.string :link
      t.string :author
      t.string :tags
      t.string :author_id

      t.timestamps
    end
  end
end
