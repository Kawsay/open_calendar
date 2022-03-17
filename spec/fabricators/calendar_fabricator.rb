# frozen_string_literal: true

# == Schema Information
#
# Table name: calendars
#
#  id               :bigint           not null, primary key
#  name             :string           not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  background_color :string(7)
#  text_color       :string
#  team_id          :bigint           default(75), not null
#
Fabricator(:calendar) do
  team
  name { Faker::Name.name }
  background_color { Faker::Color.hex_color }
end
