Fabricator(:user) do
  email    { Faker::Internet.email }
  password "oops55!!!!"
  password_confirmation "oops55!!!!"
end
