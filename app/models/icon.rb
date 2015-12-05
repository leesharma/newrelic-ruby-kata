class Icon < ActiveRecord::Base
  belongs_to :web_site, touch: true
end
