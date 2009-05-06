# Acts As Trivia

This gem adds a full-fletched trivia game to your Rails application. It only needs a (or more) model class(es) to operate on (the instances of which can be the subjects of the trivia) and an attribute of this class which is comparable.

## Installation
    
Put the following line in your environment.rb:

    config.gem "balinterdi-acts_as_trivia", :source => http://gems.github.com, :lib => "acts_as_trivia"
    
And then install it systemwide:

    rake gems:install
    
Or bundled with your app:

    rake gems:unpack

On Rails < 2.1 you can install it like this, too:

    gem install balinterdi-acts_as_trivia --source http://gems.github.com
    
However, I have run into some issues this way so I recommend using the config.gem way.

### Make your Rails app a trivia game

Once you have the gem installed you should run the **acts\_as\_trivia** generator:

    ./script/generate acts_as_trivia

This will "trivialize" your application, creating migrations for the new trivia-related classes, stub out the empty controllers and generate routes for them. Use _rake db:migrate_ to create the trivia-related classes in the database.

Now you can start adding trivia with the help of the **acts\_as\_trivia\_record** generator:

    ./script/generate acts_as_trivia_record country area name
    
This generator will add an acts\_as\_trivia call into your Country class (acts_as_trivia :area) and create migration for the actual trivia instance (_Trivia.create(:on => "country", :about => "area", :displayed => "name")_). To have the new trivia available in your app, don't forget to _rake db:migrate_

Create the TriviaAnswers _new_ and _create_ actions and some simple views for them. A quick way is to use the ones provided [in the rails application template](http://gist.github.com/raw/107361/f31caad451f0cca699288700aa3d98291a259fd1/gistfile1.rb).
(note: I am planning to modify the template so it can be applied just to create these actions and views)

Now go to

  /users/:user_id/trivias/1/trivia_answers/new
  
to test your knowledge!

### Rails application template

If you want a "quick-start" course or got to like the gem so much you would like to have it in your app from start, fear not. I assembled an application template just for this task (this will work starting from Rails 2.3):

    rails my_shiny_new_app -m http://gist.github.com/raw/107361/f31caad451f0cca699288700aa3d98291a259fd1/gistfile1.rb
    
## How does it work

Acts\_as\_trivia uses instances of the Trivia and TriviaAnswer classes to assess the knowledge of users. It only supposes that you have a User class of which the instances are the users of your application. 

It tries to mingle with your application as little as possible and provide a clean interface to work with. (if you feel this is not so, please let me know) It adds a couple of helper methods you can use in your views to create a trivia answer (trivia\_user\_panel and trivia_dropdown) and to show the correct answer (with\_each\_solution\_value).

## Disclaimer

Please consider this an early release and thus count on some bumps on the way. If you find one, let me know (<balint@bucionrails.com>).
