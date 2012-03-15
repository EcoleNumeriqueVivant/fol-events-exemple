#
# it will be better to move this module in /lib folder
#
module Addressable extend ActiveSupport::Concern
  included do
    has_one :address, :as => :addressable, :dependent => :destroy
    accepts_nested_attributes_for :address
  end
end