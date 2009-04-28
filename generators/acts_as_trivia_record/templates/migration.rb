class <%= migration_name %> < ActiveRecord::Migration
  def self.up
    Trivia.create(:on => <%= %("#{trivia_on}") %>, :about => <%= %("#{trivia_about}") %>, :displayed => <%= %("#{trivia_displayed}") %>)
  end
  
  def self.down
  end
end