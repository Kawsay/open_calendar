# frozen_string_literal: true

class RemoveCommentTable < ActiveRecord::Migration[6.1]
  def change
    drop_table :comments
  end
end
