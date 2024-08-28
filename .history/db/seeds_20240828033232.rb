# Clear existing data
Borrowing.destroy_all
Book.destroy_all
User.destroy_all

Borrowing.skip_callback(:validate, :before, :check_due_date)

# Create Librarian users
librarian1 = User.create!(
  email: 'librarian1@example.com',
  password: 'password',
  role: 'librarian'
)

librarian2 = User.create!(
  email: 'librarian2@example.com',
  password: 'password',
  role: 'librarian'
)

# Create Member users
member1 = User.create!(
  email: 'member1@example.com',
  password: 'password',
  role: 'member'
)

member2 = User.create!(
  email: 'member2@example.com',
  password: 'password',
  role: 'member'
)

# Create Books
book1 = Book.create!(
  title: 'The Great Gatsby',
  author: 'F. Scott Fitzgerald',
  genre: 'Fiction',
  isbn: '9780743273565',
  total_copies: 5
)

book2 = Book.create!(
  title: '1984',
  author: 'George Orwell',
  genre: 'Dystopian',
  isbn: '9780451524935',
  total_copies: 3
)

book3 = Book.create!(
  title: 'To Kill a Mockingbird',
  author: 'Harper Lee',
  genre: 'Fiction',
  isbn: '9780061120084',
  total_copies: 4
)

book4 = Book.create!(
  title: 'The Catcher in the Rye',
  author: 'J.D. Salinger',
  genre: 'Fiction',
  isbn: '9780316769488',
  total_copies: 2
)

# Create Borrowings
Borrowing.create!(
  user: member1,
  book: book1,
  borrowed_at: 1.week.ago,
  due_at: 1.week.from_now
)

Borrowing.create!(
  user: member1,
  book: book2,
  borrowed_at: 3.days.ago,
  due_at: 11.days.from_now
)

Borrowing.create!(
  user: member2,
  book: book3,
  borrowed_at: 2.weeks.ago,
  due_at: 2.days.ago # Overdue
)

Borrowing.create!(
  user: member2,
  book: book4,
  borrowed_at: 5.days.ago,
  due_at: 9.days.from_now
)



Borrowing.set_callback(:validate, :before, :check_due_date)