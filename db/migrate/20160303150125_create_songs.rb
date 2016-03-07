class CreateSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.string :name
      t.integer :track_number
      t.string :preview_url
      t.references :artist

      t.timestamps null: false
    end
  end
end
