class Payee < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  has_many :statements, dependent: :nullify
end
