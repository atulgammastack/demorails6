module ApplicationHelper
  def accept_friend_request_button(friendship_id)
    button_to('Accept', user_friendship_path(id: friendship_id, user_id: current_user.id), method: :patch, class: "btn btn-primary btn-lg")
  end

  def reject_friend_request_button(friendship_id)
    button_to('Decline', user_friendship_path(id: friendship_id, user_id: current_user.id), method: :delete, class: "btn btn-primary btn-lg")
  end

  def unfriend_friend_button(user)
    friendship = current_user.friendship_for(user)
    button_to('Unfriend', user_friendship_path(id: friendship.id, user_id: user.id), method: :delete, class: "btn btn-primary btn-lg")
  end

  def flash_class(level)
    case level
    when  'success' then 'alert-success'
    when 'notice' then 'alert-info'
    when  'alert' then 'alert- info'
    end
  end

  def conversation_participant(conversation)
    conversation.recipient == current_user ? conversation.sender : conversation.recipient
  end
end
