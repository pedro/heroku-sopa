Heroku SOPA
===========

Quickily turn your Heroku app in and out of SOPA protest mode.

Internally it uses the [Custom Error Pages add-on][1] to make your app render
a 503 response containing [a protest][2] instead of your regular HTML.

Keep in mind it will override any existing MAINTENANCE_PAGE_URL on the app.


Usage
-----

    $ heroku plugins:install git@github.com:pedro/heroku-sopa.git
    heroku-sopa installed

    $ heroku sopa:on
    SOPA protest is now enabled
    Redirecting to: http://www.zachstronaut.com/lab/text-shadow-box/stop-sopa.html

    $ heroku sopa:off
    SOPA protest disabled


Available Protests
------------------

Change the protest page with a param. For instance:

    $ heroku sopa:on eff
    SOPA protest is now enabled
    Redirecting to: http://blacklists.eff.org

You can pick any from the list below:

* [`eff`][3]
* [`protestsopa`][4]
* [`sopasoup`][5]
* [`zachstronaut`][2]

Or use any page you like:

    $ heroku sopa:on http://my-custom-sopa-protest-page.com
    SOPA protest is now enabled
    Redirecting to: http://my-custom-sopa-protest-page.com


About
-----

Written by Pedro Belo. Thanks Caley Woods for the idea!


[1]: http://devcenter.heroku.com/articles/custom-error-pages
[2]: http://www.zachstronaut.com/lab/text-shadow-box/stop-sopa.html
[3]: http://blacklists.eff.org
[4]: http://protestsopa.org
[5]: http://sopasoup.heroku.com
