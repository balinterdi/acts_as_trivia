module ActsAsTriviaCommands

  def route_trivia_answers_as_nested_resource
    sentinel = "ActionController::Routing::Routes.draw do |map|"
    unless options[:pretend]
      gsub_file "config/routes.rb", /(#{Regexp.escape(sentinel)})/mi do |match|
<<-EOS
#{match}
  map.resources :users do |users|
    users.resources :trivias do |trivias|
      trivias.resources :trivia_answers
    end
  end
  
EOS
      end
    end
    
  end
  
  def model_acts_as_trivia_includes(question)
    acts_as_trivia_call = "acts_as_trivia :#{question}"
    logger.modify acts_as_trivia_call

    sentinel = "class #{class_name} < ActiveRecord::Base"
    unless options[:pretend]
      gsub_file File.join("app/models", class_path, "#{singular_name}.rb"), /(#{Regexp.escape(sentinel)})/mi do |match|
<<-EOS
#{match}
  #{acts_as_trivia_call}
EOS
      end
    end
  end

end
