class ArticlePolicy < ApplicationPolicy
  def publish?
    @user.editor?
  end

  def create?
    @user.editor? || @user.author?
  end

  def destroy?
    create? && !record.published?
  end

  def update?
    @user.editor? || @user.author? && !record.published?
  end

  # ArticlePolicy::Scope.new
  class Scope < Scope
    def resolve
      if user.editor?
        scope.all # default 'scope' is whatever its initialized with, eg Article.all
      elsif user.author?
        scope.where(author: user, published: false)
      else
        scope.where(published: true)
      end
    end
  end
end
