
class NotFoundRoute < ApplicationController

  def not_found_response
    halt_404
  end

  def rescue_response
    halt_404
  end

  get '*' do
    status 404
    not_found_response
  end

  not_found {
    not_found_response
  }

  errors {
    rescue_response
  }

end
