class StaticController < ApplicationController
  def home
  end

  def about
    @active[:about] = true
  end

  def search
  end

  def contact
    @active[:contact] = true
  end

end
