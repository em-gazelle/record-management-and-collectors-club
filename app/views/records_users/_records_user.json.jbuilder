json.extract! @records_user, :id, :album_title, :artist, :year, :condition, :rating, :favorite, :created_at, :updated_at
json.url records_user_url(@records_user, format: :json)
