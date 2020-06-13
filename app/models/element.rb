class Element < ApplicationRecord
  extend Processor

  belongs_to :chapter
  has_many :notes

  delegate :book, to: :chapter
end
