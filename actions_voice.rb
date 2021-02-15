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

    def connection_notification()
        {
            action: "talk",
            text: "Thank you, connecting you now",
            bargeIn: "False"
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
            text: "Please choose from one of the following options. "\
                  "Press one to call Devin's cellular phone. "\
                  "Press two to send Devin a text message. "\
                  "Press three to receive a link to Devin's website. "\
                  "Press four to hear a musical performance by Devin Mork. "\
                  "Press five if it's your birthday.",
            bargeIn: "True"
        }
    end

    def receive_dtmf(base_url)
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

    def text_sent()
        {
            action: "talk",
            text: "Thank you a text message has been sent to this number",
            bargeIn: "False"
        }
    end

    def main_menu_again_courtesy()
        {
            action: "talk",
            text: "Please stay on the line to hear the main menu again.",
            bargeIn: "False"
        }
    end

end
