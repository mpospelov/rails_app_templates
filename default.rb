
# GEMS SECTION
gem_group :development, :test do
  gem "rspec-rails"
end

gem 'pg'
# END GEMS SECTION


after_bundle do
  generate "rspec:install"
  git :init
  git add: "."
  git commit: %Q{ -m 'Initial commit' }
end

file "spec/support/factory_girl.rb", <<-CODE
  RSpec.configure do |config|
    config.include FactoryGirl::Syntax::Methods
    config.before(:suite) do
      begin
        DatabaseCleaner.start
        # FactoryGirl.lint
      ensure
        DatabaseCleaner.clean
      end
    end

    config.before(:each) do
      DatabaseCleaner.start
    end

    config.after(:each) do
      DatabaseCleaner.clean
    end
  end
CODE
