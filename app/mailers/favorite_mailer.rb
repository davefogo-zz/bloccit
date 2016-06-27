class FavoriteMailer < ApplicationMailer
  default from: "davefogo@gmail.com"

  def new_comment(user, post, comment)

    headers["Message-ID"] = "<comments/#{comment.id}@warm-bayou-80313.herokuapp.com>"
    headers["In-Reply-To"] = "<post/#{post.id}@warm-bayou-80313.herokuapp.com>"
    headers["References"] = "<post/#{post.id}@warm-bayou-80313.herokuapp.com>"

    @user = user
    @post = post
    @comment = comment

    mail(to: user.email, cc: "phil@bloc.io", subject: "New comment on #{post.title}")
  end
end
