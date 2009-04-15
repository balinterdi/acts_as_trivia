module ActsAsTrivia
  module ClassMethods
    def acts_as_trivia(method)
      class << self
        define_method(:trivia_answer_for) do |name|
          self.find(:all, :order => "#{name} DESC", :limit => 5)
        end
        
        define_method(:assess_trivia) do |name, answer|
          correct_answer = trivia_answer_for(name)
          score = 0
          answer.each_with_index do |elt, idx|
            score += elt == correct_answer[idx] ? 1 : 0
          end
          score
        end
      end
    end
  end

  class << self
    def included(base)
      base.extend(ClassMethods)
    end
  end

end