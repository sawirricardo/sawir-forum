class CreateFavoriters < ActiveRecord::Migration[6.1]
  def change
    create_table :favoriters do |t|
      t.references :user, null: false, foreign_key: true
      t.references :article, null: false, foreign_key: true
      t.timestamps
    end
  end
end
