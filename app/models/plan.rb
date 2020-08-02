# frozen_string_literal: true

class Plan < ApplicationRecord
  belongs_to :product, foreign_key: 'product_id'
end
