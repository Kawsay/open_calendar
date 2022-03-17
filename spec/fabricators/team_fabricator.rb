# frozen_string_literal: true

# == Schema Information
#
# Table name: teams
#
#  id          :bigint           not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  name        :string           default(""), not null
#  visit_count :integer
#
Fabricator(:team) do
  name { Faker::Lorem.word }
end
