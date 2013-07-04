role :web, ""
role :app, ""
role :db,  "", :primary => true

set :rails_env, "production"
set :branch, "master"

set :deploy_to, "#{base_directory}/#{application}_#{stage}"

set :keep_releases, 30

set :current_path, File.join(deploy_to, current_dir) #fix for capistrano-unicorn

after 'deploy:update_code', 'deploy:migrate'