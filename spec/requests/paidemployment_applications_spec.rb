require 'rails_helper'

RSpec.describe "PaidemploymentApplications", type: :request do
  describe "GET /paidemployment_applications" do
    it "works! (now write some real specs)" do
      get paidemployment_applications_path
      expect(response).to have_http_status(200)
    end
  end
end
