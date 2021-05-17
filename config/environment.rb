# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

ActionMailer::Base.smtp_settings = {
  :user_name => 'nicolas.heckman@gmail.com',
  :password => ENV['SENDINBLUE_KEY'],
  :domain => 'monsite.fr',
  :address => 'smtp-relay.sendinblue.com',
  :port => 587,
  :authentication => :plain,
  :enable_starttls_auto => true
}