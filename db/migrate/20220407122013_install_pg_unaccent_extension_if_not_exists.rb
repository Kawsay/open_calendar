class InstallPgUnaccentExtensionIfNotExists < ActiveRecord::Migration[6.1]
  def up
    execute <<-SQL
      CREATE EXTENSION IF NOT EXISTS "unaccent";
    SQL
  end

  def down
    execute <<-SQL
      DROP EXTENSION IF EXISTS "unaccent";
    SQL
  end
end
