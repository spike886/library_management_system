class BookPolicy < ApplicationPolicy
  # NOTE: Up to Pundit v2.3.1, the inheritance was declared as
  # `Scope < Scope` rather than `Scope < ApplicationPolicy::Scope`.
  # In most cases the behavior will be identical, but if updating existing
  # code, beware of possible changes to the ancestors:
  # https://gist.github.com/Burgestrand/4b4bc22f31c8a95c425fc0e30d7ef1f5

  class Scope < ApplicationPolicy::Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      if user.librarian? || user.member?
        scope.all
      else
        scope.none
      end
    end
  end


  def create?
    user.librarian?
  end

  def update?
    user.librarian?
  end

  def see_total_copies?
    user.librarian?
  end

  def destroy?
    user.librarian?
  end

  def show?
    user.librarian? || user.member?
  end

  def index?
    user.librarian? || user.member?
  end

  def borrow?
    user.member? && record.available?
  end

  def return_book?
    true
  end
end
