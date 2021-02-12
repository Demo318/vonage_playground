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

        #customer TTS reference: https://developer.nexmo.com/voice/voice-api/guides/customizing-tts

        main_menu_tts = "Welcome to the Devin Mork hotline. An entire hotline dedicated to Devin Mork."\
                     "Please choos from one of the following options."\
                     "Press one to call Devin's cellular phone."\
                     "Press two to send Devin a text message."\
                     "Press three to receive a link to Devin's website."\
                     "Press four to hear what Devin thinks about Matt Kanaskie."\
                     "Press five to hear what Devin's four-year-old son Felix thinks about Devin."
        
        [{
            action: "talk",
            text: main_menu_tts,
            bargeIn: "True"
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