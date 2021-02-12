#gems
require 'sinatra'
require 'sinatra/multi_route'

#ruby modules
require 'json'

# own class files
require '.\inbound_voice_call.rb'
require '.\outbound_voice_call.rb'
require '.\outbound_sms_message.rb'

# Phone numbers, private credentials kept in separate class files, added to  .gitignore for privacy.
require '.\phone_numbers.rb'


before do
  content_type :json
end

numbers = PhoneNumbersList.new

get '/' do
    'Good news. It\'s working'
end

route :get, :post, '/webhooks/answer' do

  puts "the params are " + params.to_s
  puts "the answer params are " + params["answer"].to_s


  call = InboundVoiceCall.new(params[:to],
                              params[:from],
                              params[:uuid],
                              params[:conversation_uuid]
                             )



 call.play_main_menu(request.base_url)
  
end

route :get, :post, '/webhooks/dtmf' do
  dtmf = params['dtmf']


  [{
    action: 'talk',
    text: "You pressed #{dtmf['digits']}"
  }].to_json


end

set :port, 3000