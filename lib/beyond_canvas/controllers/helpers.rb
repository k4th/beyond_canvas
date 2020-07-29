# frozen_string_literal: true

module BeyondCanvas
  module Controllers
    # Those helpers are convenience methods added to ApplicationController.
    module Helpers
      extend ActiveSupport::Concern

      # TODO mapping
      def self.define_helpers(mapping = 'shop') #:nodoc:
        #mapping = mapping.name

        class_eval <<-METHODS, __FILE__, __LINE__ + 1
          def test_#{mapping}_signed_in?
            !!current_#{mapping}
          end

          def test_current_#{mapping}
            @current_#{mapping} ||= Shop.find(session[:byd_shop_id])
          end

          def test_#{mapping}_session
            current_#{mapping} && warden.session(:#{mapping})
          end
        METHODS

        ActiveSupport.on_load(:action_controller) do
          if respond_to?(:helper_method)
            helper_method "test_current_#{mapping}", "test_#{mapping}_signed_in?", "test_#{mapping}_session"
          end
        end
      end
    end
  end
end
