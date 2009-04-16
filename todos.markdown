* retain the values in the dropdowns that the user chose
* how should the controller action be set up? should it go into a sep. controller class? TriviaController? should the controller of the model that defines acts\_as\_trivia have a trivia action (and a view) that knows (from a hidden field) which trivia of the model class is to be rendered/assessed?
* generate the gem and build it as a rails local gem into (vendor/gems). Use rake:unpack after the gem has been defined as a config.gem declaration.
* the problem I run into again and again is that maybe trivia should be a model on its own but the associations need not be set up between _instances_ of the acts\_as\_trivia but between the class that has acts\_as\_trivia and the potential trivia class
* this would have to be generated into view.html.erb

<% form_tag "#{singular_name}_#{action}_trivia_path"  do -%>
  <% 3.times do -%>
    <div>
      <%= select_tag("#{singular_name}[#{action}][]", options_from_collection_for_select("@#{plural_name}", :id, :name)) %>
    </div>
  <% end -%>
  <%= submit_tag "Submit" %>
<% end %>

but it fails since it wants to evaluate form_tag during the generation. This also fails:

<%= "<% form_tag "#{singular_name}_#{action}_trivia_path"  do -%>" %>

because <% %> tags can not be nested.

So it has to be written like this:

'<'+"% form_tag ... do -%"+'>'