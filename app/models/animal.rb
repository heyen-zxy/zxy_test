# == Schema Information
#
# Table name: animals
#
#  id         :integer          not null, primary key
#  type       :string
#  name       :string
#  age        :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Animal < ActiveRecord::Base
  #self.abstract_class = true


end
