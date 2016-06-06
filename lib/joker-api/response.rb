module JokerAPI
  class Response
    AUTHORISATION_ERROR_CODE = -401

    class Error
      attr_reader :code, :message
      def initialize(code, message)
        @code = code; @message = message
      end
    end

    attr_reader :headers, :body

    def initialize(response)
      @httparty_response = response
      headers, body = response.body.split("\n\n", 2)
      parse_headers(headers)
      parse_body(body)

      raise AuthorisationError if status_code == AUTHORISATION_ERROR_CODE
    end

    def request
      @httparty_response.request
    end
    def response
      @httparty_response.response
    end

    def success?
      status_code == 0
    end

    def error?
      !success?
    end

    def error
      return nil if success?
      @error ||= Error.new(status_code, status_text)
    end

    def account_balance
      @account_balance ||= headers['Account-Balance'].to_f
    end
    def proc_id
      @proc_id ||= headers['Proc-ID']
    end
    def status_code
      @status_code ||= headers['Status-Code'].to_i
    end
    def status_text
      @status_text ||= headers['Status-Text'] || headers['Error']
    end
    def tracking_id
      @tracking_id ||= headers['Tracking-Id']
    end
    def version
      @version ||= headers['Version']
    end
    def auth_sid
      @auth_sid ||= headers['Auth-Sid']
    end

    private
      def parse_headers(headers_str)
        @headers = headers_str.split("\n").inject({}) do |hash, header|
          key, value = header.split(": ",2)
          key = key.downcase.capitalize.gsub(/\-([a-z])/i) { |m| m[0] + m[1].upcase }

          if hash.has_key?(key)
            hash[key] = Array(hash[key])
            hash[key] << value
          else
            hash[key] = value
          end

          hash
        end
      end
      def parse_body(body_str)
        @body = body_str
      end
  end
end
