module JokerAPI
  module Operations
    module WhoisAccreditation
      
      def wa_email_list()
        response = perform_request('wa-email-list')

        results = []
        response.body.each_line do |line|
          email, domain, expiration = line.split("\t", 3)
          results << {:email => email, :domain => domain,
            :verification_expiration => Time.parse(expiration).utc}
        end
        
        results
      end
      
      def wa_email_details(key)
        response = perform_request('wa-email-details', {'key' => key})
        
        results = []
        response.body.each_line do |line|
          status, email, domain = line.split("\t", 3)
          results << {:status => status, :email => email, :domain => domain}
        end
        
        results
      end
      
      def wa_email_validate(email)
        response = perform_request('wa-email-validate', {'email' => email})
        
        if response.body == "Result: ACK"
          return true
        end
        
        return false
      end
      
      def wa_email_verify(key, answer = 'no')
        raise ArgumentError, "answer must be either yes or no" unless ['yes', 'no'].include?(answer)
        
        response = perform_request('wa-email-verify', {'key' => key, 'answer' => answer})
        
        if response.body == "Result: ACK"
          return true
        end
        
        return false
      end
    end
  end
end
