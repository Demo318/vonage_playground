module SMSActions

    def send_sms_message(authenticated_vonage_client, from_number, to_number, message)
        authenticated_vonage_client.sms.send(
            from: from_number,
            to: to_number,
            text: message
        )
    end

end