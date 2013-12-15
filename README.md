#TurboAuth for Rails 4.0

## What is this?
I got tired of having to set up all the configuration for authenticating users every time I wanted to make a small app or try something new. So I made a gem that runs after creating a new rails app that automatically sets up facebook authentication so that you can get right to the coding you wanted to do when you started your app.

##Installation

```bash
$gem install turboauth
```

##Usage

Step 1. Create New Rails app (go into that apps folder)
Step 2. Install turboauth and run it with 'turboauth' in command line.
Step 3. Remove Turbolinks.
Step 4. Get Facebook info from https://developers.facebook.com/apps and paste it in config/facebook.yml (be sure to enable website with Facebook login and set the URL appropriately)
Step 5. Start your rails server.

##Details
This is meant to be run on a fresh rails application. It will encounter errors if you have already added a user model or a number of other actions.
