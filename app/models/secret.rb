class Secret < ApplicationRecord
  belongs_to :secret_group, query_constraints: %i[group_name owner]
end
