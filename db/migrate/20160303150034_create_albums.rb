class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.string :name
      t.string :release_date
      t.string :image_url
      t.references :artist

      t.timestamps null: false
    end
  end
end
