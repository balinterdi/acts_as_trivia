class Trivia < ActiveRecord::Base  
  def to_param
    "#{on}-#{about}"
  end
  
  def assess(answer)
    trivia_link_class.assess_trivia(about.to_sym, answer)
  end
  
  private
  def trivia_link_class
    on.capitalize.constantize
  end
end
