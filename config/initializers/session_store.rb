# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_mind_is_a_metaphor_session',
  :secret      => '3c7689f0f6c825a474889c9306cf524a0c91b9560f7778be060ab45208374b776310e0be41088407cb0b1483e2052df5750d50d8da0400bb1f4ceb047f6df118'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
