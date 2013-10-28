require 'spec_helper'

describe MemorizeController do
  let!(:user) { create(:user) }
  let(:audio_video) { create(:audio_video) }

  before { sign_in user }

  describe "GET 'show'" do
    it 'requires authentication' do
      get :show
      response.should be_success
      response.should render_template(:show)
    end

    it 'loads phrases by audiovideo' do
      scope = double
      scope.should_receive(:by_audio_video).with(audio_video.id.to_s)

      Phrase.should_receive(:by_user).with(user) {scope}

      get :show, audio_video_id: audio_video.id
    end
  end

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

end
