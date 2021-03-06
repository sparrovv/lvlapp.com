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

  scenario "Audio Video normal browser" do
    click_link 'Browse'
    click_link @audio_video.name
    expect(page).to have_text(@audio_video.name)
    expect(page).to have_css('.link-to-original')
    expect(page).to have_text('Stats')
    expect(page).to have_text('Phrasebook')
    expect(page).to have_text(@audio_video.level_name)
    expect(page).to_not have_css('.alert')
    expect(page).to_not have_text('Warning - not supported device.')
  end

  scenario "Audio Video on mobile" do
    page.driver.browser.header('User-Agent', 'Mozilla/5.0 (Linux; U; Android 4.0.3; ko-kr; LG-L160L Build/IML74K) AppleWebkit/534.30 (KHTML, like Gecko) Version/4.0 Mobile Safari/534.30')
    click_link 'Browse'
    click_link @audio_video.name
    expect(page).to have_css('.alert')
    expect(page).to have_text('Warning - not supported device.')
  end

  scenario "Game Data" do
    create(:game_datum, audio_video: @audio_video, user: @user)
    av = create(:audio_video)
    create(:game_datum, audio_video: av)

    visit game_data_path

    expect(page).to have_text('Stats')
    expect(page).to have_text(@audio_video.name)
    expect(page).to_not have_text(av.name)
  end

  scenario "it show notice when no phrases in the learn section" do
    click_link 'Learn'
    expect(page).to have_text(/Before you start repetition/)
  end

  scenario "it shows words to repeat" do
    create(:phrase, user: @user)
    click_link 'Learn'
    expect(page).to have_text('Learn')
    expect(page).to have_text('due to repeat')
    expect(page).to have_text('all phrases')
    expect(page).to_not have_text(/Before you start repetition/)
  end

  scenario "it shows total points in the navbar" do
    create(:game_datum, user: @user, total_points: 101)
    click_link 'Browse'
    expect(page).to have_css('.points', text: '101')
  end
end
