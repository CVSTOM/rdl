if Rails.env.development? || Rails.env.test?
  require 'rdl/boot'
  require 'types/core'

  require_relative "../types/rails/_helpers.rb" # load type aliases first
  # Temporarily disable activerecord and other rails helpers which conflict with papertrail's
  # usage of stabby lambdas
  # Dir[File.dirname(__FILE__) + "/../types/rails/**/*.rb"].each { |f| require f }
elsif Rails.env.production? || Rails.env == "staging"
  require 'rdl_disable'
  class ActionController::Base
    def self.params_type(typs); end
  end
else
  raise RuntimeError, "Don't know what to do in Rails environment #{Rails.env}"
end
