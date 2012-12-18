class User < ActiveRecord::Base

  # Associations
  has_many :accounts, :dependent => :destroy

  # Attributes
  attr_accessible :email, :first_name, :last_name, :password, :password_confirmation

  # Instance Methods
  def has_facebook?
    accounts.where(provider: 'facebook').count > 0
  end

  def has_twitter?
    accounts.where(provider: 'twitter').count > 0
  end

  def has_foursquare?
    accounts.where(provider: 'foursquare').count > 0
  end

end