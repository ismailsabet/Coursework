class CreateSongs < ActiveRecord::Migration[5.2]
  def change
    create_table :songs do |t|
      t.string :name, null: false
      t.string :artist, null: false
      t.string :album, null: false
      t.string :img_url, null: false
      t.belongs_to :playlist, foreign_key: true
      t.belongs_to :result, foreign_key: true
      t.timestamps
    end

    add_index :songs, :name
  end
end
