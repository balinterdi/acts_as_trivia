class Trivia < ActiveRecord::Base
  has_many :trivia_answers
  
  def to_param
    "#{id}-#{on}-#{about}"
  end
  
  def assess(answer)
    trivia_link_class.assess_trivia(about.to_sym, answer)
  end
  
  def get_subjects
    trivia_link_class.find(:all)
  end
  
  def get_solution_values
    solution = trivia_link_class.trivia_answer_for(about)
    solution.map { |elt| [elt.send(displayed.to_sym), elt.send(about.to_sym)] }
  end
  
  private
  def trivia_link_class
    on.capitalize.constantize
  end
end
