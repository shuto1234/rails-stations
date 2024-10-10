class Admin::Movie < ActiveRecord::Base
  validates :name, presence: true
  validates :year, presence: true
end