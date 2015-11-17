Ejabberd Archive Viewer
================

[![Deploy to Heroku](https://www.herokucdn.com/deploy/button.png)](https://heroku.com/deploy)

Ejabberd Archive Viewer is a simple Rails application that displays XMPP messages history stored by ejabberd/mod_archive_odbc.

Features:

- Contact list
- Paginated message list for each contact
- You can rename contacts 
- You can create metacontacts by assigning the same name to multiple contacts
- Text search in a contact's history

Limitations:

- The application currently can't be used by multiple users or servers. The server database and the user's JID need to be set in settings.

Configuration: copy `config/application.yml.example` to `config/application.yml` and adjust your settings.
