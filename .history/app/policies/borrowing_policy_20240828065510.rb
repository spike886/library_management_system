class BorrowingPolicy < ApplicationPolicy
  # NOTE: Up to Pundit v2.3.1, the inheritance was declared as
  # `Scope < Scope` rather than `Scope < ApplicationPolicy::Scope`.
  # In most cases the behavior will be identical, but if updating existing
  # code, beware of possible changes to the ancestors:
  # https://gist.github.com/Burgestrand/4b4bc22f31c8a95c425fc0e30d7ef1f5

  class Scope < ApplicationPolicy::Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      if user.librarian?
        scope.all
      elsif user.member?
        scope.where(user: user)
      else
        scope.none
      end
    end
  end

  def return?
    ((user.member? && record.user == user) || user.librarian?) && record.returned_at.nil?
  end

  def borrow?
    user.member? && record.book.available?
  end

  def index?
    user.librarian?
  end
end
