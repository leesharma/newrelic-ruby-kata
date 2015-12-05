class LoopController < ApplicationController
  def index
    @sites = WebSite.includes(:icon).limit(1_000)
  end
end
