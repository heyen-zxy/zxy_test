# == Schema Information
#
# Table name: organizes
#
#  id         :integer          not null, primary key
#  name       :string
#  ancestry   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Organize < ActiveRecord::Base
  has_ancestry





end
