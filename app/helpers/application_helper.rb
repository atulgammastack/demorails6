module ApplicationHelper
  def like_or_dislike_btn(post)
    like = Like.find_by(post: post, user: current_user)
    if like
      button_to('Dislike!', post_like_path(id: like.id, post_id: post.id), method: :delete,class: "btn btn-primary btn-lg")
    else
      button_to('Like!', post_likes_path(post_id: post.id), method: :post, class: "btn btn-primary btn-lg")
    end
  end

  def accept_friend_request(friendship_id)
    button_to('Accept', user_friendship_path(id: friendship_id, user_id: current_user.id), method: :patch, class: "btn btn-primary btn-lg")
  end

  def reject_friend_request(friendship_id)
    button_to('Decline', user_friendship_path(id: friendship_id, user_id: current_user.id), method: :delete, class: "btn btn-primary btn-lg")
  end

  def unfriend_url(user)
    a = Friendship.where(user_id: current_user.id, friend_id: user.id, confirmed: true)
    b = Friendship.where(user_id: user.id, friend_id: current_user.id, confirmed: true)
    friendship = a.exists? ? a : b
    button_to('Unfriend', user_friendship_path(id: friendship.ids, user_id: user.id), method: :delete, class: "btn btn-primary btn-lg")
  end

  def flash_class(level)
    case level
    when  'success' then 'alert-success'
    when 'notice' then 'alert-info'
    when  'alert' then 'alert- info'
    end
  end
end
