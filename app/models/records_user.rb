class RecordsUser < ApplicationRecord
	belongs_to :user 
	belongs_to :record

	delegate :album_title, to: :record, allow_nil: true
	delegate :artist, to: :record, allow_nil: true
	delegate :year, to: :record, allow_nil: true

	# require users to rate albums - better statistical analysis; potentially lower user engagement / total records added 
	validates :rating, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 10 }

	enum condition: { unopened: 1, brand_new: 2, excellent: 3, very_good: 4, good: 5, acceptable: 6, some_damage: 7 }


	def self.most_popular_owned_record
		Record.find(RecordsUser.group("record_id").count.max_by{|record_id, freq| freq}[0])
	end

	def self.recently_trending
		recent_date = Date.today - 1.month
		recently_added_records = RecordsUser.where("created_at >= ?", recent_date)
		if recently_added_records.any?
			Record.find(recently_added_records.group("record_id").count.max_by{|record_id, freq| freq}[0])
		else
			recently_added_records = RecordsUser.where(created_at >= (Date.today - 6.month))
			recently_added_records.empty? ? most_popular_owned_record : Record.find(recently_added_records.group("record_id").count.max_by{|record_id, freq| freq}[0])
		end
	end

	def self.most_favorited
		Record.find(RecordsUser.where(favorite: true).group("record_id").count.max_by{|record_id, total| total})[0]
	end

	def self.highest_rated
		Record.find(RecordsUser.group("record_id").average("rating").max_by{ |record_id, av_rating| av_rating }.first )
	end

	def self.highly_rated_unique
		# "hipster"
		# there's a bias: the fewer ratings, the higher the average rating is likely to be
		rating_greater_or_equal_to = 7
		record_id_high_av_rating = RecordsUser.group("record_id").average("rating").keep_if{|record_id, av_rating| av_rating>= 7.0}.keys
		record_id_freq = RecordsUser.where(record_id: record_id_high_av_rating).group("record_id").count.min_by{|rec_id, freq| freq}
		Record.find(record_id_freq[0])
	end

	def self.recommended_based_on_most_recently_added_record(current_user_id, record_added_id=nil)
		most_recent_purchase_date = RecordsUser.where(user_id: current_user_id).maximum("created_at")
		(@record = most_popular_owned_record) if most_recent_purchase_date.blank?
		record_added_id ||= RecordsUser.where(created_at: most_recent_purchase_date)[0].record_id

		user_ids_who_own_same_record_user_just_added = RecordsUser.where(record_id: record_added_id).pluck(:user_id) - [current_user_id]
		record_frequency_by_users_who_own_same_record = RecordsUser.where(user_id: user_ids_who_own_same_record_user_just_added).group("record_id").count
		(@record = most_popular_owned_record) if record_frequency_by_users_who_own_same_record.blank?
		# delete records user already owns in frequency / rec id table
		record_frequency_by_users_who_own_same_record.delete_if{|record_id, freq| User.find(current_user_id).records.pluck(:id).include?(record_id) }
		(@record = most_popular_owned_record) if record_frequency_by_users_who_own_same_record.blank?
		@record ||= Record.find(record_frequency_by_users_who_own_same_record.max_by{|record_id, frequency| frequency}[0])
	end

	def self.record_analysis_stats(current_user_id, record_added_id=nil)
	    @most_popular_owned_record = RecordsUser.most_popular_owned_record
	    @recently_trending = RecordsUser.recently_trending
	    @most_favorited = RecordsUser.most_favorited
	    @highest_rated = RecordsUser.highest_rated
	    @highly_rated_unique = RecordsUser.highly_rated_unique
	    @recommended_based_on_most_recently_added_record = RecordsUser.recommended_based_on_most_recently_added_record(current_user_id, record_added_id)

		{ most_popular_owned_record: "Album #{@most_popular_owned_record.album_title.capitalize} by #{@most_popular_owned_record.artist.capitalize}",
	    recently_trending: "Album #{@recently_trending.album_title.capitalize} by #{@recently_trending.artist.capitalize}",
	    most_favorited: "Album #{@most_favorited.album_title.capitalize} by #{@most_favorited.artist.capitalize}",
	    highest_rated: "Album #{@highest_rated.album_title.capitalize} by #{@highest_rated.artist.capitalize}",
	    highly_rated_unique: "Album #{@highly_rated_unique.album_title.capitalize} by #{@highly_rated_unique.artist.capitalize}",
	    recommended_based_on_most_recently_added_record: "Album #{@recommended_based_on_most_recently_added_record.album_title.capitalize} by #{@recommended_based_on_most_recently_added_record.artist.capitalize}"}
	end

end
