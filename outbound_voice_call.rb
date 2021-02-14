require 'vonage'
require 'json'
require '.\vonage_creds.rb'

class OutboundVoiceCall
    include VonageCredentials

    def initialize()
        @vonage_client = Vonage::Client.new(
        application_id: ID,
        private_key: KEY
        )
    end

    def connect_external_number(to_number, from_number)
        [{
            action: 'connect',
            from: from_number,
            endpoint: [{
                type: 'phone',
                number: to_number
            }]
        }].to_json
    end

    def not_an_option_message()

        [{
            action: "talk",
            text: "I'm sorry that is not an option",
            bargeIn: "False"
        }].to_json
    end

end