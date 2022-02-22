Fabricator(:calendar) do
  team
  name { Faker::Name.name }
  background_color { Faker::Color.hex_color }
end
