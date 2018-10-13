# cucumber scenarios are defined in features/*.feature file

# 3 scenarios (3 undefined)
# 17 steps (14 skipped, 3 undefined)
# 14 steps are defined in movie_steps.rb
# We need to define the other 3 steps in this file (movie_steps.rb) 

# You can implement step definitions for undefined steps with these snippets:
# Given(/^the following movies exist:$/) do |table|
#   # table is a Cucumber::MultilineArgument::DataTable
#   pending # Write code here that turns the phrase above into concrete actions
# end

Given(/^the following movies exist:$/) do |table|
  # table is a Cucumber::MultilineArgument::DataTable
  table.hashes.each do |hash|
    Movie.create hash
  end
end

Then /^the director of "(.+)" should be "(.+)"/ do |movie_name, director|
  movie = Movie.find_by(title: movie_name)
  visit movie_path(movie)
  expect(page.body).to match(/Director:\s#{director}/)
end