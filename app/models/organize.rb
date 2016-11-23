# == Schema Information
#
# Table name: organizes
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  ancestry   :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Organize < ActiveRecord::Base
  has_ancestry





end
