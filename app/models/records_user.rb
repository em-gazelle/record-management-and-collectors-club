class RecordsUser < ApplicationRecord
	belongs_to :user 
	belongs_to :record

	delegate :album_title, to: :record, allow_nil: true
	delegate :artist, to: :record, allow_nil: true
	delegate :year, to: :record, allow_nil: true

	# require users to rate albums - better statistical analysis; potentially lower user engagement / total records added 
	validates :rating, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 10 }

	enum condition: { unopened: 1, brand_new: 2, excellent: 3, very_good: 4, good: 5, acceptable: 6, some_damage: 7 }

end
