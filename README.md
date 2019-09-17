UFO Sightings CLI
========================

## Install

Gems Needed: 
    gem "sinatra-activerecord"
    gem "sqlite3"
    gem "pry"
    gem "require_all"
    gem "faker"
    gem "colorize"

Run `bundle install` in your terminal.

To seed the databse with the inital data run `rake db:seed` in your terminal. (This will take ~ 20 min, here are some videos to watch while you wait: https://www.youtube.com/results?search_query=ufo+sightings 🛸)

## Running the App

Run `ruby bin/run.rb` in your terminal to run the app.

## Usage

The following is a menu of commands that you can enter in your terminal and their description:

COMMANDS:         DESCRIPTION:

report :          report a UFO sighting,
find :            search for sightings by location, shape, or date,
my sightings :    displays your UFO sightings,
edit :            edit one of your UFO sightings,
delete :          delete one of your UFO sightings,
disappear :       delete your username and all of your sightings,
help :            displays the menu,
exit :            exits the program

You can also force quit the program with 'CTRL-c' at any time.

RE-SET DATABASE

If you would like to delete all of your database data and then repopulate it, first run the following two lines of code in 'rake console' in your terminal:

`User.delete_all`

`ActiveRecord::Base.connection.execute(“DELETE from sqlite_sequence where name = 'users’”)`

Then, un-comment out lines 11-12 in the seeds.rb file and run rake db:seed again.

## Screenshots

![Screen Shot 2019-07-12 at 11 00 28 AM](https://user-images.githubusercontent.com/50639575/61140762-0e19c700-a49a-11e9-88a4-a24d1e3ef7b6.png) 

A new user can be created.

![Screen Shot 2019-07-12 at 9 46 36 AM](https://user-images.githubusercontent.com/50639575/61140253-1a515480-a499-11e9-94f1-f61ff1e3c87d.png) 

An existing user can log back in to their username.

![Screen Shot 2019-07-12 at 11 01 01 AM](https://user-images.githubusercontent.com/50639575/61140158-eb3ae300-a498-11e9-881c-ea956fa70ec8.png) 

A sighting can be reported.

![Screen Shot 2019-07-12 at 11 07 44 AM](https://user-images.githubusercontent.com/50639575/61140585-ac595d00-a499-11e9-84db-51aff8881d30.png)

A user can view a list of all their reported sightings.

![Screen Shot 2019-07-12 at 11 06 08 AM](https://user-images.githubusercontent.com/50639575/61140672-d6ab1a80-a499-11e9-907c-536d631eff2e.png) 

Sightings can be looked up by date.

![Screen Shot 2019-07-12 at 11 04 37 AM](https://user-images.githubusercontent.com/50639575/61140700-e591cd00-a499-11e9-8782-d5c0dd8e4725.png)

Sightings can be looked up by shape.

![Screen Shot 2019-07-12 at 11 02 52 AM](https://user-images.githubusercontent.com/50639575/61140730-f9d5ca00-a499-11e9-9490-cdec0648e9cf.png)

Sightings can be looked up by location.

![Screen Shot 2019-07-12 at 11 08 59 AM](https://user-images.githubusercontent.com/50639575/61141091-c8113300-a49a-11e9-91a5-a9bf5cdf8b2a.png)

A user can select a sighting to edit from their list of reported sightings.

![Screen Shot 2019-07-12 at 11 10 42 AM](https://user-images.githubusercontent.com/50639575/61140368-597fa580-a499-11e9-97c1-7a54347a4cad.png) 

The date of sightings can be edited.

![Screen Shot 2019-07-12 at 11 10 09 AM](https://user-images.githubusercontent.com/50639575/61140408-68665800-a499-11e9-876b-6c4278678a20.png) 

The location of sightings can be edited.

![Screen Shot 2019-07-12 at 11 09 40 AM](https://user-images.githubusercontent.com/50639575/61141198-09094780-a49b-11e9-8b59-6a01ec436dbd.png)

The shape of sightings can be edited.

![Screen Shot 2019-07-12 at 11 11 11 AM](https://user-images.githubusercontent.com/50639575/61140292-38b75000-a499-11e9-91cb-c80d222a2ad9.png) 

A user can choose a sighting to delete from their list of reported sightings.

![Screen Shot 2019-07-12 at 11 07 09 AM](https://user-images.githubusercontent.com/50639575/61140619-be3b0000-a499-11e9-8e6e-23e61d0b3006.png) 

A user can 'disappear' which will delete their username and all of thier reported sightings.


## Authors

Kyle Conlon

Adrienne Miranda

## Acknowledgments

UFO sighting data was provided by: https://www.kaggle.com/NUFORC/ufo-sightings

👽🛸👽

