defmodule BlogApp.Schema do
  use Absinthe.Schema
  import_types BlogApp.Schema.Types

  query do
    field :blog_posts, list_of(:blog_post) do
      resolve &BlogApp.Blog.PostResolver.all/2
    end

    field :accounts_users, list_of(:accounts_user) do
      resolve &BlogApp.Accounts.UserResolver.all/2
    end
  end

  # mutation do
  #   @desc "Create a post"
  #   field :post, type: :post do
  #     arg :title, non_null(:string)
  #     arg :body, non_null(:string)
  #     arg :posted_at, non_null(:string)
  #
  #     resolve &Blog.PostResolver.create/2
  #   end
  # end
end
