Fabricator(:event) do
  calendar
  start_date { DateTime.now + (rand * 10) }
  end_date { [nil, (DateTime.now + 10 +(rand * 10))].sample }
  title { Faker::Lorem.word.capitalize }
  description { Faker::Lorem.paragraph }
  location { Faker::Address.full_address }
end
