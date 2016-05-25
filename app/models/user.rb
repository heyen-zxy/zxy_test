# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string
#  age        :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  email      :string
#  qq         :string
#  address    :string
#

class User < ActiveRecord::Base

  def self.say
    Sms.say
  end

end
