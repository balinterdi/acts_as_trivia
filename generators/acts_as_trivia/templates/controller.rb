class <%= class_name %>TriviaController < ApplicationController
<% for action in actions -%>
  def <%= action %>
  end

<% end -%>
end
