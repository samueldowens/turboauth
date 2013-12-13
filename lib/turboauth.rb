class TurboAuth
  TURBOAUTH_ROOT = File.expand_path('../', File.dirname(__FILE__))

  def self.run
    self.add_gems
    self.add_to_gitignore
    self.add_facebook_yml
    self.add_routes

  end

  def self.add_gems
    File.open('Gemfile', 'a') do |file|
      file.puts "\n#omniauth gems\ngem 'omniauth'\ngem 'omniauth-facebook', '1.4.0'\n"
    end
  end

  def self.add_to_gitignore
    File.open('.gitignore', 'a') do |file|
      file.puts "\n#ignore file with facebook keys\nfacebook.yml\n"
    end
  end

  def self.add_facebook_yml
    File.new('config/facebook.yml')
    File.open('config/facebook.yml', 'a') do |file|
      file.puts "development:\n  app_id: PUT_YOUR_APP_ID_HERE\n  secret: PUT_YOUR_APP_SECRET_HERE\n\ntest:\n  app_id: PUT_YOUR_APP_ID_HERE\n  secret: PUT_YOUR_APP_SECRET_HERE\n\nproduction:\n  app_id: PUT_YOUR_APP_ID_HERE\n  secret: PUT_YOUR_APP_SECRET_HERE"
    end
  end

  def self.add_routes 
  File.open('config/routes.rb') { |source_file|
    contents = source_file.read
    newlines = "root 'test#index'\n\nmatch 'auth/:provider/callback', to: 'sessions#create', via: [:get, :post]\nmatch 'auth/failure', to: redirect('/'), via: [:get, :post]\nmatch 'signout', to: 'sessions#destroy', as: 'signout', via: [:get, :post]\n\nend\n"
    contents.gsub!(/[e][n][d]/, newlines)
    File.open('config/routes.rb', "w+") { |f| f.write(contents) }
  }
  end


end