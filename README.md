# Secret Santa Script

This is a simple Ruby script for assigning secret Santas and texting everyone their assignment. The basic rule is that nobody can be assigned to give a gift to someone in their own group (including, of course, themselves). In my family, group == household, but it could mean anything you like.

The script uses Dennis Ranke's solution from [The Ruby Quiz #2](http://www.rubyquiz.com/quiz2.html), which gives everyone a correct assignment in just a few passes through the list. Nice! :) The only tweaks I (@nathanl) made were practical ones, like using config files, and a tiny bit of refactoring, logging, etc, to make it more apparent what's happening.

...

Then I, @mileszs, got ahold of this and made a bunch of changes. Most are immaterial, but I did use [this pull request](https://github.com/nathanl/secret_santa/pull/1) on @nathanl's original as a guide for converting this from email to text message using Twilio. I then made some organization changes, added some tests, and generally used this as an opportunity to practice refactoring and such.

## Usage

- Clone the repo
- Copy each of the `.yml.example` files in `config/` to a corresponding `.yml` and customize.
- `bundle install`
- Run `bundle exec ruby secret_santa.rb` and examine the output
- When you're satisfied, run `REALLY_SENDING=true bundle exec ruby secret_santa.rb`

## Dependencies

Ruby, and a Twilio account

## Thanks

Thanks to Dennis Ranke for a nice solution, and to James Edward Gray II for running The Ruby Quiz. Thanks to Nathan Long for doing most of the work, and Joren De Groof for doing the rest of it.
