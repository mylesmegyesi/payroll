desc 'Starts the server'
task :server do
  sh 'cd lib/rails; bundle exec unicorn_rails -I ..'
end

desc 'Runs all tests'
task :spec => ['spec:core', 'spec:data_store', 'spec:rails']

namespace :spec do
    task :core do
      puts
      puts 'Core Suite:'
      sh 'bundle exec rspec spec/core'
    end

    task :data_store do
      puts
      puts 'Data Store Suite:'
      sh 'bundle exec rspec spec/data_store'
    end

    task :rails do
      puts
      puts 'Rails Suite:'
      sh 'bundle exec rspec spec/rails'
    end
end
