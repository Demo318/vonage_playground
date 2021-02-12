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

helpers do
  def parsed_body
    JSON.parse(request.body.read)
  end
end

before do
  content_type :json
end

numbers = PhoneNumbersList.new

get '/' do
    'Good news. It\'s working'
end

route :get, :post, '/webhooks/answer' do

  call = InboundVoiceCall.new(params[:to],
                              params[:from],
                              params[:uuid],
                              params[:conversation_uuid]
                             )



 call.play_main_menu(request.base_url)
  
end

route :get, :post, '/webhooks/dtmf' do
  dtmf = params['dtmf'] || parsed_body['dtmf']

 
  case dtmf["digits"]
  when "1"
    outbound_call = OutboundVoiceCall.new
    outbound_call.connect_external_number(numbers.devin_cell, '13165198556')
  when "2"
    # send SMS to d
    #   sms to reply to
    #   receive and forward
  when "3"
    # receive sms to Devin's website
  when "4"
    # hear what devin thinks about k
  when "5"
    # hear what felix thinks
  else
    # "not an option" replay menu
  end


end

set :port, 3000