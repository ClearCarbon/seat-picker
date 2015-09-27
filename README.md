[![Build Status](https://travis-ci.org/ClearCarbon/seat-picker.svg?branch=master)](https://travis-ci.org/ClearCarbon/seat-picker)

# Seat Picker

A minimalist seat picker for running small events.

# Install on Heroku

1. Download latest release.
2. Extract into a directory of your choice and cd into it.
3. Run `cp config/application.default.rb config/application.rb` to copy in the default
  configuration. If you wish to use restricted registration where a key is required in
  the url to register for the seat picker you can turn it on and set the key in this file.
4. Set your mailer options at the bottom of config/environments/production.rb. We recommend using [Postmark](https://devcenter.heroku.com/articles/postmark) with Heroku.
5. Follow the [Heroku deploy instructions](https://devcenter.heroku.com/categories/deployment)

## Roadmap

Notes on features we want to implement are found at our [Trello board](https://trello.com/b/6rEmudXn/seat-picker).