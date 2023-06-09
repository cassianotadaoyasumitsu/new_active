# Rails app


### Fix rails_admin
```
delete assets/builds/application.css
```
```
delete application.sass.scss
```
app/assets/config/manifest.js
```
//= link_tree ../images
//= link_directory ../stylesheets .css
//= link_tree ../builds
//= link rails_admin.css
//= link rails_admin/src/rails_admin/base.js
``` 

### Reset database
```
Step 1: heroku restart
Step 2: heroku pg:reset DATABASE (no need to change the DATABASE)
Step 3: heroku run rake db:migrate
Step 4: heroku run rake db:seed (if you have seed)
Step 5: heroku restart if needed
```

### Heroku Staging
```
git push staging main

# to add app to staging
    heroku git:remote --remote staging --app my-staging-app
# to list apps on staging
    heroku apps --remote staging
``` 

### Heroku Production
```
heroku create <app-name> --region eu --remote production
git push heroku main
heroku run rails db:migrate --app <app-name>
heroku run rails db:seed --app <app-name>
```
