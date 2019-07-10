require_relative '../config/environment'

cli = CommandLineInterface.new
cli.greet
user = cli.get_user


# cli.get_sighting_by_location
# cli.create_a_sighting(user)
# user = cli.get_user
cli.my_sightings(user)

# puts "hello world"
