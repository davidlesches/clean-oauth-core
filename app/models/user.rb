class User < ActiveRecord::Base

  # There is a gotcha with paperclip. It sticks images in a regular_users/ directory.
  # This seems to fix it but test to ensure it isn't saving all images. Ie when a user updates
  # his image it should by default delete the old one and I think with this fix that does not happen
  #   has_attached_file :photo,
  #                   :styles => { :medium => "300x300#", :small => "100x100#", :thumb => "50x50#" },
  #                   :url => "/system/users/:attachment/:id/:style/:basename.:extension"

  # Associations
  has_many :accounts, :dependent => :destroy

  # Attributes
  attr_accessible :email, :first_name, :last_name, :password, :password_confirmation

  # Instance Methods
  def has_facebook?
    accounts.where(provider: 'facebook').any?
  end

  def has_twitter?
    accounts.where(provider: 'twitter').any?
  end

  def has_foursquare?
    accounts.where(provider: 'foursquare').any?
  end

end