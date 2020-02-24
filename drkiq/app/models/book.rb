class Book < ApplicationRecord
    has_many :book_genres
    has_many :genres, :through => :book_genres
    belongs_to :library, optional: true
    belongs_to :user, optional: true

    scope :filter_book_by_genre, -> (genre_id) { joins(:genres).where(genres: { id: genre_id }) }
    def is_checked_out
        if self.return_by < Time.current
            return true
        else
            return false
        end
    end

    def update_availability
        write_attribute :availability, self.is_checked_out
    end
end
