class AddLimitToCommentInReviews < ActiveRecord::Migration

  def up
    change_column :reviews, :comment, :text, limit: 2000, null: false
  end

  def down
    change_column :reviews, :comment, :text
  end

end
