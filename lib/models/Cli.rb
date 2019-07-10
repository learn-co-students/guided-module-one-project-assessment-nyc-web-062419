
class Cli 
    
   

    def greet
        puts 'Welcome to Felp, the best resource for restaurant information in the world!'

        puts "Thinking of eating somewhere but not sure if it's good? We can help you with that decision!"
        puts "Enter a restaurant name to get started:"
        restaurant_name = gets.chomp
        restaurant = Restaurant.find_by(name: restaurant_name)
        restaurant.reviews

        
    end

    



    




end