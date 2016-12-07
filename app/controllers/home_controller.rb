class HomeController < ApplicationController
  def index
  	@tournaments = Tournament.where(:is_private => '0').limit(8)
  end
  def not_found
  end
end
