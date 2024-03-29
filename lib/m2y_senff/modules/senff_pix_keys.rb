module M2ySenff

  class SenffPixKeys < SenffModule

    def initialize(client_id, client_secret, url, scope, auth_url)
      @auth = SenffAuth.new(client_id, client_secret, url)
      @client_id = client_id
      @client_secret = client_secret
      @url = url
      @auth = SenffAuth.new(client_id, client_secret, auth_url + PIX_AUTH_PATH, scope)
    end

    def refreshToken
      if SenffHelper.shouldRefreshToken?(@client_secret)
        @auth.generateToken
      end
    end


    def list_keys(body)
      refreshToken
      url = @url + PIX_LIST_KEYS_PATH
      headers = json_headers
      headers["Authorization"] = "Bearer #{SenffHelper.get_token(@client_secret)}"
      req = HTTParty.post(url, body: body.to_json, :verify => false, headers: headers)
      begin
        SenffModel.new(req.parsed_response)
      rescue
        nil
      end
    end

    def generate_key(body)
      refreshToken
      url = @url + PIX_ADD_KEY_PATH
      headers = json_headers
      headers["Authorization"] = "Bearer #{SenffHelper.get_token(@client_secret)}"
      headers["Chave-Idempotencia"] = SecureRandom.uuid
      req = HTTParty.post(url, body: body.to_json, :verify => false, headers: headers)
      begin
        SenffModel.new(req.parsed_response)
      rescue
        nil
      end
    end

    def remove_key(id, body)
      refreshToken
      url = @url + PIX_REMOVE_KEY_PATH + "#{id}"
      puts url
      headers = json_headers
      headers["Authorization"] = "Bearer #{SenffHelper.get_token(@client_secret)}"
      headers["Chave-Idempotencia"] = SecureRandom.uuid
      req = HTTParty.post(url, body: body.to_json, :verify => false, headers: headers)
      begin
        SenffModel.new(req.parsed_response)
      rescue
        nil
      end
    end

  end

end
