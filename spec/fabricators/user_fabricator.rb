# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  id                     :uuid             not null, primary key
#  team_member_id         :bigint
#
Fabricator(:user) do
  email { Faker::Internet.email }
  password { Faker::Internet.password }
end
