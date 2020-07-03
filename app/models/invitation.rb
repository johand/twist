# frozen_string_literal: true

class Invitation < ApplicationRecord
  belongs_to :account
  validates :email, presence: true
end
