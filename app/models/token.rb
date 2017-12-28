class Token < ApplicationRecord
    has_many :edges
    validates :value, presence: true, uniqueness: true
end
