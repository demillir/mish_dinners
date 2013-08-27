class Division < ActiveRecord::Base
  has_many :units, :dependent => :destroy
end
