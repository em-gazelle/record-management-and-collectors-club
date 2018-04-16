Fabricator(:records_user) do
  condition  "Brand New"
  rating     Faker::Number.between(1, 10)
  favorite  false
end
