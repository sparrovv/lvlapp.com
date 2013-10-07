require 'spec_helper'

describe ViewCounter do
  let(:view_counter) { described_class.new }

  describe '#increment' do
    let(:audio_video) { create(:audio_video) }
    let(:storage) { {} }

    subject { view_counter.increment(audio_video, storage) }

    context "when called for the first time" do
      it "increments the views_count" do
        expect { subject }.to change(audio_video, :views_count).by(1)
      end
    end

    context "when called for the second time" do
      before do
        subject
      end

      it "doesn't increment the views_count" do
        expect { subject }.not_to change(audio_video, :views_count)
      end
    end
  end
end
