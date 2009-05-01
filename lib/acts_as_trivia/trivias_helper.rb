module TriviasHelper
  def trivia_user_panel(trivia)
    (1..trivia.length).inject("") { |out, i| out + content_tag(:div, "#{i}. #{trivia_dropdown(trivia)}")}
    # (1..trivia.length).map { content_tag(:div, trivia_dropdown(trivia)) }
  end
  def trivia_dropdown(trivia)
    #TODO: the get_subjects call will query all instances of a model class (e.g Country.find(:all))
    #That may be too exhaustive
    select_tag("#{trivia.on}[#{trivia.about}][]", options_from_collection_for_select(trivia.get_subjects, :id, trivia.displayed.to_sym))
  end
  
  def with_each_solution_value(trivia)
    trivia.get_solution_values.each_with_index do |name_and_value, i|
      name, value = name_and_value
      yield i+1, name, value
    end
  end
end