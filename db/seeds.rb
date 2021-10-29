require 'faker'

[
  Document, Comment, Event, Contact, Administrator, User
].map(&:destroy_all)

Administrator.create!(
  email:    'foo@bar.com',
  password: 'foobar'
)

20.times do
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

100.times do
  start_date = Date.today + rand(300)

  Event.create!(
    user:       User.all.sample,
    title:      Faker::Lorem.paragraph(sentence_count: 1),
    start_date: start_date,
    end_date:   start_date + rand(5),
    location:   Faker::Address.street_address
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
