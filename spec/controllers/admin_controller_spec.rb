require 'rails_helper'

describe AdminController do
  describe "GET 'index'" do
    context 'sign_in' do
      before do
        sign_in Fabricate(:admin)
      end

      it "returns http success" do
        get :index
        expect(response).to be_success
      end
    end

    context 'not sign_in' do
      it "returns http redirect" do
        get :index
        expect(response).to be_redirect
      end
    end
  end

end
