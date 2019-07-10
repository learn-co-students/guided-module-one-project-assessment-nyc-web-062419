require_relative '../config/environment'


def show_reviews(reviews)
    reviews.each do |review|
        puts "#{review.user.name} says: #{review.content}"
    end
end

cli = Cli.new

show_reviews(cli.greet)