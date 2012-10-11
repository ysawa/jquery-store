gem 'guard-coffeescript'
gem 'rb-fsevent', require: false if RUBY_PLATFORM =~ /darwin/i # mac os x

# Notifiers
case RUBY_PLATFORM
when /linux/i
  gem 'libnotify'
when /darwin/i
  gem 'growl'
when /mswin(?!ce)|mingw|cygwin|bccwin/i
  gem 'rb-notifu'
end
