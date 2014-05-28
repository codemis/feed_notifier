Feed Notifier
-------------

This Ruby script checks a group of RSS/podcast feeds, and checks if it has been updated since the last check.  If it has been updated,
it will push a notification to [Parse](http://parse.com).  It saves the last update date and time to the last_update.yml file.  To setup
the script:

1) Rename `parse.sample.yml` to `parse.yml` in the `settings` folder.
2) Add your Parse settings to the `parse.yml` file.
3) Rename `feeds.sample.yml` to `feeds.yml` in the `settings` folder.
4) Add your feeds to the `feeds.yml` file.  The keys MUST be unique, because we use it to reference the last updated date and time.
6) Rename `last_update.sample.yml` to `last_update.yml` in the `settings` folder.
7) Add keys for each feed, and a starting date to the `last_update.yml` similar to the examples in the file.

To run the script, just run the following command in your command line utility:

`ruby feed_notifier.rb`

Development
-----------

Questions or problems? Please post them on the [issue tracker](). You can contribute changes by forking the project and submitting a pull request.

License
-------
This script is created by Missional Digerati and is under the [GNU General Public License v3](http://www.gnu.org/licenses/gpl-3.0-standalone.html).