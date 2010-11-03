require 'spec_helper'

describe Capybara::Session do
  context 'with akephalos driver' do

    before do
      @session = Capybara::Session.new(:akephalos, Application)
    end

    context "slow page load" do
      it "should wait for the page to finish loading" do
        @session.visit('/slow_page')
        @session.current_url.should include('/slow_page')
      end
    end

    context "slow ajax load" do
      it "should wait for ajax to load" do
        @session.visit('/slow_ajax_load')
        @session.click_link('Click me')
        @session.should have_xpath("//p[contains(.,'Loaded!')]")
      end
    end

    context "slow event handlers" do
      it "should wait after typing" do
        @session.visit('/slow_ajax_load')
        @session.fill_in('Type in me', :with => 'text')
        @session.should have_xpath("//p[contains(.,'Loaded!')]")
      end

      it "should wait after a manual trigger" do
        @session.visit('/slow_ajax_load')
        @session.locate(:css, '#ajax_load').trigger('click')
        @session.should have_xpath("//p[contains(.,'Loaded!')]")
      end
    end

  end
end

