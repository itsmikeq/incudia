Rake::Task["spec"].clear if Rake::Task.task_defined?('spec')

namespace :spec do
  desc 'Incudia | Run request specs'
  task :api do
    cmds = [
      %W(rake incudia:setup),
      %W(rspec spec --tag @api)
    ]
    run_commands(cmds)
  end

  desc 'Incudia | Run feature specs'
  task :feature do
    cmds = [
      %W(rake incudia:setup),
      %W(rspec spec --tag @feature)
    ]
    run_commands(cmds)
  end

  desc 'Incudia | Run other specs'
  task :other do
    cmds = [
      %W(rake incudia:setup),
      %W(rspec spec --tag ~@api --tag ~@feature)
    ]
    run_commands(cmds)
  end
end

desc "Incudia | Run specs"
task :spec do
  cmds = [
    %W(rake incudia:setup),
    %W(rspec spec),
  ]
  run_commands(cmds)
end

def run_commands(cmds)
  cmds.each do |cmd|
    system({'RAILS_ENV' => 'test', 'force' => 'yes'}, *cmd) or raise("#{cmd} failed!")
  end
end
