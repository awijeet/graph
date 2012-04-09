# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_graph_session',
  :secret      => '2fe5be7fe353d8c436ad8d31f5c47831db3e4d6b8dc8b8f02913540fc9aeaefc0b1464115b3c2e9d080feb97cf47a9d72fe24fd53e531980624866352cd558bb'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
