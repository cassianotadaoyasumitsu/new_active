class Request < ApplicationRecord
  has_and_belongs_to_many :users

  REQUEST_STATUS = %w[waiting review active inactive]

  after_initialize :set_default_status

  def set_default_status
    self.status ||= :waiting
  end
end