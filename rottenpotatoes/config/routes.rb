Rottenpotatoes::Application.routes.draw do
  resources :movies
  # map '/' to be a redirect to '/movies'
  root :to => redirect('/movies')
  # define a new route.
  # HTTP method: get
  # URI: 'similar_movies/:id'. http request match with this URI. 
  #       Should use /:id for operation on a specific movie.
  # method in controller: 'movies#search'
  # name of this route: 'search_similar_movies'
  # In the view of show movie details (show.html.haml), 
  # we used:
  # = link_to 'Find Movies With Same Director', search_similar_movies_path(@movie),
  # so, we must name our new route as 'search_similar_movies',
  # or search_similar_movies_path(@movie) will not work.
  # Hint from hw instructions: 
  # "You can also use the key :as to specify a name to generate helpers (i.e. search_directors_path)"
  get 'same_director_movies/:title', to: 'movies#search', as: 'same_director_movies'
  # Run rake routes to see the new route is added.
end
