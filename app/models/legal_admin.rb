class LegalAdmin < ActiveRecord::Base
  belongs_to :legal_addr
  belongs_to :admin_addr
end
