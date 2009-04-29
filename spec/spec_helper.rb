require 'rubygems'
require "active_record"

# setting up test environment is snatched from how Paperclip does it
ROOT = File.join(File.dirname(__FILE__), '..')
$LOAD_PATH << File.join(ROOT, 'lib')
$LOAD_PATH << File.join(ROOT, 'lib', 'acts_as_trivia')

require File.join(ROOT, "lib", "acts_as_trivia.rb")

ENV['RAILS_ENV'] ||= 'test'

config = YAML::load(IO.read(File.dirname(__FILE__) + '/database.yml'))
ActiveRecord::Base.logger = Logger.new(File.dirname(__FILE__) + "/debug.log")
ActiveRecord::Base.establish_connection(config['test'])

def rebuild_trivias_table
  ActiveRecord::Base.connection.create_table :trivias, :force => true do |table|
    table.column :on, :string
    table.column :about, :string
    table.column :displayed, :string
    table.column :length, :integer
  end
end

def rebuild_trivia_answers_table
  ActiveRecord::Base.connection.create_table :trivia_answers, :force => true do |table|
    table.column :user_id, :string
    table.column :trivia_id, :string
    table.column :points, :integer, :default => 0
  end
end

def rebuild_countries_table
  ActiveRecord::Base.connection.create_table :countries, :force => true do |table|
    table.column :hdi, :float
    table.column :population, :integer
    table.column :area, :integer
    table.column :name, :string
  end
end

def rebuild_users_table
  ActiveRecord::Base.connection.create_table :users, :force => true do |table|
    table.column :login, :string
  end  
end

def rebuild_all_tables
  rebuild_trivias_table
  rebuild_trivia_answers_table
  rebuild_countries_table
  rebuild_users_table
end