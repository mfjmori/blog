class AddPublishToArticle < ActiveRecord::Migration[5.0]
  def change
    add_column :articles, :publish, :boolean, default: true, null: false
  end
end
