require 'webrick'
require 'flash'
require 'controller_base'
require 'json'

describe RailsLite::Flash do
  let(:req) { WEBrick::HTTPRequest.new(Logger: nil) }
  let(:res) { WEBrick::HTTPResponse.new(HTTPVersion: '1.0') }
  let(:cook) { WEBrick::Cookie.new('_rails_lite_flash', { xyz: 'abc' }.to_json) }

  it "deserializes json cookie if one exists" do
    req.cookies << cook
    flash = RailsLite::Flash.new(req)
    expect(flash['xyz']).to eq('abc')
  end

  describe "#store_flash" do
    context "without cookies in request" do
      before(:each) do
        flash = RailsLite::Flash.new(req)
        flash['first_key'] = 'first_val'
        flash.store_flash(res)
      end

      it "adds new cookie with '_rails_lite_flash' name to response" do
        cookie = res.cookies.find { |c| c.name == '_rails_lite_flash' }
        expect(cookie).not_to be_nil
      end

      it "stores the cookie in json format" do
        cookie = res.cookies.find { |c| c.name == '_rails_lite_flash' }
        expect(JSON.parse(cookie.value)).to be_instance_of(Hash)
      end
    end

    context "with cookies in request" do
      before(:each) do
        cook = WEBrick::Cookie.new('_rails_lite_flash', { pho: "soup" }.to_json)
        req.cookies << cook
      end

      it "reads the pre-existing cookie data into hash" do
        flash = RailsLite::Flash.new(req)
        expect(flash['pho']).to eq('soup')
      end

      it "saves only new data to the cookie" do
        flash = RailsLite::Flash.new(req)
        flash['machine'] = 'mocha'
        flash.store_flash(res)
        cookie = res.cookies.find { |c| c.name == '_rails_lite_flash' }
        h = JSON.parse(cookie.value)
        expect(h['pho']).to be_nil
        expect(h['machine']).to eq('mocha')
      end
    end
  end

  describe "#now" do
    it "adds the passed data to the hash" do
      flash = RailsLite::Flash.new(req)
      flash.now['foo'] = 'bar'
      expect(flash['foo']).to eq('bar')
    end

    it "does not save the passed data to the cookie" do
      flash = RailsLite::Flash.new(req)
      flash.now['foo'] = 'bar'
      flash['machine'] = 'mocha'
      flash.store_flash(res)
      cookie = res.cookies.find { |c| c.name == '_rails_lite_flash' }
      h = JSON.parse(cookie.value)
      expect(h['foo']).to be_nil
      expect(h['machine']).to eq('mocha')
    end
  end
end

describe RailsLite::ControllerBase do
  before(:all) do
    class CatsController < RailsLite::ControllerBase
    end
  end
  after(:all) { Object.send(:remove_const, "CatsController") }

  let(:req) { WEBrick::HTTPRequest.new(Logger: nil) }
  let(:res) { WEBrick::HTTPResponse.new(HTTPVersion: '1.0') }
  let(:cats_controller) { CatsController.new(req, res) }

  describe "#flash" do
    it "returns a flash instance" do
      expect(cats_controller.flash).to be_a(RailsLite::Flash)
    end

    it "returns the same instance on successive invocations" do
      first_result = cats_controller.flash
      expect(cats_controller.flash).to be(first_result)
    end
  end

  shared_examples_for "storing flash data" do
    it "should store the flash data" do
      cats_controller.flash['test_key'] = 'test_value'
      # expect(cats_controller.flash).to receive(:store_flash)
      cats_controller.send(method, *args)
      cookie = res.cookies.find { |c| c.name == '_rails_lite_flash' }
      h = JSON.parse(cookie.value)
      expect(h['test_key']).to eq('test_value')
    end
  end

  describe "#render_content" do
    let(:method) { :render_content }
    let(:args) { ['test', 'text/plain'] }
    include_examples "storing flash data"
  end

  describe "#redirect_to" do
    let(:method) { :redirect_to }
    let(:args) { ['http://appacademy.io'] }
    include_examples "storing flash data"
  end
end
