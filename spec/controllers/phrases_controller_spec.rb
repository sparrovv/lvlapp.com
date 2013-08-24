require 'spec_helper'

describe PhrasesController do
  describe '#index' do
    it 'returns collection by audio_video_id in json' do
      phrase = create(:phrase)

      get :index, :audio_video_id => phrase.audio_video_id

      body = JSON.parse(response.body)
      expect(body.size).to eq 1
      expect(body.first['id']).to eq phrase.id
    end
  end

  describe '#create' do
    context 'when valid args' do
      before do
        post :create, :phrase=>{name: 'foobar', audio_video_id: 1}
      end

      it { expect(response).to be_success }

      it 'returns object in JSON' do
        body = JSON.parse(response.body)

        expect(body["name"]).to eq 'foobar'
      end
    end

    context 'when not valid args' do
      before do
        post :create, :phrase=>{name: '', audio_video_id: 1}
      end

      it { expect(response).to_not be_success }

      it 'returns errors' do
        body = JSON.parse(response.body)
        expect(body['name']).to be_present
      end
    end
  end
end
