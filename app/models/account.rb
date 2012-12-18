class Account < ActiveRecord::Base

  # Account records contain OAuth data from third parties: Facebook, Twitter, Foursquare, and so on.

  # Associations
  belongs_to :user

  # Attributes
  attr_accessible :user_id, :oauth_expires, :oauth_token, :provider, :uid, :username

end
