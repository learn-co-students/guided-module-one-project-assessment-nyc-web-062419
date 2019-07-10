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

    def create_a_sighting(user)
        puts "Please enter the city and state where your sighting occurred."
        puts "City:"
        city = gets.chomp.downcase
        puts "State(XX):"
        state = gets.chomp.downcase

        cities = Location.select {|location| location.city.include?(city) && location.state == state}
        cities << Location.select {|location| city.include?(location.city) && location.state == state}
        cities = cities.flatten
        if cities != []
            city_list = cities.collect {|location| location.city}
            puts "Did you mean one of the following cities in #{state}?"
            puts city_list
            puts "Please enter one of the above city names or re-enter your city name:"
            puts "City:"
            city = gets.chomp.downcase
        end

        location = Location.find_or_create_by(city: city, state: state)
        
        puts "Enter a one-word description of the shape of the ufo spotted (i.e. cylinder, circle, sphere, disk, light, fireball, triangle, cross, crescent, etc.):"
        shape = gets.chomp
        
        date = DateTime.now

        sighting = Sighting.create do |s|
            s.user_id = user.id
            s.location_id = location.id
            s.date = date
            s.shape = shape
        end
     
        puts "Your sighting has been created!"

        puts "
        User: #{User.find(sighting.user_id).name},
        City: #{Location.find(sighting.location_id).city},
        State: #{Location.find(sighting.location_id).state},
        Date: #{sighting.date},
        Shape: #{sighting.shape}"

    end

    def my_sightings(user)
        
        if user.sightings == []
            puts "You do not have any sightings yet!"
        else
            user.sightings.each do |sighting|
                puts "
                User: #{user.name},
                City: #{Location.find(sighting.location_id).city},
                State: #{Location.find(sighting.location_id).state},
                Date: #{sighting.date},
                Shape: #{sighting.shape}"
            end
        end
    end

end
