require '.\actions_sms.rb'
require '.\actions_voice.rb'
require '.\vonage_creds.rb'
require 'vonage'

class VonageClient 
    include SMSActions
    include VoiceActions
    include VonageCredentials

    attr_accessor :vonage

    def initialize()
        @vonage = Vonage::Client.new(
                                      application_id: ID,
                                      private_key: KEY,
                                      api_key: APIKey,
                                      api_secret: APISecret
                                    )
    end


end