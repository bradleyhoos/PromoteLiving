class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
     :confirmable, :lockable, :timeoutable

 def self.authenticate( password)
  user = User.find_by_name(name)

  #  if user.find_by_password(password)#match_password(password)
  #    return true
  #  else
  #    return false
  #  end
  end
end
