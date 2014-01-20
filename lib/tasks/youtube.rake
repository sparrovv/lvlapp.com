namespace :youtube do
  task :disable_inactive => :environment do
    result = AudioVideoCheck.disable_inactive
    if result.first != result.last
      puts "Some videos were disabled: #{result}"
    end
  end
end
