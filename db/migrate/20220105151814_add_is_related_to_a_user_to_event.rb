class AddIsRelatedToAUserToEvent < ActiveRecord::Migration[6.1]
  def change
    add_column :events, :is_related_to_a_user, :boolean, default: false
  end
end
