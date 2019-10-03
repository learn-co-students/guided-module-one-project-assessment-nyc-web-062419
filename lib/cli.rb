require 'pry'
require 'lolize'

class CommandLineInterface
    def greet
        puts 'Greetings, Earthling. 👽'.colorize(:light_magenta)
        sleep 1
    end

    def get_user
        colorizer = Lolize::Colorizer.new
        puts "Enter your username:"
        name = gets.chomp.colorize(:green)
        if User.find_by(name: name)
            puts "An existing user with the name: #{name} has been found. Is this you? (y/n)"
            answer = gets.chomp
            if answer.downcase == 'y' || answer.downcase == 'yes'
                user = User.find_by(name: name)
                sleep 1
                colorizer.write "Welcome back #{name}!"
            else
                puts 'Please enter a different username.'
                user = get_user
            end
        else
            user = User.create(name: name)
            sleep 1
            colorizer.write "Welcome #{name}!"
        end
        user
    end

    def get_sighting_by_location
        puts "Please enter a city and state to find sightings in that city:"
        puts "City:".colorize(:light_blue)
        city = gets.chomp.downcase
        puts "State(XX):".colorize(:light_blue)
        state = gets.chomp.downcase
        location_array = Location.select {|location| location.city.include?(city) && location.state == state}
        
        sightings = location_array.collect do |location|
            location.sightings
        end.flatten
       
        sightings.each do |sighting| 
            put_sighting(sighting)
            puts " "
        end
        if sightings == []
            puts "Sorry, this city does not have any sightings ...yet. 👀"
        end
    end

    def put_sighting(sighting)
        puts "
        User: #{User.find(sighting.user_id).name}, 
        City: #{Location.find(sighting.location_id).city},
        State: #{Location.find(sighting.location_id).state},
        Date: #{sighting.date}, 
        Shape: #{sighting.shape}".black.on_green
        # puts "
        # User: #{User.find(sighting.user_id).name},".black.on_green+"    
        # ".black.on_green+"City: #{Location.find(sighting.location_id).city},".black.on_green+"
        # ".black.on_green+"State: #{Location.find(sighting.location_id).state},".black.on_green+"
        # ".black.on_green+"Date: #{sighting.date},".black.on_green+" 
        # ".black.on_green+"Shape: #{sighting.shape}".black.on_green
    end

    def get_a_location
        puts "Please enter the city and state where your sighting occurred."
        puts "City:".colorize(:light_blue)
        city = gets.chomp.downcase
        puts "State(XX):".colorize(:light_blue)
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
        puts "Enter a one word description of the shape of the ufo spotted 
(i.e. sphere, disk, light, triangle, crescent, etc.):".colorize(:light_blue)
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
        user.sightings << sighting
        puts "Your sighting has been created!"
        put_sighting(sighting)
        puts " "
        user
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
            puts " "
            " "
        end
    end

    def edit_sighting(user)
        if my_sightings(user)
            puts 'Select which sighting you would like to edit by entering its sighting number:'
            sighting = nil
            
            while sighting == nil
                num = gets.chomp.to_i
                sighting = user.sightings[num-1]
                if sighting == nil
                    puts "Please enter a valid sighting number."
                end
                sighting
            end
            put_sighting(sighting)
            puts " "
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
            puts "Would you like to edit the date (y/n)?"
            answer = gets.chomp
            if answer.downcase == 'y' || answer.downcase == 'yes'
                date = get_a_date
                puts "Enter the hour and minute in 24-hr format (military time) of the sighting:"
                puts "Hour:".light_blue
                hour = gets.chomp.to_i
                puts "Minute:".light_blue
                minute = gets.chomp.to_i
                
                sighting.date = DateTime.new(date.year, date.month, date.day, hour, minute)
                sighting.save
                put_sighting(sighting)
                puts " "
            end
        end

    end

    def delete_sighting(user)
        if my_sightings(user)
            puts 'Select which sighting you would like to delete by entering its sighting number:'
            sighting = nil
            
            while sighting == nil
                num = gets.chomp.to_i
                sighting = user.sightings[num-1]
                if sighting == nil
                    puts "Please enter a valid sighting number."
                end
                sighting
            end
            put_sighting(sighting)
            puts " "
            puts 'Are you sure you want to delete this sighting (y/n)?'
            answer = gets.chomp
            if answer.downcase == 'y' || answer.downcase == 'yes'
                sighting.delete
                user.sightings.delete(sighting)
                
                puts "Your sighting has been deleted. The government will never find out. 🤐".colorize(:red)
            end
        end
    end

    def disappear(user)
        puts "Are you sure you want to delete your username and all of your sightings? (y/n)"
        answer = gets.chomp
        if answer.downcase == 'y' || answer.downcase == 'yes'
            sightings = Sighting.all.select {|sighting| sighting.user_id == user.id}
            sightings.each {|sighting| sighting.delete}
            user.sightings.destroy_all
            user.destroy
            puts "User deleted - no trace left behind.".colorize(:red)
            exit
        end 
    end

    def help
        puts "                          
                            "+"MAIN MENU".light_magenta+ " "
        puts "
        report".colorize(:green) + " :          report a UFO sighting,"
        puts "        find".colorize(:green) + " :            search for sightings by location, shape, or date," 
        puts "        my sightings".colorize(:green) + " :    displays your UFO sightings," 
        puts "        edit".colorize(:green) + " :            edit one of your UFO sightings," 
        puts "        delete".colorize(:green) + " :          delete one of your UFO sightings,"
        puts "        disappear".colorize(:green) + " :       delete your username and all of your sightings," 
        puts "        help".colorize(:green) + " :            displays this menu," 
        puts "        exit".colorize(:green) + " :            exits the program"
        puts " "
    end

    def get_sighting_by_shape
        puts "Please enter a one word shape description to find sightings with that shape:"
        shape = gets.chomp.downcase
        sightings = Sighting.all.select {|sighting| sighting.shape == shape}

        sightings.each do |sighting| 
            put_sighting(sighting)
        end
        puts " "
        if sightings == []
            puts "Sorry, there are no sightings with that shape."
        end
    end

    def get_a_date
        puts "Please enter the numerical month, day, and year (XX/XX/XXXX) of the sighting:"
        puts "Month:".light_blue
        month = gets.chomp.to_i
        puts "Day:".light_blue
        day = gets.chomp.to_i
        puts "Year:".light_blue
        year = gets.chomp.to_i
        date = DateTime.new(year, month, day)
    end

    def get_sighting_by_date
        date = get_a_date

        sightings = Sighting.all.select do |sighting|
            
            sighting.date.day == date.day && sighting.date.month == date.month && sighting.date.year == date.year
        end

        sightings.each do |sighting| 
            put_sighting(sighting)
        end
        puts " "
    end

    def exit
        puts "Farewell, Earthling. ✌️  🛸".colorize(:light_magenta)

    end

end
