require 'rails_helper'

RSpec.shared_examples_for AdminController do |args|
  let(:today) { Time.zone.parse('2017-10-03 19:19:41') }

  describe "#set_cour" do
    before do
      Timecop.freeze today
    end

    after do
      Timecop.return
    end

    it "assigns current cour" do
      get action, params: params
      expect(assigns(:cour)).to eq (Time.zone.parse('2017-09-21') ... Time.zone.parse('2017-10-21'))
    end

    it "assigns cour by params" do
      get action, params: params.merge(year: '2016', month: '3')
      expect(assigns(:cour)).to eq (Time.zone.parse('2016-03-21') ... Time.zone.parse('2016-04-21'))
    end
  end
end


RSpec.describe Admin::Records::PrintablesController, type: :controller do
  describe "GET #index" do
    let(:action) { :index }
    let(:params) { {} }
    it_behaves_like AdminController
  end
end

RSpec.describe Admin::UsersController, type: :controller do
  describe "GET #show" do
    let(:action) { :show }
    let(:params) { { id: user.id } }
    let(:user) { FactoryBot.create(:user) }
    it_behaves_like AdminController
  end
end
