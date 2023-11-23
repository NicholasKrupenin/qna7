module ApplicationHelper
  def git_embed(git_id)
    tag.code data: { gist_id: git_id }
  end

  def vote_string_like(obj, arg = 'like')
    link_to arg, send(path_vote_name(obj, arg), obj),
            class: 'vote_like', data: data_name(obj, arg), method: :put, remote: true
  end

  def vote_string_dislike(obj, arg = 'dislike')
    link_to arg, send(path_vote_name(obj, arg), obj),
            class: 'vote_dislike', data: data_name(obj, arg), method: :put, remote: true
  end

  def deselect(obj, arg = 'deselect')
    link_to arg, send(path_vote_name(obj, arg), obj),
            class: 'deselect', data: data_name(obj, arg), method: :delete, remote: true
  end

  def data_name(obj, arg)
    Hash["#{arg}-#{obj.model_name.human.downcase}", obj.id, :type, :json]
  end

  def path_vote_name(obj, arg)
    "#{arg}_#{obj.model_name.human.downcase}_path".to_sym
  end

  def rating(obj)
    tag.container class: :rating do
      obj.rating_votes.to_s
    end
  end
end
