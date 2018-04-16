require 'rails_helper'

RSpec.describe Record, type: :model do
	let(:record1) { Fabricate(:record, year: 1999, artist: "The Beatles", album_title: "Help!") }
	let(:record2) { Fabricate(:record, year: 2018, artist: "The Beatles", album_title: "Please please me") }
	let(:record3) { Fabricate(:record, year: 1989, artist: "The Beatles", album_title: "Let It Be - please?! help!") }
	let(:record4) { Fabricate(:record, year: 1988, artist: "Elvis", album_title: "Elvis for Everyone") }

	describe 'self.artist_analysis' do
		context 'when records exist' do
			it 'returns hash of artist stats' do
				[1,2,3,4].map{|n| eval("record#{n}")}

				expect(Record.artist_analysis).to eq({
					"The Beatles".to_sym => {total_records_owned: 3, record_range: "1989 - 2018", album_title_mode: "please" }, 
					"Elvis".to_sym => {total_records_owned: 1, record_range: "1988 - 1988", album_title_mode: "elvis" }
					})
			end
		end
		context 'when no records' do
			it 'returns empty hash' do
				# expect(Record.artist_analysis).to eq({total_records_owned: 0, record_range: [], album_title_mode: {} })
				expect(Record.artist_analysis).to eq({})
			end
		end
	end

end
