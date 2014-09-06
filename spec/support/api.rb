# encoding: utf-8

module API
  module Helper
    def parse_body str
      str == '' ? {} : JSON.parse(str, {symbolize_names: true})
    end

    def json(content)
      MultiJson.dump(content, pretty: true)
    end

    def decode_json(content)
      MultiJson.load(content, symbolize_keys: true)
    end

    def authorize(user)
      browser.authorize(user.email, "foobar")
    end

    def should_be_json
     expect(browser.last_response.headers["Content-Type"]).to eq("application/json;charset=utf-8")
    end

    def should_200(payload = nil)
      expect(browser.last_response.body).to eq(json(payload)) if payload
      expect(browser.last_response.status).to eq(200)
    end

    def should_201
      expect(browser.last_response.status).to eq(201)
    end

    def should_204
      expect(browser.last_response.body).to eq("")
      expect(browser.last_response.headers["Content-Type"]).to eq(nil)
      expect(browser.last_response.status).to eq(204)
    end

    def should_400(error = nil)
      expect(browser.last_response.body).to  eq(json({error: error || "Bad request"}))
      expect(browser.last_response.status).to eq(400)
    end

    def should_401(payload = {error: "Authorization required"})
      expect(browser.last_response.body).to eq(json(payload)) if payload
      expect(browser.last_response.status).to eq(401)
    end

    def should_403(error = nil)
      expect(browser.last_response.body).to eq(json({error: error || "Forbidden"}))
      expect(browser.last_response.status).to eq(403)
    end

    def should_404
      expect(browser.last_response.body).to eq(json({ message: 'This is not a valid route for our API'}))
      expect(browser.last_response.status).to eq(404)
    end

    def should_422
      expect(browser.last_response.status).to eq(422)
    end

  end
end