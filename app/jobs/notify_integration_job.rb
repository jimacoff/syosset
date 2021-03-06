class NotifyIntegrationJob < ApplicationJob
  queue_as :integrations

  def perform(integration_id, event, parameters)
    integration = Integration.find(integration_id)
    begin
      integration.create_provider.send(event.to_sym, parameters)
    rescue Exception => error
      integration.failures << IntegrationFailure.new(error: error.message, event: event, parameters: parameters)
      integration.save
      Redis.current.incr('integration_failures')
    end
  end
end
