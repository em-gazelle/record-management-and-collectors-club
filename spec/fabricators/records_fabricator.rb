Fabricator(:record) do
  artist { Faker::RockBand.name }     
  album_title { Faker::Book.title }
  year Faker::Number.between(1920, 2018)
end
