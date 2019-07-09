require_relative '../config/environment'

cli = CommandLineInterface.new
cli.greet
user = cli.get_user
cli.get_sighting_by_location


# puts "hello world"
