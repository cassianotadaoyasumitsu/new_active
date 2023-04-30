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