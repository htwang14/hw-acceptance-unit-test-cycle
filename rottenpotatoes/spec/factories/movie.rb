# http://pastebin.com/60Th29d1
# from SaaS book

FactoryGirl.define do
  factory :movie do
    title 'A Fake Title' # default values
    rating 'PG'
    release_date { 10.years.ago }
    director 'Tom'
  end
end