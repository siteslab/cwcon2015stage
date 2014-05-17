tweet_feed
==========

A module to integrate Twitter feeds using Views. Works with Twitter API v1.1 - all you need are the access tokens from a created application. You can specify the search and, using views, limit tweets displayed to their owner by ID. 

This module also creates linked URLs from URLs, Hash Tags and Usernames inside the feed itself.

Requires:<br />
<b>Oauth (Oauth Common)</b><br />
<b>Views</b>

This module exists thanks to the generous support of <a href="http://highwire.org">HighWire Press</a> and <a href="http://stanford.edu">Stanford University</a>

Working on a documentation page. Until then here is a brief tutorial on how to set up the module. 

You will need to provide an API Key, API Secret Key, Access Token and Access Token Secret that you get from your API on Twitter. Once those have been provided you will also want to enter a term by which to search twitter. This should contain the criteria by which you wish to extract data from Twitter.

Once this data is saved, run the cron. It will pull in tweets if everything is configured correctly with your tokens. Note that the API only returns tweets within the last 30 days.

From there you will need to use the view (a sample of which is included with the module). Look for the Tweet Feed disabled view, make a clone of it and configure what you need from it.

I plan some more robust documentation with a screen cast. Look for that by April 1, 2014.

