# frozen_string_literal: true

# == Schema Information
#
# Table name: organizations
#
#  id          :bigint           not null, primary key
#  name        :string
#  description :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
Fabricator(:organization) do
  name { Faker::Lorem.word }
  description { Faker::Lorem.paragraph }
end
