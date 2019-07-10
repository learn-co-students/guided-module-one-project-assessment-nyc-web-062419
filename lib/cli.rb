require 'pry'
class CommandLineInterface
    include Kernel
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
            put_sighting(sighting)
        end
    end

    def put_sighting(sighting)
        puts "
        User: #{User.find(sighting.user_id).name},
        City: #{Location.find(sighting.location_id).city},
        State: #{Location.find(sighting.location_id).state},
        Date: #{sighting.date},
        Shape: #{sighting.shape}"
    end

    def get_a_location
        puts "Please enter the city and state where your sighting occurred."
        puts "City:"
        city = gets.chomp.downcase
        puts "State(XX):"
        state = gets.chomp.downcase

        cities = Location.select {|location| location.city.include?(city) && location.state == state}
        cities << Location.select {|location| city.include?(location.city) && location.state == state}
        cities = cities.flatten.uniq
        
        if cities != []
            if Location.find_by(city: city, state: state) == nil 
                city_list = cities.collect {|location| location.city}
                puts "Did you mean one of the following cities in #{state}?"
                puts city_list
                puts "Please enter one of the above city names or re-enter your city name:"
                puts "City:"
                city = gets.chomp.downcase
            end
        end

        location = Location.find_or_create_by(city: city, state: state)
    end

    def get_a_shape
        puts "Enter a one-word description of the shape of the ufo spotted (i.e. cylinder, circle, sphere, disk, light, fireball, triangle, cross, crescent, etc.):"
        shape = gets.chomp
    end

    def create_a_sighting(user)
        location = get_a_location
        shape = get_a_shape
          
        date = DateTime.now

        sighting = Sighting.create do |s|
            s.user_id = user.id
            s.location_id = location.id
            s.date = date
            s.shape = shape
        end
     
        puts "Your sighting has been created!"

        put_sighting(sighting)

    end

    def my_sightings(user)
        
        if user.sightings == []
            puts "You do not have any sightings yet!"
        else
            i=1
            user.sightings.each do |sighting|

                puts "
                Sighting: #{i}"
                put_sighting(sighting)
                i+=1
            end
        end
    end

    def edit_sighting(user)
        if my_sightings(user)
            puts 'Select which sighting you would like to edit by entering its sighting number:'
            sighting = nil

            # while 
            #     if (1..user.sightings.length)
            #         sighting = user.sightings[num-1]
            #     else
            #         puts "Please enter a valid sighting number."
            #     end
            # end
            
            while sighting == nil
                num = gets.chomp.to_i
                sighting = user.sightings[num-1]
                if sighting == nil
                    puts "Please enter a valid sighting number."
                end
                sighting
            end
            put_sighting(sighting)

            puts 'Would you like to edit the shape (y/n)?'
            answer = gets.chomp
         
            if answer.downcase == 'y' || answer.downcase == 'yes'
                sighting.shape = get_a_shape
                sighting.save
                put_sighting(sighting)
                sighting
            end
            puts 'Would you like to edit the location (y/n)?'
            answer = gets.chomp
            if answer.downcase == 'y' || answer.downcase == 'yes'
                sighting.location_id = get_a_location.id
                sighting.save
                put_sighting(sighting)
            end
        end

    end

    def delete_sighting(user)
        my_sightings(user)
        puts 'Select which sighting you would like to delete by entering its sighting number:'
        num = gets.chomp.to_i
        sighting = user.sightings[num-1]
        put_sighting(sighting)
        puts 'Are you sure you want to delete this sighting (y/n)?'
        answer = gets.chomp
        if answer.downcase == 'y' || answer.downcase == 'yes'
            sighting.delete
            puts "Your sighting has been deleted. The government will never find out."
        end
    end

    def help
        puts "
        report : report a UFO sighting,
        find : search for sightings by location,
        my sightings : displays your UFO sightings,
        edit : edit one of your UFO sightings,
        delete : delete one of your UFO sightings,
        help : displays this list"
    end

end
