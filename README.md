## TheyWorkForYou.co.nz (twfynz)

Not ready for other developers just to pick up and run with, as the data
is not committed with this repository.

Email me if you're really interested. My email address is listed at
the development blog: http://blog.theyworkforyou.co.nz/

## Install steps

If the message above didn't put you off here are some install steps.

First make sure you have git installed on your machine <http://git.or.cz/>.
Also be sure to have Ruby installed <http://www.ruby-lang.org/>. Then:

This project uses ImageMagick.

For OSX you can install that using Homebrew

``brew install imagemagick``


 git clone git@github.com/opennewzealand/twfynz.git

 cp config/database.yml.example config/database.yml

 rake gems:install      # repeat until all gems installed
 rake gems              # should show all gems installed [I]

 rake db:migrate        # creates tables in development environment

 rake spec              # runs specs -> should be green!

 rails s                # runs the Rails Server

You won't have any data, but should see a few pages render in browser.

