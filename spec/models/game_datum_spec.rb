require 'spec_helper'

describe GameDatum do
  let(:game_datum) { build(:game_datum) }

  it 'is valid' do
    expect(game_datum).to be_valid
  end

  context 'validation' do
    it 'validates presence of user' do
      game_datum.user = nil
      expect(game_datum).to_not be_valid
      game_datum.user = build(:user)
      expect(game_datum).to be_valid
    end

    it 'validates presence of audio_video' do
      game_datum.audio_video = nil
      expect(game_datum).to_not be_valid
      game_datum.audio_video = build(:audio_video)
      expect(game_datum).to be_valid
    end

    it 'validates presence ofblanks' do
      game_datum.blanks = nil
      expect(game_datum).to_not be_valid
      game_datum.blanks = 1
      expect(game_datum).to be_valid
    end

    it 'validates presence of guessed' do
      game_datum.guessed = nil
      expect(game_datum).to_not be_valid
      game_datum.guessed = 1
      expect(game_datum).to be_valid
    end

    it 'validates presence of skipped' do
      game_datum.skipped = nil
      expect(game_datum).to_not be_valid
      game_datum.skipped = 1
      expect(game_datum).to be_valid
    end

    it 'validates presence of mistakes' do
      game_datum.mistakes = nil
      expect(game_datum).to_not be_valid
      game_datum.mistakes = 1
      expect(game_datum).to be_valid
    end

    it 'validates presence of time' do
      game_datum.time = nil
      expect(game_datum).to_not be_valid
      game_datum.time = 1
      expect(game_datum).to be_valid
    end

    it 'validates presence of level' do
      game_datum.level = nil
      expect(game_datum).to_not be_valid
      game_datum.level = 'normal'
      expect(game_datum).to be_valid
    end
  end
end
