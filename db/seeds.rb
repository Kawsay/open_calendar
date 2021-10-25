require 'faker'

[
  Document, Comment, Event, Contact, Administrator, User
].map(&:destroy_all)

20.times do
  user = User.create!(
    fullname:    Faker::Name.name,
    description: Faker::Lorem.paragraph(sentence_count: 12)
  )

  Contact.create!(
    user:   user,
    mobile: Faker::PhoneNUmber.cell_phone_in_e164,
    email:  Faker::Internet.email
  )
end

100.times do
  start_date = Date.today - rand(300)

  Event.create!(
    user:       User.all.sample,
    start_date: start_date,
    end_date:   start_date + rand(5),
    location:   Faker::Address.street_address
  )

end

70.times do
  document = Document.create!(
    title: Faker::Lorem.paragraph(sentence_count: 1),
    document_type: 'Event',
    document_id: Event.all.sample
  )

  document.attach(io: File.open(Rails.root.join('storage', 'seed.txt')))
end

100.times do
  Comment.create!(
    body: Faker::Lorem.paragraph(sentence_count: 1..20),
  )
end
