class OrganizationsController < ApplicationController
  def index
    @organizations = Organization.order(:name).all
    authorize :organization
  end
end
