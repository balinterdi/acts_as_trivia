module TriviasHelper
  def trivia_dropdown(trivia)
    #TODO: the get_subjects call will query all instances of a model class (e.g Country.find(:all))
    # that may be exhaustive, even though Rails only executes the first and returns the cached result after
    select_tag("#{trivia.on}[#{trivia.about}][]", options_from_collection_for_select(trivia.get_subjects, :id, trivia.displayed.to_sym))
  end
end