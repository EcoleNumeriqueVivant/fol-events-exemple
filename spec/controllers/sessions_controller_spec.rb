require 'rails_helper'

describe SessionsController do

  describe "POST 'create'" do
    it "returns http success" do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      post 'create'
      expect(response).to be_success
    end
  end

end
