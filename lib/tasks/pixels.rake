namespace :pixels do
  desc 'resets users pixels to 0'
  task reset: :environment do
    User.update_all(pixels_today: 0)
  end
end
