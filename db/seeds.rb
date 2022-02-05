require 'faker'

[
  Document, Comment, Event, Contact, Administrator, User, Calendar
].map(&:destroy_all)

Administrator.create!(
  email:    'foo@bar.com',
  password: 'foobar'
)

5.times do
  user = User.create!(
    fullname:    Faker::Name.name,
    description: Faker::Lorem.paragraph(sentence_count: 12)
  )

  Contact.create!(
    user:   user,
    mobile: Faker::PhoneNumber.cell_phone_in_e164,
    email:  Faker::Internet.email
  )

  Administrator.create!(
    email:    Faker::Internet.email,
    password: 'foobar'
  )
end

event_type = EventType.create!(
  name: 'default',
  background_color: '#FFF',
  text_color: EventType.text_colors[:dark]
)

5.times do
  Calendar.create!(
    name:             Faker::Lorem.words.sample,
    background_color: Faker::Color.hex_color
  )
end

30.times do
  start_date = Date.today + rand(300)

  Event.create!(
    user:        User.all.sample,
    calendar:    Calendar.all.sample,
    event_type:  event_type,
    title:       Faker::Lorem.paragraph(sentence_count: 1),
    description: Faker::Lorem.paragraph(sentence_count: 3..6),
    start_date:  start_date,
    end_date:    start_date + rand(3),
    location:    Faker::Address.street_address
  )
end

70.times do
  document = Document.create!(
    title:             Faker::Lorem.paragraph(sentence_count: 1),
    documentable_type: 'Event',
    documentable_id:   Event.all.sample.id
  )

  document.file.attach(io:           File.open(Rails.root.join('storage', 'seed.txt')),
                       filename:     'seed.txt',
                       content_type: 'text/plain',
                       identify:     false)
end

70.times do
  document = Document.create!(
    title:             Faker::Lorem.paragraph(sentence_count: 1),
    documentable_type: 'User',
    documentable_id:   User.all.sample.id
  )

  document.file.attach(io:           File.open(Rails.root.join('storage', 'seed.txt')),
                       filename:     'seed.txt',
                       content_type: 'text/plain',
                       identify:     false)
end

100.times do
  Comment.create!(
    administrator:    Administrator.all.sample,
    body:             Faker::Lorem.paragraph(sentence_count: 1..20),
    commentable_type: 'Event',
    commentable_id:   Event.all.sample.id,
  )

  Comment.create!(
    administrator:    Administrator.all.sample,
    body:             Faker::Lorem.paragraph(sentence_count: 1..20),
    commentable_type: 'Document',
    commentable_id:   Document.all.sample.id,
  )
end

20.times do
  Comment.create!(
    administrator:    Administrator.all.sample,
    body:             Faker::Lorem.paragraph(sentence_count: 1..20),
    commentable_type: 'User',
    commentable_id:   User.all.sample.id,
  )
end
