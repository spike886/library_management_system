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
20.times do |i|
  User.create!(
    email: "member#{i+1}@example.com",
    password: 'password',
    role: 'member'
  )
end

# Create Books
books = []
10.times do |i|
  books << Book.create!(
    title: "Book Title #{i+1}",
    author: "Author #{i+1}",
    genre: ['Fiction', 'Dystopian', 'Fantasy', 'Science Fiction', 'Mystery'].sample,
    isbn: "978-0#{rand(1000000000..9999999999)}",
    total_copies: rand(1..10)
  )
end

# Create Borrowings
members = User.where(role: 'member')
members.each do |member|
  10.times do
    book = books.sample
    borrowed_at = rand(1..10).days.ago
    due_at = [borrowed_at + 14.days, Date.today].sample

    Borrowing.create(
      user: member,
      book: book,
      borrowed_at: borrowed_at,
      due_at: due_at
    )
  end
  5.times do
    book = books.sample
    borrowed_at = rand(20..40).days.ago
    returned_at = [borrowed_at - 14.days, borrowed_at].sample

    Borrowing.create(
      user: member,
      book: book,
      borrowed_at: borrowed_at,
      returned_at: returned_at
    )
  end
end

