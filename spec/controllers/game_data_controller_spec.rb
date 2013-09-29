require 'spec_helper'

describe GameDataController do
  let(:user) { build(:user) }
  let(:audio_video) { create(:audio_video) }
  let(:game_datum) { build(:game_datum, user: user, audio_video: audio_video) }

  it 'requires authenticated user' do
    get :index, :audio_video_id => game_datum.audio_video_id, :format => :json
    response.status.should == 401
  end

  context 'when user authenticated' do
    before do
      user.save
      sign_in user
    end

    describe '#index' do

      it 'assigns @game_data for user' do
        game_datum.save
        get :index
        assigns(:game_data).should include game_datum
      end
    end

    describe '#create' do
      context 'when valid args' do

        def dispatch(game_datum)
          post :create, audio_video_id: audio_video.id, game_datum: (attributes_for :game_datum)
        end

        it 'is success' do
          dispatch(game_datum)
          expect(response).to be_success
        end

        it 'assigns current_user to game_datum' do
          expect do
            dispatch(game_datum)
          end.to change { user.game_data.count }.by(1)
        end

        it 'returns object in JSON' do
          dispatch(game_datum)
          body = JSON.parse(response.body)

          expect(body["blanks"]).to eq 1
        end
      end

      context 'when invalid args' do
        before do
          post :create, audio_video_id: audio_video.id, game_datum: {guessed: 1}
        end

        it { expect(response).to_not be_success }

        it 'returns errors' do
          body = JSON.parse(response.body)
          expect(body['blanks']).to be_present
        end

      end
    end
  end
end
