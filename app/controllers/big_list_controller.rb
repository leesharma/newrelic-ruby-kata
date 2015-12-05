class BigListController < ApplicationController
  def index
    @site_count = WebSite.count
    @first_site = WebSite.limit(1).first
  end
end
