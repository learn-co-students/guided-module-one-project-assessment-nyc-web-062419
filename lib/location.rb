class Location < ActiveRecord::Base
    has_many :sightings
    has_many :users, through: :sightings
<<<<<<< HEAD
    
=======
>>>>>>> 89686b73f43bff98fd8bcb974509c234a54713c5
end