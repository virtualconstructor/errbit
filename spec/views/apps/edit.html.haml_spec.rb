require 'spec_helper'

describe "apps/edit.html.haml", :type => :view do
  let(:app) { stub_model(App, name: 'app') }
  before do
    assign :app, app
    allow(controller).to receive(:current_user) { stub_model(User) }
  end

  describe "content_for :action_bar" do
    def action_bar
      view.content_for(:action_bar)
    end

    it "should confirm the 'reset' link" do
      render
      expect(action_bar).to have_selector('a.button[data-confirm="%s"]' % I18n.t('apps.confirm_destroy_all_problems'))
    end

    it "should confirm the 'destroy' link" do
      render
      expect(action_bar).to have_selector('a.button[data-confirm="%s"]' % I18n.t('apps.confirm_delete'))
    end

  end

  context "with unvalid app" do
    before do
      app.errors.add(:base,'You must specify your')
    end

    it 'see the error' do
      render
      expect(rendered).to match(/You must specify your/)
    end
  end

end

