require 'rails_helper'

RSpec.describe RecordsUser, type: :model do
	let(:user) { Fabricate(:user) }
	let(:user2) { Fabricate(:user) }
	let(:record1) { Fabricate(:record, year: 1999, artist: "The Beatles", album_title: "Help!") }
	let(:record2) { Fabricate(:record, year: 2018, artist: "The Beatles", album_title: "Please please me") }
	let(:record3) { Fabricate(:record, year: 1989, artist: "The Beatles", album_title: "Let It Be - please?! help!") }
	let(:record4) { Fabricate(:record, year: 1988, artist: "Elvis", album_title: "Elvis for Everyone") }

	describe 'self.most_popular_owned_record' do
		context 'when records exist' do
			it 'returns hash of artist stats' do
				[user, user2].map{|u| Fabricate.times(2, :records_user, record_id: record1.id, user_id: u.id)}

				expect(RecordsUser.most_popular_owned_record).to eq(record1)
			end
		end
	end

end
