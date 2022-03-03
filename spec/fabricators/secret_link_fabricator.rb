Fabricator(:secret_link) do
  slug { SecureRandom.alphanumeric }
  validity_period { rand(30) }
  visit_count { rand(30) }
  calendar
  user
end
