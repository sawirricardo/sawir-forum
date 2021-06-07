class CreateJoinTableArticlesTags < ActiveRecord::Migration[6.1]
  def change
    create_join_table :articles, :tags do |t|
      t.index %i[article_id tag_id]
      # t.index [:tag_id, :article_id]
    end
  end
end
