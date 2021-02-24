class HomeController < ApplicationController
  def main
    @updates = Update.all
    @coke_percentage = 90
  end
end
