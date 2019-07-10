require_relative '../config/environment'

cli = CommandLineInterface.new
cli.greet
user = cli.get_user
cli.help
puts "Enter a command from the list above:"
command = gets.chomp.downcase
if command == "report"
    cli.create_a_sighting(user)
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
end



# puts "hello world"
