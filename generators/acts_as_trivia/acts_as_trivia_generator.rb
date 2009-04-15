require 'rails_generator'

module ActsAsTriviaRoutes
    
  def controller_routes(*questions)
      new_routes = questions.map do |question|
        "trivia.#{file_name}_#{question}_trivia '/#{plural_name}/trivia/#{question}', :action => '#{question}'"
      end.join("\n")
      logger.route "#{self.class}:#{self.object_id}"
      logger.route "map.with_options(:controller => '#{file_name}_trivia') do |trivia|"

      sentinel = 'ActionController::Routing::Routes.draw do |map|'      
      unless options[:pretend]
        gsub_file 'config/routes.rb', /(#{Regexp.escape(sentinel)})/mi do |match|
<<-EOS
#{match}
  map.with_options(:controller => '#{file_name}_trivia') do |trivia|
    #{new_routes}
  end
EOS
        end
      end    
  end
       
end

class ActsAsTriviaGenerator < Rails::Generator::NamedBase # ControllerGenerator
    
  def manifest
    record do |m|
      # Check for class naming collisions.
      m.class_collisions class_path, "#{class_name}TriviaController"

      # Controller, helper, views, and spec directories.
      m.directory File.join('app/controllers', class_path)

      # Controller spec, class, and helper.
      m.template 'controller.rb', 
        File.join('app/controllers', class_path, "#{file_name}_trivia_controller.rb")

      logger.route "#{m.class}:#{m.object_id}"
      m.controller_routes actions
      
      # view template for each action. (= for each trivia question)
      actions.each do |action|
        #TODO: strip invalid characters from action, make it filename like
        path = File.join('app/views', class_path, file_name, "#{action}.html.erb")
        m.template 'view.html.erb', path,
          :assigns => { :action => action, :path => path }
      end
    end
  end
end

Rails::Generator::Commands::Base.send(:include, ActsAsTriviaRoutes)