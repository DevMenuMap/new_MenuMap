class MenuComment < ActiveRecord::Base
  belongs_to :menu
  belongs_to :comment
end
