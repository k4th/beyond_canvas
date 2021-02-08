# frozen_string_literal: true

require_dependency 'beyond_canvas/application_controller'

module BeyondCanvas
  class SystemController < ApplicationController # :nodoc:
    include ::BeyondCanvas::LocaleManagement

    def update_locale
      cookies[:locale] = {
        same_site: :none,
        secure: :true,
        value: system_locale_params[:locale],
        expires: 1.day.from_now
      }

      redirect_back(fallback_location: main_app.root_path)
    end

    private

    #
    # Strong parameters for locale switch
    #
    def system_locale_params
      params.require(:system).permit(:locale)
    end
  end
end
