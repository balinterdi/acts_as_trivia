class <%= migration_name %> < ActiveRecord::Migration
  def self.up
    create_table :trivias do |t|
      t.string :on, :null => false
      t.string :about, :null => false
      t.string :displayed, :null => false
<% unless options[:skip_timestamps] %>
      t.timestamps
<% end -%>
    end

    create_table :trivia_answers, :force => true do |t|
      t.string  :trivia_id, :null => false
      t.string  :user_id, :null => false
      t.integer :points
<% unless options[:skip_timestamps] %>
      t.timestamps
<% end -%>
    end

    Trivia.create(:on => <%= %("#{trivia_entity}") %>, :about => <%= %("#{trivia_question_on}") %>, :displayed => <%= %("#{trivia_displayed}") %>)
  end

  def self.down
    drop_table :trivias
    drop_table :trivia_answers
  end
end
