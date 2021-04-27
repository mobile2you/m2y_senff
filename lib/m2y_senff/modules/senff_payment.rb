module M2ySenff

  class SenffPayment < SenffModule

    def initialize(access_key, secret_key, url)
      startModule(access_key, secret_key, url)
    end

    def validate(ean)
      url = @url + VALIDATE_PATH + ean
      puts url
      req = HTTParty.get(url, :verify => false)
      begin
        SenffModel.new(req.parsed_response)
      rescue
        nil
      end
    end

    def receipts(account, from, to)
      url = @url + PAYMENTS_RECEIPTS + "?conta=#{account}&dataInicial=#{from}&dataFinal=#{to}"
      puts url
      req = HTTParty.get(url, :verify => false)
      begin
        SenffModel.new(req.parsed_response)
      rescue
        nil
      end
    end

    def find_receipt(account, auth)
      url = @url + PAYMENTS_RECEIPTS + "?conta=#{account}&autorizacao=#{auth}"
      puts url
      req = HTTParty.get(url, :verify => false)
      begin
        SenffModel.new(req.parsed_response)
      rescue
        nil
      end
    end

    def pay(body)
      url = @url + PAY
      req = HTTParty.post(url, body: body.to_json, :verify => false, headers: json_headers)
      begin
        SenffModel.new(req.parsed_response)
      rescue
        nil
      end
    end


  end

end
