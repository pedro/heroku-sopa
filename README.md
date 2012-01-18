Heroku SOPA
===========

Quickily turn your Heroku app in and out of SOPA protest mode.

Internally it uses the [Custom Error Pages add-on][1] to make your app render
a 503 response containing [a protest][2] instead of your regular HTML.

Keep in mind it will override any existing MAINTENANCE_PAGE_URL on the app.


Usage
-----

    $ heroku sopa:on
    SOPA protest is now enabled

    $ heroku sopa:off
    SOPA protest disabled


[1]: http://devcenter.heroku.com/articles/custom-error-pages
[2]: https://www.google.com/landing/takeaction/