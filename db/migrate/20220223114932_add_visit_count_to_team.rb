class AddVisitCountToTeam < ActiveRecord::Migration[6.1]
  def change
    add_column :teams, :visit_count, :integer
  end
end
