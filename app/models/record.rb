class Record < ApplicationRecord
	has_many :users, through: :records_users

	validates_presence_of :album_title, :artist, :year
	# validates_presence :album_title#, uniqueness: true
	# validates :artist#, uniqueness: true
	validates :year, numericality: true

	def self.artist_analysis
		@hash_of_artists_hash_of_stats = {}
		puts self

		Record.all.each do |record|
			@hash_of_artists_hash_of_stats[record.artist.to_sym] ||= {total_records_owned: 0, record_range: [], album_title_mode: {} }

			@hash_of_artists_hash_of_stats[record.artist.to_sym][:total_records_owned] = @hash_of_artists_hash_of_stats[record.artist.to_sym][:total_records_owned] + 1

			year_range = @hash_of_artists_hash_of_stats[record.artist.to_sym][:record_range]
			
			if year_range == []
				@hash_of_artists_hash_of_stats[record.artist.to_sym][:record_range] = [record.year, record.year]
			elsif record.year < year_range.first
				@hash_of_artists_hash_of_stats[record.artist.to_sym][:record_range] = [record.year, year_range[1]]
			elsif record.year > year_range.last
				@hash_of_artists_hash_of_stats[record.artist.to_sym][:record_range] = [year_range[0], record.year]
			end

			# @artist_title_mode = @hash_of_artists_hash_of_stats[record.artist.to_sym][:album_title_mode]
			
			record_title_words = record.album_title.scan(/[a-zA-z]|\'|\s/).join.downcase.split(" ")

			record_title_words.each do |word|
				@hash_of_artists_hash_of_stats[record.artist.to_sym][:album_title_mode][word.to_sym] = (@hash_of_artists_hash_of_stats[record.artist.to_sym][:album_title_mode][word.to_sym] || 0) + 1
			end
		end
		
		@hash_of_artists_hash_of_stats.each do |artist, artist_stats_hash|
			@hash_of_artists_hash_of_stats[artist.to_sym][:album_title_mode] = artist_stats_hash[:album_title_mode].key(artist_stats_hash[:album_title_mode].values.max).to_s
			@hash_of_artists_hash_of_stats[artist.to_sym][:record_range] = @hash_of_artists_hash_of_stats[artist.to_sym][:record_range].join(" - ")
		end

		@hash_of_artists_hash_of_stats
	end

end
