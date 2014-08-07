# == Schema Information
#
# Table name: tags
#
#  id       :integer         not null, primary key
#  name     :string(255)
#  context  :string(255)
#  position :integer
#

class Tag < ActiveRecord::Base
  acts_as_list # to manage position
  default_scope {order(:position)}

  validates_inclusion_of :context, :in => %w{typology theme}, :message => "^invalid context"
  scope :typology, -> { where(context: 'typology') }
  scope :theme, -> { where(context: 'theme') }

end
