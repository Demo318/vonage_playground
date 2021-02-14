require '.\vonage_creds.rb'

module VoiceActions

    def connect_voice_number(outbound_number, from_number)
        {
            action: 'connect',
            endpoint: [{
                type: 'phone',
                number: outbound_number
                      }]
        }
    end

    def play_welcome()
        {
            action: "talk",
            text: "Welcome to the Devin Mork hotline. An entire hotline dedicated to Devin Mork",
            bargeIn: "False"
        }
    end

    def play_menu_options()
        {
            action: "talk",
            text: "Please choos from one of the following options"\
                  "Press one to call Devin's cellular phone"\
                  "Press two to send Devin a text message"\
                  "Press three to receive a link to Devin's website"\
                  "Press four to hear what Devin thinks about Matt Kanaskie"\
                  "Press five to hear what Devin's four-year-old son Felix thinks about Devin",
            bargeIn: "True"
        }
    end

    def receive_dtmf()
        {
            action: "input",
            type: [ 'dtmf' ],
            dtmf: {
                'maxDigits': 1,
                'timeOut': 5
            },
            eventUrl: ["#{base_url}/webhooks/dtmf"]
        }
    end
    



end
