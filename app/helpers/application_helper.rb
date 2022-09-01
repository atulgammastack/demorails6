module ApplicationHelper
  def like_or_dislike_btn(post)
    like = Like.find_by(post: post, user: current_user)
    if like
      button_to('Dislike!', post_like_path(id: like.id, post_id: post.id), method: :delete)
    else
      button_to('Like!', post_likes_path(post_id: post.id), method: :post)
    end
  end
  
  def flash_class(level)
    case level
    when  'success' then 'alert-success'
    when 'notice' then 'alert-info'
    when  'alert' then 'alert- info'
    end
  end
end
