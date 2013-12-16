#TurboAuth for Rails 4.0

## What is this?
I got tired of having to set up all the configuration for authenticating users every time I wanted to make a small app or try something new. So I made a gem that runs after creating a new rails app that automatically sets up facebook authentication so that you can get right to the coding you wanted to do when you started your app.

If you like this app, or have any feedback post here or get in touch on Twitter @samueldowens.

##Installation

```bash
$gem install turboauth
```

##Usage
<strong>Type 'rails new APPNAME' into the terminal.</strong><br>
<img src="/images/rails_new.png" alt="Type Rails New YOURAPPNAME into the terminal" title="rails new" /><br>
<br><br>
<strong>Type 'cd APPNAME' into the terminal.</strong><br>
<img src="/images/cd_appname.png" alt="Type cd YOURAPPNAME into the terminal" title="cd appname" /><br>
<br><br>
<strong>Type 'gem install turboauth' into the terminal.</strong><br>
<img src="/images/gem_install_turboauth.png" alt="Type gem install turboauth into the terminal" title="gem install turboauth" /><br>
<br><br>
<strong>Type 'turboauth' into the terminal to run the gem.</strong><br>
<img src="/images/turboauth.png" alt="type turboauth into the terminal" title="run turboauth" /><br>
<br><br>
<strong>Go to the <a href="https://developers.facebook.com/apps">Developer Page</a> and click 'create new app.'</strong><br>
<img src="/images/create_new_app.png" alt="create a new app on FB developer page" title="create new app" /><br>
<br><br>
<strong>Fill out the appropriate info and click continue.</strong><br>
<img src="/images/naming_new_app.png" alt="fill out form and click continue" title="naming new app" /><br>
<br><br>
<strong>Now you're on your apps fb dashboard. First, change sandbox mode to disabled. Second, click 'website with facebook login.' Third, type the address of wherever your app will be loading, in this case I'm going to run my app on localhost:3000. Lastly, scroll to the bottom of the page and click 'Save Changes.'</strong>
<img src="/images/app_home_page.png" alt="disable sandbox, click website with facebook login, add local host address to facebook login box. save changes." title="FB app dashboard" /><br>
<br><br>
<strong>Copy the app ID and Secret from the facebook dashboard and paste it into the config.yml file in your app.</strong><br>
<img src="/images/app_id_secret.png" alt="copy app id and secret" title="FB app dashboard id/secret" /><br>
<br><br>
<img src="/images/facebook_yml.png" alt="paste id and secret into facebook.yml" title="facebook.yml" /><br>
<br><br>
<strong>Start your rails server...</strong><br>
<img src="/images/rails_s.png" alt="run your rails server" title="rails server" /><br>
<br><br>
<strong>Enjoy...</strong>

##Details
This is meant to be run on a fresh rails application. It will encounter errors if you have already added a user model or a number of other actions.<br>

The setup process used is the one presented by Ryan Bates in <a href="http://railscasts.com/episodes/360-facebook-authentication">Railscast 360</a>