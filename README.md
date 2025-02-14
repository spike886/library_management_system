# Library Management System

The Library Management System is a web application built with Rails 7.2. It provides user authentication/registration using devise, and authorization using pundit making sure that no prohibited actions are taken by unauthorized users. The system allows users to borrow books, return books, and view borrowed books.

The application supports a RESTful API for CRUD operations on books and borrowings using the standard rails controller supporting responses on multiple formats. The documentation fo the API was done using apipie. The project is containerized with Docker and includes documentation for setup and usage.

The design of the application is very simple and using bootstrap for making it look nice. The application follow all the best practices for Rails so it's very responsive and easy to maintain.

## Getting Started

### Installation

1. **Clone the repository**:

```bash
git clone https://github.com/spike886/library_management_system.git
cd library_management_system
```

2. **Create the .env File**: Create a .env file in the root of your project and add the following:

```
POSTGRES_USER=postgres
POSTGRES_PASSWORD=password
POSTGRES_DB=library_management_system_development
RAILS_ENV=development
SECRET_KEY_BASE=your_secret_key_here
RAILS_LOG_TO_STDOUT=true
```

3. **Build and Run the Containers**:

```bash
docker compose up --build
```

4. **Create and Migrate the Database**:

```bash
docker compose run web bundle exec rails db:create db:migrate
```

5. **Seed the Database (Optional)**: You can seed the database with demo data (librarian, member, books) by running:

```bash
docker compose run web bundle exec rails db:seed
```

6. **Access the Application**: Visit http://localhost:3000 in your web browser.

7. **Run Tests**: You can run the RSpec test suite with:

```bash
docker compose run web bundle exec rspec
```

## Seed Data

Once the seeds are loaded:

Librarian Accounts:
librarian1@example.com / password
librarian2@example.com / password

Member Accounts:
member1@example.com / password
member2@example.com / password

## API Documentation

The API documentation is available at http://localhost:3000/apipie
