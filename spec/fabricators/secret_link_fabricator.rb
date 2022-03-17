# == Schema Information
#
# Table name: secret_links
#
#  id              :bigint           not null, primary key
#  slug            :string(16)       not null
#  validity_period :integer          default(1), not null
#  visit_count     :integer          default(0), not null
#  calendar_id     :bigint           not null
#  user_id         :uuid             not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
Fabricator(:secret_link) do
  slug { SecureRandom.alphanumeric }
  validity_period { rand(30) }
  visit_count { rand(30) }
  calendar
  user
end
