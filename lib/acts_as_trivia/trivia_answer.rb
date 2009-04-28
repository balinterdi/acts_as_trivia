class TriviaAnswer < ActiveRecord::Base
  belongs_to :trivia
  belongs_to :user
end