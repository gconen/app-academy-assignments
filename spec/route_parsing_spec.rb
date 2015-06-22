require 'router'
require 'webrick'

describe "RailsLite::Route" do
  let(:req) { WEBrick::HTTPRequest.new(Logger: nil) }
  context "when given a simple string as an argument" do
    it "matches the appropriate path" do
      route = RailsLite::Route.new("users", :get, "x", :x)
      allow(req).to receive(:path) { "/users" }
      allow(req).to receive(:request_method) { :get }
      expect(route.matches?(req)).to be_truthy
    end

    it "does not match a partial path" do
      route = RailsLite::Route.new("users", :get, "x", :x)
      allow(req).to receive(:path) { "/user" }
      allow(req).to receive(:request_method) { :get }
      expect(route.matches?(req)).to be_falsey
    end

    it "does not match a longer path" do
      route = RailsLite::Route.new("users", :get, "x", :x)
      allow(req).to receive(:path) { "/users/5" }
      allow(req).to receive(:request_method) { :get }
      expect(route.matches?(req)).to be_falsey
    end

    it "does not match an incorrect path" do
      route = RailsLite::Route.new("users", :get, "x", :x)
      allow(req).to receive(:path) { "/uzers" }
      allow(req).to receive(:request_method) { :get }
      expect(route.matches?(req)).to be_falsey
    end
  end

  context "when given a string with an ending capture group" do
    it "matches an appropriate path" do
      route = RailsLite::Route.new("users/:id", :get, "x", :x)
      allow(req).to receive(:path) { "/users/43" }
      allow(req).to receive(:request_method) { :get }
      expect(route.matches?(req)).to be_truthy
    end

    it "does not match a longer path" do
      route = RailsLite::Route.new("users/:id", :get, "x", :x)
      allow(req).to receive(:path) { "/users/43/edit" }
      allow(req).to receive(:request_method) { :get }
      expect(route.matches?(req)).to be_falsey
    end

    it "does not match the root" do
      route = RailsLite::Route.new("users/:id", :get, "x", :x)
      allow(req).to receive(:path) { "/users" }
      allow(req).to receive(:request_method) { :get }
      expect(route.matches?(req)).to be_falsey
    end

    it "correctly identifies the route parameters" do
      #thing to do ...
    end
  end

  context "when given a string with an capture group within it" do
    it "matches an appropriate path" do
      route = RailsLite::Route.new("users/:id/edit", :get, "x", :x)
      allow(req).to receive(:path) { "/users/43/edit" }
      allow(req).to receive(:request_method) { :get }
      expect(route.matches?(req)).to be_truthy
    end

    it "does not match with the wrong ending" do
      route = RailsLite::Route.new("users/:id/edit", :get, "x", :x)
      allow(req).to receive(:path) { "/users/43/exit" }
      allow(req).to receive(:request_method) { :get }
      expect(route.matches?(req)).to be_falsey
    end

    it "does not match without the ending" do
      route = RailsLite::Route.new("users/:id/edit", :get, "x", :x)
      allow(req).to receive(:path) { "/users/43" }
      allow(req).to receive(:request_method) { :get }
      expect(route.matches?(req)).to be_falsey
    end
  end
end
