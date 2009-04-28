class User < ActiveRecord::Base
  has_many :trivia_answers
  has_many :trivias, :through => :trivia_answers  
  
  def add_trivia(trivia)
    trivia_answers.create(:trivia => trivia)
  end
  
  def played_trivia?(trivia)
    trivias.include?(trivia)
  end
  
  def trivia_points
    trivia_answers.sum(:points)
  end
end