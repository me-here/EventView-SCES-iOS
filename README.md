# EventView - An Event Management App
Built with UIKit, Alamofire, & the EventView API.
## Installing
1. git clone https://github.com/me-here/EventView-SCES-iOS.git
2. pod install
3. Open xcworkspace
4. Add your signing certificate
5. Run it :)

![Login Screen](https://www.dropbox.com/s/27b7vkkdecdq8pg/Screen%20Shot%202021-01-26%20at%205.22.22%20PM.png?raw=1)
![Event Table View](https://www.dropbox.com/s/cynbfx0oy7qkxaw/Screen%20Shot%202021-01-23%20at%2012.22.52%20AM.png?raw=1)

## Features
*Authentication*
- [X] Users should be able to log in with an existing account.
- [X] Users should be able to sign up with a new account.
- [X] Users should be able to log out of their account as well.

*Event table view*
- [X] Upon logging in, users should be presented with a table where each row
represents one event.
- [X] Rows should include the name, location, and start/end times of the
corresponding event.

*Event detail view*
- [X] When selected, each row in the table should segue to a detail view showing the
complete set of information about the corresponding event (except the ID).
- [X] Additionally, there should be a way for the user to mark themselves as
“Attending” the selected event.

## Additional Features
- [X] Add constraints so that the interface scales to different screen sizes
- [X] Allow users to refresh in the table view.
- [X] Cache the user’s credentials so that they stay logged in after exiting the app
- [X] Launch Screen & Logo.
