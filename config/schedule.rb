every 1.day, :at => '4:30 am' do
  rake "sitemap:refresh"
end

every 1.day, :at => '3:30 am' do
  rake "youtube:disable_inactive"
end
