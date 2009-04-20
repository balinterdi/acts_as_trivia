* when the geneation script is called with the following:

  ./script/generate acts_as_trivia country hdi

  then the following things will be generated
  
  * a new trivia model
  
  class Trivia < ActiveRecord::Base
    def to\_param
      #{on}-#{about} # e.g country-hdi
    end
  end

  * a new controller (if it does not exist yet)
  
  class TriviaController
  end

  * new resource routes for trivia
  
  map.resources :trivias
  
  * in the model (country.rb):

  class Country < ActiveRecord::Base
    acts_as_trivia :hdi
    ...
  end
  
  * added associations in the user model
  
  has_many :trivia_answers
  has_many :trivias, :through => :trivia_answers
  <!-- has_many :correct_trivia_answers, :through => :trivia_answers, :condition => { "state = ?", 'correct' }   -->
  
  * db migrations
  
    * for the trivia class itself
    
      create_table :trivias, :force => true do |t|
        t.string  :on, :null => false
        t.string  :about, :null => false
        t.timestamps
      end
  
    * for the join model between the user and the trivia  
    
      create_table :trivia_answers, :force => true do |t|
        t.string  :trivia_id, :null => false
        t.string  :user_id, :null => false
        t.integer :points # how many points the user received for his answer
      end
    