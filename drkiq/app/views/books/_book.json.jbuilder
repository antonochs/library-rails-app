json.extract! book, :id, :name, :author, :return_by, :description, :created_at, :updated_at, :genres, :library, :user
json.url book_url(book, format: :json)
