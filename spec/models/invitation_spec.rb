# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Invitation, type: :model do
  let(:account) { FactoryBot.create(:account) }

  it 'generates a unique token' do
    invitation = Invitation.create(email: 'test@example.com', account: account)
    expect(invitation.token).to be_present
  end
end
