require 'nexmo'
require 'json'
require '.\nexmo_creds.rb'

class OutboundSMSMessage
    include NexmoCredentials

    def initialize()
        @nexmo_client = Nexmo::Client.new(
            api_key: Key,
            api_secret: Secret
        )
    end

    def send_sms_message(from_number, to_number, message)
        @nexmo_client.sms.send(
            from: from_number,
            to: to_number,
            text: message
        )
    end

end