# frozen_string_literal: true

class RemoveContactsTable < ActiveRecord::Migration[6.1]
  def change
    drop_table :contacts
  end
end
