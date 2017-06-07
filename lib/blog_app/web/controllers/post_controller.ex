defmodule BlogApp.Web.PostController do
  use BlogApp.Web, :controller

  alias BlogApp.Blog
  alias BlogApp.Blog.Post
  alias BlogApp.Accounts.User

  action_fallback BlogApp.Web.FallbackController

  def index(conn, _params) do
    posts = Blog.list_posts()
    render(conn, "index.json", posts: posts)
  end

  def create(conn, %{"post" => post_params}) do
    IO.puts "- - - - - - - - - - - - - - - - - - post_params"
    IO.inspect post_params

    # new_post = Ecto.build_assoc(user, :posts,
    #   Map.put(post, :accounts_users_id, post_params.accounts_users_id))
    # Repo.insert!(new_post)

    with {:ok, %Post{} = post} <- Blog.create_post(post_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", post_path(conn, :show, post))
      |> render("show.json", post: post)
    end
  end

  def show(conn, %{"id" => id}) do
    post = Blog.get_post!(id)
    render(conn, "show.json", post: post)
  end

  def update(conn, %{"id" => id, "post" => post_params}) do
    post = Blog.get_post!(id)

    with {:ok, %Post{} = post} <- Blog.update_post(post, post_params) do
      render(conn, "show.json", post: post)
    end
  end

  def delete(conn, %{"id" => id}) do
    post = Blog.get_post!(id)
    with {:ok, %Post{}} <- Blog.delete_post(post) do
      send_resp(conn, :no_content, "")
    end
  end
end
