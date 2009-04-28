require "acts_as_trivia/trivia"
require "acts_as_trivia/trivia_answer"
require "acts_as_trivia/user"

module ActsAsTrivia
  module ClassMethods
    def acts_as_trivia(method)
      class << self
        define_method(:trivia_answer_for) do |name|
          self.scoped(:order => "#{name} DESC")
        end
        
        define_method(:assess_trivia) do |name, answer|
          correct_answer = trivia_answer_for(name).scoped(:limit => answer.length)
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

if Object.const_defined?("ActiveRecord")
  ActiveRecord::Base.send(:include, ActsAsTrivia)
end
