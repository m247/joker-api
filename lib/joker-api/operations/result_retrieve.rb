module JokerAPI
  module Operations
    module ResultRetrieve
      # @param [String,Response] proc_id The String Proc-ID from the request to retrieve
      def result_retrieve(proc_id)
        proc_id = proc_id.proc_id if proc_id.kind_of?(Response)

        response = perform_request('result-retrieve', {'Proc-ID' => proc_id})
        results, body = response.body.split("\n\n", 2)

        results.split("\n").inject({'body' => body}) do |hash, result|
          hash.store(*result.split(": ",2))
          hash
        end
      end
    end
  end
end
