require 'pry'
require 'json'
require 'date'
ufo_array = File.read('./lib/ufo-sightings.json')
ufo_hash = JSON.parse(ufo_array)

us_ufos = ufo_hash.select {|hash| hash["country"] == "us"}

us_ufos.each do |hash|
    # location = Location.create(city: hash["city"], state: hash["state"])

    #[[10,10,1949], [20,30]]
    binding.pry
    date_array = hash["datetime"].split(" ")
    date_array= date_array.split(/[/:] /) 
    binding.pry
    date = DateTime.new(date_array[0][2], date_array[0][0], date_array[0][1], date_array[1][0], date_array[1][1])
    binding.pry
    # sighting = Sighting.create(user_id: ,location_id: location.id, date: date, shape: hash["shape"])
end

# binding.pry
0