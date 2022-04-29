class Person < ApplicationRecord
  validates :dna, uniqueness: true

  scope :not_mutant, -> { where(is_mutant: false) }
  scope :is_mutant, -> { where(is_mutant: true) }
end
