require 'pry'
class CommandLineInterface
    
    def greet
        puts 'Greetings, Earthling.'
    end

    def get_user
        puts "Enter your username:"
        name = gets.chomp
        user = User.find_or_create_by(name: name)
        puts "Welcome #{name}."
        user
    end

    def get_sighting_by_location
        puts "Please enter a city and state to find sightings in that city:"
        puts "City:"
        city = gets.chomp.downcase
        puts "State(XX):"
        state = gets.chomp.downcase
        location_array = Location.select {|location| location.city.include?(city) && location.state == state}
        
        sightings = location_array.collect do |location|
           
            Sighting.select {|sighting| sighting.location_id == location.id}
        end.flatten
       
        sightings.each do |sighting|
            
            puts "
            User: #{User.find(sighting.user_id).name},
            City: #{Location.find(sighting.location_id).city},
            State: #{Location.find(sighting.location_id).state},
            Date: #{sighting.date},
            Shape: #{sighting.shape}"
        end
    end

end