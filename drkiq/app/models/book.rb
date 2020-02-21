class Book < ApplicationRecord
    has_many :book_genres
    has_many :genres, :through => :book_genres

    scope :filter_book_by_genre, -> (genre_id) { joins(:genres).where(genres: { id: genre_id }) }
end
