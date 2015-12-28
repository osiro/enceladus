require 'spec_helper'

describe Enceladus::Requester do
  [:get, :post].each do |request_type|
    describe "##{request_type}" do
      subject { Enceladus::Requester.public_send(request_type, "/movie") }

      describe "success requests" do
        before do
          stub_request(request_type, /api.themoviedb.org\/movie/).to_return(status: 200, body: { success: true }.to_json)
        end

        it "should return the parsed response body" do
          expect(subject.success).to be_truthy
        end
      end

      describe "response parse error" do
        describe "malformed response" do
          before do
            stub_request(request_type, /api.themoviedb.org\/movie/).to_return(status: 200, body: "")
          end

          it "should raise error Enceladus::Exception::JsonParseError" do
            expect{ subject }.to raise_error Enceladus::Exception::JsonParseError
          end
        end

        describe "SSLCertificateNotVerified" do
          before do
            allow(RestClient).to receive(request_type) { raise RestClient::SSLCertificateNotVerified, 'test' }
          end

          it "should re-raise the exception RestClient::SSLCertificateNotVerified" do
            expect{ subject }.to raise_error(RestClient::SSLCertificateNotVerified)
          end
        end
      end
    end
  end
end
