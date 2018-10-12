# cucumber scenarios are defined in features/*.feature file

# All 'When', 'And' and 'Given' are already defined in web_steps.rb
# We need to define the steps for 'Then' in this movie_steps.rb


# Cucumber step for the first Scenario:
Then /^the director of "(.+)" should be "(.+)"/ do |movie_name, director|
  movie = Movie.find_by(title: movie_name)
  visit movie_path(movie)
  expect(page.body).to match(/Director:\s#{director}/)
end