class InboundVoiceCall

    attr_reader :to_number, :from_number, :uuid, :conversation_uuid

    def initialize(call_to, call_from, call_uuid, call_conversation_uuid)
        @to_number = call_to
        @from_number = call_from
        @uuid = call_uuid
        @conversation_uuid = call_conversation_uuid
    end

    def connect_voice_number(outbound_number)
        [{
            action: 'connect',
            endpoint: [{
                type: 'phone',
                number: outbound_number
                      }]
        }].to_json
    end

end