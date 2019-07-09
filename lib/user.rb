class User < ActiveRecord::Base
    has_many :sightings
    has_many :locations, through: :sightings
end