require 'bcrypt'


class User


  include DataMapper::Resource
    property :id,    Serial
    property :email, String
    property :password_digest, Text
    property :email, String, required: true

  attr_reader   :password
  attr_accessor :password_confirmation

  # validates_presence_of :email
    validates_confirmation_of :password

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

end
