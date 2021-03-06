class Comment < ApplicationRecord
  include ActionView::RecordIdentifier

  belongs_to :user
  belongs_to :commentable, polymorphic: true
  belongs_to :parent, optional: true, class_name: 'Comment'
  has_many :comments, foreign_key: :parent_id, dependent: :destroy

  has_rich_text :body

  validates :body, presence: true

  self.implicit_order_column = 'created_at'

  after_create_commit do
    broadcast_append_to [commentable, :comments], target: "#{dom_id(parent || commentable)}_comments", partial: 'comments/comment_with_replies'
  end

  after_update_commit do
    broadcast_replace_to self
  end

  after_destroy_commit do
    broadcast_remove_to self
    broadcast_action_to self, action: :remove, target: "#{dom_id(self)}_with_comments"
  end

  # def self.recursive_find(id)
  #   sql = <<-SQL.squish
  #     WITH RECURSIVE comment_tree_cte
  #     AS (
  #       SELECT id, parent_id, commentable_id, user_id, created_at
  #       FROM comments
  #       WHERE commentable_id = :id
  #       UNION
  #         SELECT comments.id, comments.parent_id, comments.commentable_id, comments.user_id, comments.created_at
  #         FROM comments
  #       JOIN comment_tree_cte ON comments.parent_id = comment_tree_cte.id
  #     )
  #     SELECT * FROM comment_tree_cte;
  #   SQL

  #   records = find_by_sql([sql, id: id])
  #   ActiveRecord::Associations::Preloader.new.preload(records, [:rich_text_body, :user])
  #   records
  # end
end
