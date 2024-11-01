class SecretGroup < ApplicationRecord
  belongs_to :user, primary_key: :name, foreign_key: :owner
  has_many :secrets, query_constraints: %i[group_name owner], primary_key: %i[name owner]

  self.primary_key = %i[name owner]
end
