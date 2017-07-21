# This file is used by Rack-based servers to start the application.

require_relative 'config/environment'


require_relative 'app/middleware/chat_backend'
use ChatDemo::ChatBackend

run Rails.application
