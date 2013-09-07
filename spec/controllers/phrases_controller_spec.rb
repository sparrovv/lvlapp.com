require 'spec_helper'

describe PhrasesController do
  let(:user) { build(:user) }
  let(:audio_video) { create(:audio_video) }
  let(:phrase) { build(:phrase, user: user, audio_video: audio_video) }

  it 'requires authenticated user' do
    get :index, :audio_video_id => phrase.audio_video_id, :format => :json
    response.status.should == 401
  end

  context 'when user authenticated' do
    before do
      user.save
      sign_in user
    end

    describe '#index' do
      it 'returns collection by audio_video_id and user in json' do
        phrase.save
        phrase_1 = create(:phrase, audio_video: audio_video)

        get :index, :audio_video_id => phrase.audio_video_id

        body = JSON.parse(response.body)
        expect(body.size).to eq 1
        expect(body.first['id']).to eq phrase.id
      end
    end

    describe '#create' do
      let(:audio_video) { create(:audio_video) }

      context 'when valid args' do
        def dispatch(audio_video)
          post :create, audio_video_id: audio_video.id, phrase: {name: 'foobar'}
        end

        it 'is success' do
          dispatch(audio_video)
          expect(response).to be_success
        end

        it 'assigns phrase to current_user' do
          expect do
            dispatch(audio_video)
          end.to change { user.phrases.count }.by(1)
        end

        it 'returns object in JSON' do
          dispatch(audio_video)
          body = JSON.parse(response.body)

          expect(body["name"]).to eq 'foobar'
        end
      end

      context 'when not valid args' do
        before do
          post :create, audio_video_id: audio_video.id, phrase: {name: ''}
        end

        it { expect(response).to_not be_success }

        it 'returns errors' do
          body = JSON.parse(response.body)
          expect(body['name']).to be_present
        end
      end
    end

    describe '#destroy' do
      it 'destroys phrase' do
        phrase = create(:phrase, user: user)

        expect do
          delete :destroy, :audio_video_id => phrase.audio_video_id, :id => phrase.id
        end.to change { user.phrases.count }.by(-1)
      end

      it 'doesn\'t destroy other user phrase' do
        phrase = create(:phrase, user: user)
        phrase_1 = create(:phrase)

        delete :destroy, :audio_video_id => phrase.audio_video_id, :id => phrase_1.id
        response.status.should == 403
      end
    end
  end
end
