server 'hybox-dev.stanford.edu',
       user: fetch(:user),
       roles: %w{app db web}

Capistrano::OneTimeKey.generate_one_time_key!
set :rails_env, 'development'
