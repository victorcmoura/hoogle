class Website < ApplicationRecord
    has_many :edges
    validates :url, presence: true, uniqueness: true
end
