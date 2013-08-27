class Division < ActiveRecord::Base
  has_many :units, :dependent => :destroy

  validates :abbr, :uniqueness => {:case_sensitive => false}
end
