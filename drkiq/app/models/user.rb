class User < ApplicationRecord
    has_many :books

    scope :find_user_by_name, -> (username) { find_by!(name: username) }
end
