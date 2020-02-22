class Book < ApplicationRecord
    has_many :book_genres
    has_many :genres, :through => :book_genres
    belongs_to :library, optional: true

    scope :filter_book_by_genre, -> (genre_id) { joins(:genres).where(genres: { id: genre_id }) }
    scope :is_checked_out, -> { where("return_by < ?", Time.current )}
end
