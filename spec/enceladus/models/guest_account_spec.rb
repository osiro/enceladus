require 'spec_helper'

describe Enceladus::GuestAccount do

  let(:guest_account_response) { GuestAccountResponse.new }

  before do
    stub_request(:get, "https://api.themoviedb.org/3/authentication/guest_session/new?api_key=token").
      to_return(status: 200, body: guest_account_response.to_json)
  end

  describe "#initialize" do
    subject(:account) { Enceladus::GuestAccount.new }

    it "should set account guest_session_id" do
      expect(account.session_id).to eq guest_account_response.guest_session_id
    end
  end
end