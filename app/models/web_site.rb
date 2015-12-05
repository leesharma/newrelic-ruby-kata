class WebSite < ActiveRecord::Base
  has_one :page_content
  has_one :icon

  def self.latest
    WebSite.order(:updated_at).last
  end
end
