class Trivia < ActiveRecord::Base
  has_many :trivia_answers
  
  def to_param
    "#{on}-#{about}"
  end
  
  def assess(answer)
    trivia_link_class.assess_trivia(about.to_sym, answer)
  end
  
  def get_subjects
    trivia_link_class.find(:all)
  end
  
  private
  def trivia_link_class
    on.capitalize.constantize
  end
end
