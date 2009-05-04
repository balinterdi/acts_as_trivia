* NoMethodError (undefined method `acts\_as\_trivia' for #<Class:0x253e9fc>):

  Make sure you have the config.gem "acts\_as\_trivia" line in your environment.rb

* Trivia will have its own model:

  create_table :trivias, :force => true do |t|
    t.string  :on, :null => false
    t.string  :about, :null => false
  end
  
  e.g
  
  Trivia.new(:on => "country", :about => "hdi")
  
  class Trivia < ActionRecord::Base
  
    def to\_param
      #{on}-#{about} # e.g country-hdi
    end
    
  And requests to trivias will have a routing like this:
  
  /trivias/1, or which is the same
  /trivias/country-hdi (and that latter will be generated)
  

* The User class will have the following added associations:

  class User < ActiveRecord::Base
  
    has_many :trivia_answers
    has_many :trivias, :through => :trivia_answers
    has_many :correct_trivia_answers, :through => :trivia_answers, :condition => { "state = ?", 'correct' }
    
* And the join model will be the TriviaAnswers class:

    create_table :trivia_answers, :force => true do |t|
      t.string  :trivia_id, :null => false
      t.string  :user_id, :null => false
      t.integer :points # how many points the user received for his answer
    end

* when the geneation script is called with the following:

  ./script/generate acts_as_trivia country hdi

  then the following things will be generated:

* a new trivia model OK

  class Trivia < ActiveRecord::Base
    def to\_param
      #{on}-#{about} # e.g country-hdi
    end
  end

* a new controller (if it does not exist yet) OK

  class TriviaController
  end

* new resource routes for trivia OK

  map.resources :trivias

* in the model (country.rb) OK:

  class Country < ActiveRecord::Base
    acts_as_trivia :hdi
    ...
  end

* added associations in the user model OK

  has_many :trivia_answers
  has_many :trivias, :through => :trivia_answers

* db migrations

  * for the trivia class itself OK

    create_table :trivias, :force => true do |t|
      t.string  :on, :null => false
      t.string  :about, :null => false
      t.timestamps
    end

  * for the join model between the user and the trivia OK

    create_table :trivia_answers, :force => true do |t|
      t.string  :trivia_id, :null => false
      t.string  :user_id, :null => false
      t.integer :points # how many points the user received for his answer
    end

