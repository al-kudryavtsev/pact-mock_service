require 'pact/consumer/mock_service/web_request_others'

module Pact
  module Consumer
    class InteractionPost < WebRequestAdministration

      attr_accessor :interaction_list

      def initialize name, logger, interaction_list
        super name, logger
        @interaction_list = interaction_list
      end

      def request_path
        '/interactions'
      end

      def request_method
        'POST'
      end

      def respond env
        request_body = env['rack.input'].string
        interaction = Interaction.from_hash(JSON.load(request_body))
        interaction_list.add interaction
        logger.info "Registered expected interaction #{interaction.request.method_and_path}"
        logger.debug JSON.pretty_generate JSON.parse(request_body)
        [200, {}, ['Added interaction']]
      end
    end
  end
end
