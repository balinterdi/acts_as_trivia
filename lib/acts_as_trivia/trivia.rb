class Trivia < ActiveRecord::Base
  has_many :trivia_answers
  
  def to_param
    "#{id}-#{on}-#{about}"
  end
  
  def assess_answer(answer)
    correct_answer = get_solution.scoped(:limit => answer.length)
    score = 0
    answer.each_with_index do |elt, idx|
      score += elt == correct_answer[idx] ? 1 : 0
    end
    score
  end
  
  def get_subjects
    trivia_link_class.find(:all)
  end
  
  def get_solution_values
    solution = get_solution.scoped(:limit => length)
    solution.map { |elt| [elt.send(displayed.to_sym), elt.send(about.to_sym)] }
  end
  
  private
  def get_solution
    trivia_link_class.trivia_answer_for(about.to_sym)
  end
  def trivia_link_class
    on.capitalize.constantize
  end
end
