class Edge < ApplicationRecord
    belongs_to :website
    belongs_to :token

    validates_uniqueness_of :token, scope: [:website]
end
