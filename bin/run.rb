require_relative '../config/environment'

cli = CommandLineInterface.new
cli.greet
user = cli.get_user
cli.help
loop do
    puts "Enter a command:".white.on_black
    command = gets.chomp.downcase
    if command == "report"
        user = cli.create_a_sighting(user)
    elsif command == "find"
        puts "Enter "+"'location'".colorize(:green)+ " to find sightings by location, "+ "'shape'".colorize(:green)+ " to find sightings by shape, or " + "'date'".colorize(:green)+ " to find sightings by date."
        command = gets.chomp.downcase
        if command == "location" 
            cli.get_sighting_by_location
        elsif command == "shape"
            cli.get_sighting_by_shape
        elsif command == "date"
            cli.get_sighting_by_date
        end
    elsif command == "edit"
        cli.edit_sighting(user)
    elsif command == "delete"
        cli.delete_sighting(user)
    elsif command == "my sightings"
        cli.my_sightings(user)
    elsif command == "help"
        cli.help
    elsif command == "disappear"
        cli.disappear(user)
        break
    elsif command == "exit"
        cli.exit
        break
    end
    
end



# puts "hello world"
