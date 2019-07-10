require_relative '../config/environment'

cli = CommandLineInterface.new
cli.greet
user = cli.get_user
cli.help
loop do
    puts "Enter a command:"
    command = gets.chomp.downcase
    if command == "report"
        user = cli.create_a_sighting(user)
    elsif command == "find"
        cli.get_sighting_by_location
    elsif command == "edit"
        cli.edit_sighting(user)
    elsif command == "delete"
        cli.delete_sighting(user)
    elsif command == "my sightings"
        cli.my_sightings(user)
    elsif command == "help"
        cli.help
    elsif command == "exit"
        cli.exit
        break
    end
    
end



# puts "hello world"
