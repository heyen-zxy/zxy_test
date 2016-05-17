class User < ActiveRecord::Base

  def self.say
    Sms.say
  end

end
