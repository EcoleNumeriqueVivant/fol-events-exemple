class HomeController < ApplicationController
  def index
  end

  def read
    File.open('public/index.html', File::RDONLY)
  end
end
