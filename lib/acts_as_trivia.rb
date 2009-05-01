require "acts_as_trivia/trivia"
require "acts_as_trivia/trivia_answer"
require "acts_as_trivia/user"
require "acts_as_trivia/trivias_helper"

module ActsAsTrivia
  module ClassMethods
    def acts_as_trivia(method)
      class << self
        define_method(:trivia_answer_for) do |name|
          self.scoped(:order => "#{name} DESC")
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

#NOTE: at this point, the controllers of the app (e.g TriviaAnswersController) are not yet defined
# so the helpers can not be included. On the other hand, if I define the controller class here
# the controller will not be defined in the app and so the actions will not be available.
# Thus the autoload solution.
#NOTE: autoload does not play well with the class reloading that Rails does in the dev. environment
# the helper methods that TriviaAnswersController includes will only be available
# at the first request after the server request (when autoload is executed)
# autoload :TriviaAnswersController, "acts_as_trivia/trivia_answers_controller"

if Object.const_defined?("ActionView")
  ActionView::Base.send(:include, TriviasHelper)
end
