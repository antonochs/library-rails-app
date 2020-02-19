json.extract! book, :id, :name, :author, :return_by, :description, :created_at, :updated_at
json.url book_url(book, format: :json)
