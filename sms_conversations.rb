class SMSConversations


    def initialize()
        @current_recipients = Array.new
    end

    def add_new_conversation(recipient_number)
        #recipient # is 10-digit string
        @current_recipients << recipient_number
    end

    def find_recipient_number(numbers)
        @current_recipients.each do |recipient|
            if recipient[-4..-1] == numbers
                return recipient.to_s
            end
        end
        false
    end
    
end