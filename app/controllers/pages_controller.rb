class PagesController < ApplicationController
  before_action :skip_authorization

  def workshop21
    @edition = Edition.find(121)
    render layout: 'pages'
  end
end
