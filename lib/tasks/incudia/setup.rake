namespace :incudia do
  desc "Incudia | Setup production application"
  task setup: :environment do
    setup_db
  end

  def setup_db

    unless ENV['force'] == 'yes'
      puts "This will create the necessary database tables and seed the database."
      puts "You will lose any previous data stored in the database."
      ask_to_continue
      puts ""
    end

    Rake::Task["db:setup"].invoke
    Rake::Task["db:seed_fu"].invoke
  rescue Incudia::TaskAbortedByUserError
    puts "Quitting...".red
    exit 1
  end
end
