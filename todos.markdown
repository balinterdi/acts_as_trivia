* the show page of the trivia answer should show the solution of the trivia and mark which ones the user got right. After a user answered a trivia question, the redirect should land here. So does the answer have to be stored in the TriviaAnswer instance to make this detailed assessment? The other solution is to tell him how many he got right and then have a link to the trivia where the solution is presented.
The solution should not be stored in the trivia answer. Rather, the show action of the trivia should show the correct solution and the page should only be shown to users who have already played that trivia.
* get the trivia views use the trivias_helper.rb file and so helper.rb does not have to be generated into the host app's code
* the trivia will have to include how many items has to be asserted (that is, the length of the trivia) since that has to be known on many screens. A sensitive default can be three. Rewrite methods where an actual number is written instead of this value.

* generate a migration that creates the trivia record(s) itself (themselves)

    e.g Trivia.create(:on => "country", :about => "hdi")
    
  This generator can be another one since this one should be called for each subsequent trivia question the developer comes up with.
  
* a user should not be able to answer a question more than once
* set up a template to generate a country-trivia site for quick testing
