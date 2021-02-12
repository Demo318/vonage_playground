require 'sinatra'
require 'sinatra/multi_route'
require 'json'

before do
  content_type :json
end

get '/' do
    'Good news. It\'s working'
  end

route :get, :post, '/webhooks/answer' do
  [{
    action: 'connect',
    endpoint: [{
      type: 'phone',
      number: '17635679484'
    }]
  }].to_json
end

set :port, 3000