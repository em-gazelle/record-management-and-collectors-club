Fabricator(:records_user) do
  condition  "unopened"
  rating     Faker::Number.between(1, 10)
  favorite  false
end
