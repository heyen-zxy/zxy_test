# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  age        :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  email      :string(255)
#  qq         :string(255)
#  address    :string(255)
#

class User < ActiveRecord::Base

  include DynamicTable

  def self.say
    Sms.say
  end

end
