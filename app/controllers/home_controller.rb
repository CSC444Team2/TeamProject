class HomeController < ApplicationController
  def index
  	@tournaments = Tournament.where(:is_private => '0').limit(5)
  end
  def not_found
  end
end
