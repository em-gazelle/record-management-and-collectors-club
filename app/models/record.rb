class Record < ApplicationRecord
	has_many :users, through: :records_users

	validates_presence_of :album_title, :artist, :year
	# validates_presence :album_title#, uniqueness: true
	# validates :artist#, uniqueness: true
	validates :year, numericality: true
end