require 'rails_helper'

RSpec.describe DashboardController, type: :routing do
  describe 'routing' do
    it 'routes to #dashboard' do
      expect(get: '/dashboard').to route_to('dashboard#index')
    end
  end
end
