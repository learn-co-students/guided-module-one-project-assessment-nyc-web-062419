class Sighting < ActiveRecord::Base
    belongs_to :users
    belongs_to :location
end
