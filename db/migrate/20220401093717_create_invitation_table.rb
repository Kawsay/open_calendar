class CreateInvitationTable < ActiveRecord::Migration[6.1]
  def up
    execute <<-SQL
      CREATE TYPE invitation_status AS ENUM ('pending', 'accepted', 'rejected');
    SQL

    create_table :invitations do |t|
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.references :event, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end

    add_column :invitations, :status, :invitation_status
  end

  def down
    drop_table :invitations

    execute <<-SQL
      DROP TYPE invitation_status
    SQL
  end
end
