* the show page of the trivia answer should show the solution of the trivia and mark which ones the user got right. After a user answered a trivia question, the redirect should land here. So does the answer have to be stored in the TriviaAnswer instance to make this detailed assessment? The other solution is to tell him how many he got right and then have a link to the trivia where the solution is presented.

* add the following methods to the user:

  * add_trivia(trivia)
  * played_trivia?(trivia)
  * trivia_points

* generate a migration that creates the trivia record(s) itself (themselves)

    e.g Trivia.create(:on => "country", :about => "hdi")
    
  This generator can be another one since this one should be called for each subsequent trivia question the developer comes up with.
  
* a user should not be able to answer a question more than once
* set up a template to generated a country-trivia site for quick testing
