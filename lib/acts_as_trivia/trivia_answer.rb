class TriviaAnswer < ActiveRecord::Base
  belongs_to :trivia
  belongs_to :user
  
  def assess(answer)
    trivia.assess_answer(answer)
  end
end