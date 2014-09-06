
# Install

```
brew install postgres
createuser -d -P postgres
bundle
bundle exec rake db:setup
heroku pgbackups:capture --app fol-events
curl -o latest.dump `heroku pgbackups:url`
pg_restore --verbose --clean --no-acl --no-owner -h localhost -U postgres -d fol_events_development latest.dump
```

## Running Tests

### Jasmine
```
RAILS_ENV=test bundle exec rake spec:javascript
```

### Rspec
```
bundle exec rake rspec
```