class MoviesController < ApplicationController
  
  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date, :director)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    sort = params[:sort] || session[:sort]
    case sort
    when 'title'
      ordering,@title_header = {:title => :asc}, 'hilite'
    when 'release_date'
      ordering,@date_header = {:release_date => :asc}, 'hilite'
    end
    @all_ratings = Movie.all_ratings
    @selected_ratings = params[:ratings] || session[:ratings] || {}
    
    if @selected_ratings == {}
      @selected_ratings = Hash[@all_ratings.map {|rating| [rating, rating]}]
    end
    
    if params[:sort] != session[:sort] or params[:ratings] != session[:ratings]
      session[:sort] = sort
      session[:ratings] = @selected_ratings
      redirect_to :sort => sort, :ratings => @selected_ratings and return
    end
    @movies = Movie.where(rating: @selected_ratings.keys).order(ordering)
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end
  
  # put method, for adding director name.
  def put
    @movie = Movie.find(params[:id])
    @mocie.director = params[:director]
  end
  
  # search method, for searching movies with the same director.
  # Every method should have a view with the same name, unless the method runs 'redirect_to' to another view.
  # So, we need to define a new view: search.html.haml
  def search
    # need to define a new view: search.html.haml
    # This controller method pass two instance variables to the view: @movie and @search_result_movies.
    # @title: search by this movie's director.
    # @search_result_movies: the searching result.
    @title = params[:title] # retrieve movie ID from URI route
    # search_by_director is a self-defined class mothod (in movies_helper.rb).
    # Method not belonging to CRUD should be defined manually.
    @search_result_movies = Movie.search_by_director(@title)
    if @search_result_movies == nil # @search_result_movies<==>Movie.search_by_director(title)==nil<==>that movie has no director
      redirect_to movies_path # If a movie has no director, go to the index page.
    else # Else go to the search view.
      
    end
  end
  
end
