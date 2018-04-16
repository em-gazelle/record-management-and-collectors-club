class RecordsController < ApplicationController
# no admin access for this application at this time
# limit to 'record show page stats' and/or delete controller altogether

	def artist_overview
		respond_to do |format|
		    format.html
			format.csv do
				@artist_analysis_of_user_records = Record.artist_analysis(current_user.id)

			    csv_file = CSV.generate do |csv|
					column_names = @artist_analysis_of_user_records.first.last.keys.map{|field| field.to_s.gsub('_', ' ').capitalize}.unshift("Artist")
			    	csv << column_names

				    @artist_analysis_of_user_records.each do |hash_artist_stats|
				    	artist_array = [hash_artist_stats[0].to_s] + (hash_artist_stats[1].values)
				    	csv << artist_array
				    end
			    end

		        send_data csv_file, :type => 'text/csv; charset=iso-8859-1; header=present', :disposition => "attachment;filename=Analysis of all the artists you love!.csv"
		    end
		end		
	end
end
