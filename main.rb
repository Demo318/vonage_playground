require 'sinatra'
require 'sinatra/multi_route'
require 'json'

# Phone numbers, private credentials kept in separate class files, added to  .gitignore for privacy.
include '.\phone_numbers.rb'

before do
  content_type :json
end

numbers = PhoneNumbersList.new

get '/' do
    'Good news. It\'s working'
  end

route :get, :post, '/webhooks/answer' do
  [{
    action: 'connect',
    endpoint: [{
      type: 'phone',
      number: numbers.devin_office
    }]
  }].to_json
end

set :port, 3000