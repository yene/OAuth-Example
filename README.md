# OAuth Example
How to use OAuth on the Apple TV.
Apple TV does not ship with a browser so logging into a webservice (OAuth) has to be done on a seperate device.

# OAuth 1.0 example with goodreads
* https://www.goodreads.com/api/documentation#oauth

1. Start a webserver on apple tv
2. get a request token for OAuth
3. tell the user to open the site in on another device
4. redirect user to the authentication page, with a callback to our server
http://www.goodreads.com/oauth/authorize?oauth_callback=...&mobile=1&oauth_token=...
5. Parse oauth token from the callback
http://yourapp.com/goodreads_oauth_callback?oauth_token=ezBHZc7C1SwvLGc646PEQ&authorize=1

# Screenshots
![step 1](step1.png)
![step 2](step2.png)

# Problems
* I could not test bonjour discovery in the simulator.
* Port 80 is blocked.

# Credits
* https://github.com/swisspol/GCDWebServer
* https://github.com/dongri/OAuthSwift