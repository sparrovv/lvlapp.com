require 'spec_helper'

describe AudioVideosController do
  let(:audio_video) { create(:audio_video) }
  before do
    audio_video
  end

  describe '#index' do
    it 'renders and everyting is working' do
      get :index

      assigns(:category).should be_nil
      assigns(:category_id).should be_nil
      assigns(:audio_videos).should be_present

      should render_template :index
      response.should be_success
    end

    it 'load_category' do
      category = audio_video.category
      get :index, category_id: category.id

      assigns(:category).should == category
      assigns(:category_id).should == category.id
      assigns(:audio_videos).should be_present

      response.should be_success
    end
  end

  describe '#show' do
    let(:view_counter) { double('view_counter', :increment => nil) }

    before do
      allow(controller).to receive(:view_counter) { view_counter }
    end

    it 'renders and everyting is working' do
      get :show, id: audio_video.id

      assigns(:audio_video).should == audio_video

      should render_template :show
      response.should be_success
    end

    it 'should be counted as a visit' do
      get :show, id: audio_video.id

      expect(view_counter).to have_received(:increment).
        with(audio_video, cookies)
    end
  end
end
