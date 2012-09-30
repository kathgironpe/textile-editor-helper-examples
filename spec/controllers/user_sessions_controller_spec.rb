require 'spec_helper'

describe UserSessionsController do

  let(:user) { FactoryGirl.create(:user) }

  describe "#new" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end
  end


end
