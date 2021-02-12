class InboundVoiceCall

    attr_reader :to_number, :from_number, :uuid, :conversation_uuid

    def initialize(call_to, call_from, call_uuid, call_conversation_uuid)
        @to_number = call_to
        @from_number = call_from
        @uuid = call_uuid
        @conversation_uuid = call_conversation_uuid
    end

    def connect_voice_number(outbound_number, from_number)
        [{
            action: 'connect',
            endpoint: [{
                type: 'phone',
                number: outbound_number
                      }]
        }].to_json
    end

    def play_main_menu(base_url)
        
        [{
            action: "talk",
            text: "Welcome to the Devin Mork hotline. An entire hotline dedicated to Devin Mork. Please choos from one of the following options.",
        },
        {
            action: "input",
            type: [ 'dtmf' ],
            dtmf: {
                'maxDigits': 1,
                'timeOut': 5
            },
            eventUrl: ["#{base_url}/webhooks/dtmf"]
        }].to_json


    end

end