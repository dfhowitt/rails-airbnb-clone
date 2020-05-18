class PagesController < ApplicationController
  def home
    @properties = Property.all
  end
end
