class Edge < ApplicationRecord
    belongs_to :website
    belongs_to :token
end
