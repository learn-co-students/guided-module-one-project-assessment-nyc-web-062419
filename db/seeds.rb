require 'pry'
require 'json'
require 'date'
require_relative '../config/environment.rb'



# User.delete_all
# Location.delete_all
# Sighting.delete_all

# ufo_array = File.read('./lib/ufo-sightings.json')
# ufo_hash = JSON.parse(ufo_array)

i = 1014
while i > 0
    user = User.create(name: Faker::Name.name)
    i -= 1
end

# us_ufos = ufo_hash.select {|hash| hash["country"] == "us"}

# us_ufos.each do |hash|
    
#     location = Location.find_or_create_by(city: hash["city"], state: hash["state"])
    
#     date_array = hash["datetime"].tr("/", ":").split(/[: ]/)
#     date_array = date_array.collect{|num| num.to_i}
#     date = DateTime.new(date_array[2], date_array[0], date_array[1], date_array[3], date_array[4])

#     user = rand(1..User.all.length)
#     sighting = Sighting.create(user_id: user,location_id: location.id, date: date, shape: hash["shape"])
    
# end

# binding.pry
0