# frozen_string_literal: true

# == Schema Information
#
# Table name: events
#
#  id                   :bigint           not null, primary key
#  start_date           :datetime
#  end_date             :datetime
#  location             :text
#  description          :text
#  organization_id      :bigint
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  title                :string
#  is_related_to_a_user :boolean          default(FALSE)
#  calendar_id          :bigint           not null
#
Fabricator(:event) do
  calendar
  start_date { DateTime.now + (rand * 10) }
  end_date { [nil, (DateTime.now + 10 + (rand * 10))].sample }
  title { Faker::Lorem.word.capitalize }
  description { Faker::Lorem.paragraph }
  location { Faker::Address.full_address }
end
