require 'rubygems'
require 'rake'
require 'echoe'

Echoe.new('acts_as_trivia', '0.0.1') do |p|
  p.description    = "Because everybody loves to play games"
  p.url            = "http://github.com/balinterdi/acts_as_trivia"
  p.author         = "Balint Erdi"
  p.email          = "balint.erdi@gmail.com"
  p.ignore_pattern = ["tmp/*", "script/*"]
  p.development_dependencies = []
end

Dir["#{File.dirname(__FILE__)}/tasks/*.rake"].sort.each { |ext| load ext }
