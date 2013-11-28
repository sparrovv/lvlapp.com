require 'spec_helper'

feature "Shake Down tests" do
  background do
    @user = create(:user)
    @audio_video = create(:audio_video)
    @audio_video_pending = create(:audio_video, status: AudioVideo::PENDING)
    sign_in(@user)
  end

  scenario "home page" do
    expect(page).to have_link("Browse")
    expect(page).to have_text("Level up your English by listening")
    expect(page).to have_text("Popular")
    expect(page).to have_text("Featured")
    expect(page).to have_text("Recently added")
  end

  scenario "Browse" do
    click_link 'Browse'
    expect(page).to have_link("All")
    expect(page).to have_link(@audio_video.category_name)
    expect(page).to have_link(@audio_video.name)
    expect(page).to_not have_link(@audio_video_pending.name)
  end

  scenario "Audio Video" do
    click_link 'Browse'
    click_link @audio_video.name
    expect(page).to have_text(@audio_video.name)
    expect(page).to have_css('.link-to-original')
    expect(page).to have_text('Stats')
    expect(page).to have_text('Phrasebook')
    expect(page).to have_text(@audio_video.level_name)
  end

  scenario "Game Data" do
    create(:game_datum, audio_video: @audio_video, user: @user)
    av = create(:audio_video)
    create(:game_datum, audio_video: av)

    visit game_data_path

    expect(page).to have_text('Your stats')
    expect(page).to have_text(@audio_video.name)
    expect(page).to_not have_text(av.name)
  end

  scenario "Learn" do
    create(:phrase)
    click_link 'Learn'

    expect(page).to have_text('Learn')
    expect(page).to have_text('due to repeat')
    expect(page).to have_text('all phrases')
  end
end
