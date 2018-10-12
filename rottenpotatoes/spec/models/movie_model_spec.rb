require 'rails_helper'
# Learn spec from:
# https://semaphoreci.com/community/tutorials/getting-started-with-rspec

# Entries created here will persist in the testing db.
# So, we need to first destroy all entries here to get a fresh clean Movie table in the testing db.
# We can also run 'rake db:test:prepare' to clear up the mess caused by previous testings.
Movie.destroy_all
# | title        | rating | director     | release_date |
# | Star Wars    | PG     | George Lucas |   1977-05-25 |
# | Blade Runner | PG     | Ridley Scott |   1982-06-25 |
# | Alien        | R      |              |   1979-05-25 |
# | THX-1138     | R      | George Lucas |   1971-03-11 |
# Define the table of testing db: 
movie1 = Movie.create!(:title=>'Star Wars', :rating=>'PG', :director=>'George Lucas', :release_date=>'1977-05-25')
movie2 = Movie.create!(:title=>'Blade Runner', :rating=>'PG', :director=>'Ridley Scott', :release_date=>'1982-06-25')
movie3 = Movie.create!(:title=>'Alien', :rating=>'R', :release_date=>'1979-05-25')
movie4 = Movie.create!(:title=>'THX-1138', :rating=>'R', :director=>'George Lucas', :release_date=>'1971-03-11')


describe Movie do
# With RSpec, we are always describing the behavior of classes, modules and their methods. 
# The describe block is always used at the top to put specs in a context.
# It can accept either a class name, in which case the class needs to exist, or any string you'd like.    
    
    describe 'class method Movie.search_by_director' do
    # We are using another describe block to describe the search_by_director class method. 
    # By convention, class methods are prefixed with a dot (".search_by_director"), and instance methods with a dash ("#search_by_director").
        
        context 'When the specified movie has a director' do
        # We are using a context block to describe the behaviour of the method (search_by_director) under a certain context. 
        # Context is technically the same as describe, but is used in different places, to aid reading of the code.
            
            # if I search by a movie which has a director, method should return exactly the titles of all movies with the same director.
            it 'returns the titles of all movies with the same director' do
            # We are using an it block to describe a specific example, which is RSpec's way to say "test case". 
            # ...  with the context should form an understandable sentence:
            
                # expect(Movie.search_by_director(movie1.title)).to eql(['Star Wars','THX-1138']) # use poetry mod as below:
                expect(Movie.search_by_director movie1.title).to eql ['Star Wars','THX-1138']
                # expect(...).to and the negative variant expect(...).not_to are used to define expected outcomes.
                # The Ruby expression they are given (in our case, ) is combined with a matcher to fully define an expectation on a piece of code. 
                # The matcher we are using here is eql, a basic equality matcher. RSpec comes with many more matchers.
            end
            
            # should should find movies by the same director. (example 1 actually covers example 2)
            it 'does not return the titles of any movie with a different director' do
                expect(Movie.search_by_director(movie2.title)).to include 'Blade Runner'
            end
            
            # should not find movies by different directors. (example 1 actually covers example 3)
            it 'does not return the titles of any movie with a different director' do
                expect(Movie.search_by_director(movie2.title)).to_not include 'Star Wars'
            end
            
        end
        # end of context
        
        # sad path:
        context 'When the specified movie has no director' do
            it 'returns nil' do
                expect(Movie.search_by_director(movie3.title)).to equal nil
            end
        end
        # end of context
        
    end
    # end of discribe method
end
# end of discribe class