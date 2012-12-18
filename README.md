# Clean OmniAuth
### An object-oriented approach to integrating multiple OAuth providers with Rails.
#### Full blog post coming shortly on nycdevshop.com/blog

The OAuth gems go a long way towards making OAuth implantation with Rails apps a pain-free process, but the standard method of implementation (see [here](http://railscasts.com/episodes/360-facebook-authentication) and [here](http://railscasts.com/episodes/359-twitter-integration)) rapidly breaks down on a full scale production app:

1. It uses one model, User, to combine both OAuth logic and validations with "Standard User" (i.e, created through a standard sign up form) logic and validations. It doesn't take long for clashes to begin. For example, your Standard User must enter an email and password, but Twitter OAuth provides neither. The only way out is with conditionals and callback hell.

2. It creates a new User every time, providing no way for a Standard User to later integrate an OAuth account into his existing account.

3. It provides no easy way to add multiple OAuth accounts (Facebook and Twitter and LinkedIn and Github) into a single User account.

4. The OAuth gems try hard to standardize the hash of data received by the app, but they are still not exactly the same. This means that separate, long, almost-identical methods need to be written to create each type of OAuth account - which is not DRY.

5. There is no clean way to trigger different types of callbacks without lots of nasty conditionals. For example, when a Foursquare user logs in, you want to refresh his checkin data every time, but when a Facebook user logs in, you want to retrieve his latest list of friends.

# Solution

To implement OAuth using an object-oriented approach, using Plain Old Ruby Objects.

Both Standard User-specific logic and OAuth User-specific logic is **removed** from the User model and moved into RegularUser and OAuthUser models respectively. These models are not table-backed and do not inherit from ActiveRecord::Base. They are used only in the User **creation** phase, acting as intermediary layers between the core User model and the person using the website to create his User object.

The result is that the site visitor, creating or editing his User account, always interacts via the RegularUser or OAuthUser class and its valiations and logic, whereas the core app itself (e.g., the current_user helper) interacts with the core User model directly - bypassing any issues with RegularUser-specific or OAuthUser-specific validation or logic.

Nice and clean.

The OAuthUser user class can optionally receive an existing User object. If a visitor is already logged in to the app when he adds a new OAuth account, SessionsController passes the current_user object to OAuthUser, which now knows that this new OAuth account is to be **added** to the user object, rather than to create a new User object. (This solves issue 2 above.)

The Policy object pattern is used to cleanly standardize the data hash returned from the OAuth gems. See folder app/policies. (This solves issue 4 above.) Though the Policy object pattern objects is not commonly used in Rails apps, this is an ideal use for them.

Also included in this repo are the Facebook and Foursquare objects, which are POROs for interactions with Facebook and Foursquare. As an example of how the our OAuth usage pattern makes it easy to trigger OAuth-specific callbacks, we have included these objects together with the CheckinCreator object and its corresponding FacebookCheckinPolicy and FoursquareCheckinPolicy policy objects.

