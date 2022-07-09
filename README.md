# Gmvault Container

## OAuth Setup

**Note: This was copied from https://github.com/gaubert/gmvault/issues/335#issuecomment-846483036 to preserve in case it gets removed**

Procedure to get yourself a new client ID & secret:

* Start here: https://console.developers.google.com
* Accept conditions, if you never used the Google API Console (after reading all the terms and conditions, evidently)
* Create a new project (at the top); of choose one you already have, if that makes sense. If you create a new one, if takes a few seconds to created. You will need to manually select it after its been created.
* Go to https://console.developers.google.com/apis ; click `+ ENABLE APIS AND SERVICES` at the top
* Search for `Gmail API`; select it; click `Enable`
* Go to https://console.developers.google.com/apis/credentials/consent
* User Type: choose `External` (`Internal is for Google Workspace accounts; it would limit usage to only accounts within your Workspace)
* Click `Create`
* App name: enter anything you like
* User support email: choose anything available
* Developer contact information is also required at the bottom; enter the same email adress
* Click `SAVE AND CONTINUE` at the bottom
* Click `ADD OR REMOVE SCOPES`
* Select the checkbox on the `Gmail API : https://mail.google.com/` line; click `UPDATE`
* Click `SAVE AND CONTINUE` at the bottom
* Click `ADD USERS`
* Enter all the email addresses you'll want to backup using gmvault (if you want to add more later, come back here and add them)
* Click `ADD`
* Click `SAVE AND CONTINUE` at the bottom
* Click `Credentials` in the left menu
* Click `Create Credentials`; choose `OAuth client ID`
* Application Type: `Desktop app`; give it a name (anything; I suggest `gmvault`, since this credential will be used by gmvault)
* Click `Create`
* You will get a `client ID` and `secret`. Those two values needs to replace the existing ones in `$HOME/.gmvault/gmvault_defaults.conf` : `gmvault_client_id=...` and `gmvault_client_secret=...`
* If you are running gmvault 1.9.1, make sure `conf_version=1.9` in that same conf file, and NOT `conf_version=1.9.1`, otherwise, gmvault will overwrite it every time it runs. (This is a bug in 1.9.1, fixed in 1.9.2; so you do not need to change `conf_version` if you are running 1.9.2-beta-1 or higher.)
* Finally, obtain a new OAuth token using the following command:
  `gmvault check --renew-oauth2-tok your_email_address@gmail.com`
  When navigating to the URL that gmvault provides, you will see `Google hasn’t verified this app`.
  Click `Continue`, then `Allow` twice.

Repeat this last step for all other Gmail accounts you are backing up using Gmvault on this particular computer, or the last 3 steps on other computers. (No need to create multiple clientIDs & secrets to backup multiple accounts or for multiple installs.)
