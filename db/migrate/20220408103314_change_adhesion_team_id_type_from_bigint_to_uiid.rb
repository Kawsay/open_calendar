class ChangeAdhesionTeamIdTypeFromBigintToUiid < ActiveRecord::Migration[6.1]
  def change
    remove_reference :adhesions, :team, index: true
    add_reference :adhesions, :team, index: true, type: :uuid
  end
end
