class RegularUser < User

  has_secure_password

  validates :email, uniqueness: true
  validates :first_name, :last_name, :email, presence: true
  validates :email, email: true
  before_validation :passwords

  def passwords
    self.password_confirmation = self.password
  end

end