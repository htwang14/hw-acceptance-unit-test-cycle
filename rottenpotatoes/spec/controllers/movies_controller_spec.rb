require 'rails_helper'
# If the spec file is not under spec/controllers,
# methods like get and post will not be automatically made available by rspec-rails.


describe MoviesController do
# the MoviesController class
    
    describe 'instance method search (movies with the same director)' do
    # the search method
        
        context 'When the specified movie has a director' do
            it 'should call Movie.search_by_director(id) class method' do
                expect(Movie).to receive(:search_by_director).with('asdf')
                get :search, { :title => 'asdf' }
            end
        end
        
        context 'When the specified movie has no director' do
            it 'should go to the index page' do
                Movie.stub(:search_by_director).with('asdf').and_return(nil)
                get :search, { title: 'asdf' }
                expect(response).to redirect_to(movies_path)
            end
        end
    
    end
    # method describe ends
end
# class describe ends