require 'rails_helper'
# If the spec file is not under spec/controllers,
# methods like get and post will not be automatically made available by rspec-rails.


describe MoviesController do
# the MoviesController class
    
    describe 'controller method search (movies with the same director)' do
    # the search method
        
        context 'When the specified movie has a director' do
            
            # do this before each 'it' block:
            before :each do
               # create an array of two “test double” Movie objects 
               @fake_results = [double('movie1'), double('movie2')] 
            end
            
            it 'should call Movie.search_by_director(id) class method' do
                # set up a test double for Movie.search_by_director.
                # search_by_director doesn't have to be defined in the movie model.
                # Movie.search_by_director must be called to pass the test.
                Movie.should_receive(:search_by_director).with('asdf').and_return(@fake_results)
                # or: expect(Movie).to receive(:search_by_director).with('asdf').and_return(fake_results)
                get :search, {:title => 'asdf'}
            end
            
            it 'should render search view' do
                # set up a test double for Movie.search_by_director.
                # Movie.search_by_director doesn't have to be called to pass the test.
                Movie.stub(:search_by_director).with('asdf').and_return(@fake_results)
                get :search, {:title => 'asdf'}
                response.should render_template('search')
            end
        end
        
        context 'When the specified movie has no director' do
            it 'should render index view (home page)' do
                Movie.stub(:search_by_director).with('asdf').and_return(nil)
                get :search, {:title => 'asdf'}
                expect(response).to redirect_to(movies_path)
            end
        end
    
    end
    # method describe ends
    
    describe 'controller method index' do
        
        # create test object:
        # Use let to define a memoized helper method. The value will be cached
        # across multiple calls in the same example but not across examples.
        
        # Note that let is lazy-evaluated: it is not evaluated until the first time
        # the method it defines is invoked. You can use let! to force the method's
        # invocation before each example.
        let!(:movie) {FactoryGirl.create(:movie)}
        

        it 'should render the index template' do
            get :index
            response.should render_template('index')
        end

        it 'should assign instance variable title_header with hilite' do
            get :index, { sort: 'title'}
            assigns(:title_header).should eql('hilite')
        end
    
        it 'should assign instance variable release_date with hilite' do
            get :index, { sort: 'release_date'}
            assigns(:date_header).should eql('hilite')
        end
        # The last two it block coresponse to these codes in the controller:
        #   when 'title'
        #       ordering,@title_header = {:title => :asc}, 'hilite'
        #   when 'release_date'
        #       ordering,@date_header = {:release_date => :asc}, 'hilite'
        #   end
    end
    
end
# class describe ends