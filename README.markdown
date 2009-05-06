# Acts As Trivia

This gem adds a full-fletched trivia game to your Rails application. It only needs a (or more) model class(es) to operate on (the instances of which can be the subjects of the trivia) and an attribute of this class which is comparable.

## Installation

The gem is stored on github, so you can install it on your system like this:

    gem install balinterdi-acts_as_trivia --source http://gems.github.com
    
Or (starting from Rails 2.2) have your Rails application take care of it. Put the following line in your environment.rb:

    config.gem "balinterdi-acts_as_trivia", :source => http://gems.github.com, :lib => "acts_as_trivia"
    
And then install it systemwide:

    rake gems:install
    
Or bundled with your app:

    rake gems:unpack
    
## Make your Rails app a trivia game

Once you have the gem installed you should run the **acts\_as\_trivia** generator:

    ./script/generate acts_as_trivia country population name

This will "trivialize" your application and will also add a trivia instance which asks the daring players to rank countries in descending order of their _population_ (they have to assert the first three). The provided helpers use the _name_ attribute of the countries to display to the user. Use _rake db:migrate_ to create the trivia in the database.

The generator will add an acts\_as\_trivia call into your model class, create migrations for the new trivia-related classes, stub out the empty controllers and generate routes for them.

If you'd like to add further trivia you should use the **acts\_as\_trivia\_record** generator:

    ./script/generate acts_as_trivia_record country area name
    
To have the new trivia in your app, don't forget to _rake db:migrate_

## Rails application template

If you want a "quick-start" course or got to like the gem so much you would like to have it in your app from start, fear not. I assembled an application template just for this (this will work starting from Rails 2.3):

    rails my_shiny_new_app -m http://gist.github.com/raw/107361/f31caad451f0cca699288700aa3d98291a259fd1/gistfile1.rb
    
## How does it work

Acts\_as\_trivia uses instances of the Trivia and TriviaAnswer classes to assess the knowledge of users. It only supposes that you have a User class of which the instances are the users of your application. 

It tries to mingle with your application as little as possible and provide a clean interface to work with. (if you feel this is not so, please let me know) It adds a couple of helper methods you can use in your views to create a trivia answer (trivia\_user\_panel and trivia_dropdown) and to show the correct answer (with\_each\_solution\_value) 
