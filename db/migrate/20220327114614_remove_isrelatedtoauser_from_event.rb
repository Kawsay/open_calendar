class RemoveIsrelatedtoauserFromEvent < ActiveRecord::Migration[6.1]
  def change
    remove_column :events, :is_related_to_a_user
  end
end
