# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Rails.application.load_tasks

Rake::TestTask.new do |t|
 t.libs << 'test'
 t.libs << '/usr/lib/ruby/2.4.0/x86_64-linux' # this line added
end
