class CreateArticles < ActiveRecord::Migration[6.1]
  def change
    create_table :articles do |t|
      t.string :title
      t.string :slug
      t.text :description
      t.text :body
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    add_index :articles, :slug, unique: true
  end
end
