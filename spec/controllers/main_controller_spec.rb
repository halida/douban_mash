require 'spec_helper'

describe MainController do

  describe "GET 'show'" do
    it "returns http success" do
      get 'show'
      response.should be_success
    end
  end

  describe "GET 'gender'" do
    it "returns http success" do
      get 'gender'
      response.should be_success
    end
  end

  describe "GET 'select_gender'" do
    it "returns http success" do
      get 'select_gender'
      response.should be_success
    end
  end

  describe "GET 'match'" do
    it "returns http success" do
      get 'match'
      response.should be_success
    end
  end

  describe "GET 'result'" do
    it "returns http success" do
      get 'result'
      response.should be_success
    end
  end

  describe "GET 'poker'" do
    it "returns http success" do
      get 'poker'
      response.should be_success
    end
  end

end
