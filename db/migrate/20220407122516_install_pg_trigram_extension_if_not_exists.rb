class InstallPgTrigramExtensionIfNotExists < ActiveRecord::Migration[6.1]
  def up
    execute <<-SQL
      CREATE EXTENSION IF NOT EXISTS "pg_trgm";
    SQL
  end

  def down
    execute <<-SQL
      DROP EXTENSION IF EXISTS "pg_trgm";
    SQL
  end
end
