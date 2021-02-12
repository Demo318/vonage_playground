class InboundVoiceCall

    def initialize(call_to, call_from, call_uuid, call_conversation_uuid)
        @to_number = call_to
        @from_number = call_from
        @uuid = call_uuid
        @conversation_uuid = call_conversation_uuid
    end

end