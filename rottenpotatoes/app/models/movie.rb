class Movie < ActiveRecord::Base
  def self.all_ratings
    %w(G PG PG-13 NC-17 R)
  end
  
  # define search_by_director as a class method (prefixed with 'self.')
  # Method not belonging to CRUD should be defined manually.
  def self.search_by_director(id)
    # get the director name of this movie. Search by this name.
    director = Movie.find_by(id: id).director
    if director.nil? or director.blank?
      return nil
    else
      # Use pluck as a shortcut to select one or more attributes 
      # without loading a bunch of records just to grab the attributes you want.
      return Movie.where(director: director).pluck(:title)
    end
  end
  
end
