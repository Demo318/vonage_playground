#gems
require 'sinatra'
require 'sinatra/multi_route'

#ruby modules
require 'json'

# own class files
require '.\vonage_client.rb'
require '.\sms_conversations.rb'

# Phone numbers, private credentials kept in separate class files, added to .gitignore for privacy.
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
sms_conversations = SMSConversations.new

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

route :get, :post, '/webhooks/main_menu_repeat' do
  client = VonageClient.new

  jsonify(
    [
      client.main_menu_again_courtesy,
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
    # initiate 2-way SMS w/ Devin
    sms_conversations.add_new_conversation(from)

    client.send_sms_message(
      client.vonage,
      to,
      from,
      "Please reply to this message to send an SMS to Devin. "
    )
    jsonify([
      client.text_sent
    ])
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
    client.send_sms_message(
      client.vonage,
      to,
      from,
      File.read('.\media\musicalperformance_source.txt').to_s
      )
    jsonify([
      client.force_return_to_main_menu_message,
      client.introduce_musical_performance,
      client.play_musical_performance(request.base_url),
      client.force_return_to_main_menu(request.base_url)
    ])
  when "5"
    # happy birthday
    jsonify([
      client.force_return_to_main_menu_message,
      client.introduce_happy_birthday,
      client.play_happy_birthday(request.base_url),
      client.force_return_to_main_menu(request.base_url)
    ])
  else
    # not an option, main menu again
    jsonify([
      client.invalid_option,
      client.play_menu_options,
      client.receive_dtmf(request.base_url)
    ])
  end

end

route :get, :post, '/webhooks/events' do
  puts parsed_body.to_s
end

route :get, :post, '/webhooks/inbound-sms' do
  client = VonageClient.new

  from_number = params['msisdn']
  from_number_ref = from_number[-4...]
  if from_number == numbers.devin_cell
    to_number_ref = params['text'][0..3]
    message = params['text'][4...]
    #check prefix four digits against recipient list
    client.send_sms_message(
      client.vonage,
      numbers.vonage_test,
      sms_conversations.find_recipient_number(to_number_ref),
      message
    )
  elsif sms_conversations.find_recipient_number(from_number_ref) != false
    #forward onto devin cell w/ prefix four digits
    client.send_sms_message(
      client.vonage,
      numbers.vonage_test,
      numbers.devin_cell,
      from_number_ref + ' ' + params['text']
    )
  else
    #new conversation
    sms_conversations.add_new_conversation(from_number)

    client.send_sms_message(
      client.vonage,
      numbers.vonage_test,
      numbers.devin_cell,
      from_number_ref + ' ' + params['text']
    )

    client.send_sms_message(
      client.vonage,
      numbers.vonage_test,
      from_number,
      "Thank you for texting the Devin Mork hotline!"
    )

  end

end

get '/media/:filename' do |filename|
  send_file "./media/#{filename}", :filename => filename, :type => 'Application/octet-stream'
end

set :port, 3000