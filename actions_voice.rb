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
            type: ['dtmf'],
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
            text: "Thank you. A text message has been sent to your phone.",
            bargeIn: "False"
        }
    end

    def main_menu_again_courtesy()
        {
            action: "talk",
            text: "Stay on the line to hear the main menu again.",
            bargeIn: "False"
        }
    end

    def invalid_option()
        {
            action: "talk",
            text: "I'm sorry, that entry is invalid.",
            bargeIn: "False"
        }
    end

    def force_return_to_main_menu_message()
        {
            action: "talk",
            text: "Press any key to return to the main menu.",
            bargeIn: "True"
        }

    end

    def force_return_to_main_menu(base_url)
        {
            action: "input",
            type: ['dtmf'],
            dtmf: {
                'maxDigits': 1,
                'timeOut': 5
            },
            eventUrl: ["#{base_url}/webhooks/main_menu_repeat"]
        }
    end

    def introduce_musical_performance()
        {
            action: "talk",
            text: "The following is a performance of Those Canaan Days from Joseph and"\
                  "The Technicolor Dreamcoat. A text message with a link to the original You Tube "\
                  "video has been sent to your phone. Enjoy",
            bargeIn: "True"
        }
    end


    def introduce_happy_birthday()
        {
            action: "talk",
            text: "Devin's two-year-old daughter Talia would like to wish you a Happy Birthday!",
            bargeIn: "True"
        }
    end

    def play_musical_performance(base_url)
        {
            action: "stream",
            streamUrl: ["#{base_url}/media/musicalperformance.mp3"],
            level: "-0.25",
            bargeIn: "True"
        }

    end

    def play_happy_birthday(base_url)
        {
            action: "stream",
            streamUrl: ["#{base_url}/media/happybirthday.mp3"],
            level: "1",
            bargeIn: "True"
        }
    end

end
