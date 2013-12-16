class TurboAuth
  TURBOAUTH_ROOT = File.expand_path('../', File.dirname(__FILE__))
  #abstract paths into variables. Have each method take path as an argument. Pass path varibles in when called. Test with simpler paths.
  def self.facebook
    self.add_gems
    self.add_jquery_turbolinks_to_application_js
    self.add_to_gitignore
    self.add_facebook_yml
    self.add_routes
    self.add_omniauth_rb
    self.add_facebook_rb
    self.add_coffee_script
    self.add_test_controller
    self.add_to_app_controller
    self.add_sessions_controller
    self.edit_application_layout
    self.create_index_view
    self.add_user_migration
    self.migrate
    self.add_to_user_model
    self.bundle
  end

  def self.add_gems
    File.open('Gemfile', 'a') do |file|
      file.puts "\n#omniauth gems\ngem 'omniauth'\ngem 'omniauth-facebook', '1.4.0'\n\ngem 'jquery-turbolinks'\n"
    end
  end

  def self.add_jquery_turbolinks_to_application_js
    File.open('app/assets/javascripts/application.js', 'a+') { |source_file|
      contents = source_file.read
      newlines = "require turbolinks\n//= require jquery.turbolinks\n"
      contents.gsub!(/[r][e][q][u][i][r][e][ ][t][u][r][b][o][l][i][n][k][s]/, newlines)
      File.open('app/assets/javascripts/application.js', "w+") { |f| f.write(contents) }
    }
  end

  def self.add_to_gitignore
    File.open('.gitignore', 'a') do |file|
      file.puts "\n#ignore file with facebook keys\nfacebook.yml\n"
    end
  end

  def self.add_facebook_yml
    File.new('config/facebook.yml', 'w')
    File.open('config/facebook.yml', 'a') do |file|
      file.puts "development:\n  app_id: PUT_YOUR_APP_ID_HERE\n  secret: PUT_YOUR_APP_SECRET_HERE\n\ntest:\n  app_id: PUT_YOUR_APP_ID_HERE\n  secret: PUT_YOUR_APP_SECRET_HERE\n\nproduction:\n  app_id: PUT_YOUR_APP_ID_HERE\n  secret: PUT_YOUR_APP_SECRET_HERE"
    end
  end

  def self.add_routes 
    File.open('config/routes.rb', 'a+') { |source_file|
      contents = source_file.read
      newlines = "Application.routes.draw do\nroot 'test#index'\n\nmatch 'auth/:provider/callback', to: 'sessions#create', via: [:get, :post]\nmatch 'auth/failure', to: redirect('/'), via: [:get, :post]\nmatch 'signout', to: 'sessions#destroy', as: 'signout', via: [:get, :post]\n"
      contents.gsub!(/[A][p][p][l][i][c][a][t][i][o][n][.][r][o][u][t][e][s][.][d][r][a][w][ ][d][o]/, newlines)
      File.open('config/routes.rb', "w+") { |f| f.write(contents) }
    }
  end

  def self.add_facebook_rb
    File.new('config/initializers/facebook.rb', 'w')
    File.open('config/initializers/facebook.rb', 'a') do |file|
      file.puts "FACEBOOK_CONFIG = YAML.load_file(\"\#{::Rails.root}/config/facebook.yml\")[::Rails.env]\n"
    end
  end

  def self.add_omniauth_rb
    File.new('config/initializers/omniauth.rb', 'w')
    File.open('config/initializers/omniauth.rb', 'a') do |file|
      file.puts "OmniAuth.config.logger = Rails.logger\n\nRails.application.config.middleware.use OmniAuth::Builder do\n  provider:facebook, FACEBOOK_CONFIG['app_id'], FACEBOOK_CONFIG['secret']\nend\n"
    end
  end

  def self.add_coffee_script
    File.new('app/assets/javascripts/facebook.js.coffee.erb', 'w')
    File.open('app/assets/javascripts/facebook.js.coffee.erb', 'a') do |file|
      file.puts "jQuery ->\n  $('body').prepend('<div id=\"fb-root\"></div>')\n\n  $.ajax\n    url: '\#{window.location.protocol}//connect.facebook.net/en_US/all.js'\n    dataType: 'script'\n    cache: true\n\n  window.fbAsyncInit = ->\n    FB.init(appId: <%= FACEBOOK_CONFIG['app_id'] %>, cookie:true)\n\n    $('#sign_in').click (e) ->\n     e.preventDefault()\n     FB.login (response) ->\n      window.location = '/auth/facebook/callback' if response.authResponse\n\n    $('#sign_out').click (e) ->\n      FB.getLoginStatus (response) ->\n        FB.logout() if response.authResponse \n      true"
    end
  end

  def self.add_test_controller
    File.new('app/controllers/test_controller.rb', 'w')
    File.open('app/controllers/test_controller.rb', 'a') do |file|
      file.puts "class TestController < ApplicationController\n\n  def index\n  end\n\nend"
    end
  end

  def self.add_to_app_controller
    File.open('app/controllers/application_controller.rb', 'a+') { |source_file|
      contents = source_file.read
      newlines = "  private\n  def current_user\n    @current_user ||= User.find(session[:user_id]) if session[:user_id]\n  end\n  helper_method :current_user\n\nend"
      contents.gsub!(/[e][n][d]/, newlines)
      File.open('app/controllers/application_controller.rb', "w+") { |f| f.write(contents) }
    }
  end

  def self.add_sessions_controller
    File.new('app/controllers/sessions_controller.rb', 'w')
    File.open('app/controllers/sessions_controller.rb', 'a') do |file|
      file.puts "class SessionsController < ApplicationController\n\n  def create\n    user = User.from_omniauth(env['omniauth.auth'])\n    session[:user_id] = user.id\n    redirect_to root_url\n  end\n\n  def destroy\n    session[:user_id] = nil\n    redirect_to root_url\n  end\n\nend"
    end
  end

  def self.add_to_user_model
    File.open('app/models/user.rb', 'a+') { |source_file|
      contents = source_file.read
      newlines = "\n  def self.from_omniauth(auth)\n    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|\n      user.provider = auth.provider\n      user.uid = auth.uid\n      user.name = auth.info.name\n      user.oauth_token = auth.credentials.oauth_token\n      user.oauth_expires_at = Time.at(auth.credentials.expires_at)\n      user.save!\n    end\n  end\n\nend"
      contents.gsub!(/[e][n][d]/, newlines)
      File.open('app/models/user.rb', "w+") { |f| f.write(contents) }
    }
  end

  def self.edit_application_layout
    File.open('app/views/layouts/application.html.erb', 'a+') { |source_file|
      contents = source_file.read
      newlines = "</title>\n\n  <div id='user-widget'>\n    <% if current_user %>\n      Welcome <strong> <%= current_user.name %></strong>!\n      <%= link_to 'Sign Out', signout_path, id: 'sign_out' %>\n    <% else %>\n      <%= link_to 'Sign in with Facebook', '/auth/facebook', id: 'sign_in' %>\n    <% end %>\n  </div>\n"
      contents.gsub!(/[<][\/][t][i][t][l][e][>]/, newlines)
      File.open('app/views/layouts/application.html.erb', "w+") { |f| f.write(contents) }
    }
  end

  def self.create_index_view
    Dir.mkdir('app/views/test')
    File.open('app/views/test/index.html.erb', 'a')
  end

  def self.add_user_migration
    system ( "rails g model user provider uid name oauth_token oauth_expires_at:datetime" )
  end

  def self.migrate
    system ( "bundle exec rake db:migrate" )
  end

  def self.bundle
    system ( "bundle" )
  end

end