#gems
require 'sinatra'
require 'sinatra/multi_route'

#ruby modules
require 'json'

# own class files
require '.\vonage_client.rb'

# Phone numbers, private credentials kept in separate class files, added to  .gitignore for privacy.
require '.\phone_numbers.rb'

helpers do
  def parsed_body
    JSON.parse(request.body.read)
  end

  def jsonify(text)
    return text.to_json
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

  client = VonageClient.new

  jsonify(
    [
      client.play_welcome,
      client.play_menu_options,
      client.receive_dtmf(request.base_url)
    ]
  )
  
end

route :get, :post, '/webhooks/dtmf' do
  pbody = parsed_body
  dtmf = pbody['dtmf']
  from = pbody['from']
  to = pbody['to']

  client = VonageClient.new

 
  case dtmf["digits"]
  when "1"
    jsonify(
      [
        client.connection_notification,
        client.connect_voice_number(numbers.devin_cell, from)
      ]
    )
  when "2"
    nexmo = OutboundSMSMessage.new
    nexmo.send_sms_message(to, from, "Simply reply here to send a text to Devin! ")
  when "3"
    client.send_sms_message(
      client.vonage,
      to,
      from,
      "http://finalsigma.io "
    )
    jsonify([
      client.text_sent,
      client.main_menu_again_courtesy,
      client.play_menu_options,
      client.receive_dtmf(request.base_url)
    ])
  when "4"
    # musical performance
  when "5"
    # happy birthday
  else
    # not an option, main menu again
  end

end

route :get, :post, '/webhooks/inbound-sms' do
  # reply 'thank you for messaging'
  # forward to devin's cell number (showing from number and message)
  # reference: https://developer.nexmo.com/messaging/sms/code-snippets/receiving-an-sms
  pbody = parsed_body
  puts pbody
  status 204
end

set :port, 3000