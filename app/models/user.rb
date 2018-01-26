class User < ApplicationRecord
  has_secure_password

  # alter knock jwt payload
  def to_token_payload
    {
      sub: id,
      admin: true,
      email: email
    }
  end
end
