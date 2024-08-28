# Clear existing data
Borrowing.destroy_all
Book.destroy_all
User.destroy_all


# Create Librarian users
5.times do |i|
  User.create!(
    email: "librarian#{i+1}@example.com",
    password: 'password',
    role: 'librarian'
  )
end

# Create Member users
40.times do |i|
  User.create!(
    email: "member#{i+1}@example.com",
    password: 'password',
    role: 'member'
  )
end

# Create Books
books = []
20.times do |i|
  books << Book.create!(
    title: "Book Title #{i+1}",
    author: "Author #{i+1}",
    genre: ['Fiction', 'Dystopian', 'Fantasy', 'Science Fiction', 'Mystery'].sample,
    isbn: "978-0#{rand(1000000000..9999999999)}",
    total_copies: rand(1..20)
  )
end

# Create Borrowings
members = User.where(role: 'member')
members.each do |member|
  10.times do
    book = books.sample
    borrowed_at = rand(1..15).days.ago

    Borrowing.create(
      user: member,
      book: book,
      borrowed_at: borrowed_at,
    )
  end
  15.times do
    book = books.sample
    borrowed_at = rand(20..40).days.ago
    due_at = borrowed_at + 14.days
    returned_at = [borrowed_at + 14.days, due_at + 1.day].sample

    Borrowing.create(
      user: member,
      book: book,
      borrowed_at: borrowed_at,
      returned_at: returned_at
    )
  end
end

