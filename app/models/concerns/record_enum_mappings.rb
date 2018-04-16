module RecordEnumMappings
  extend ActiveSupport::Concern
  included do 
	def self.record_condition
		{ unopened: 1, brand_new: 2, excellent: 3, very_good: 4, good: 5, acceptable: 6, some_damage: 7 }
  	end
  end
end