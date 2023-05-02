class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
      @requests = Request.where(status: "waiting")
  end


end
