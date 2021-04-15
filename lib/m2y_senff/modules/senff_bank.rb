module M2ySenff

  class SenffBank < SenffModule

    def initialize(access_key, secret_key, url)
      startModule(access_key, secret_key, url)
    end

    def getBanks
      response = @request.get(@url + BANKS_PATH)
      resp = SenffModel.new(response)
      array = []
      if !resp.obterBancos.nil?
        resp.obterBancos.each do |bank|
          array << {id: bank["nrBanco"], code: bank["nrBanco"], name: bank["nmBanco"]}
        end
      end
      array
    end

  end

end
