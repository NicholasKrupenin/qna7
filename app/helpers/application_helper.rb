module ApplicationHelper
  LIKE_URL = 'like.svg'.freeze
  DISLIKE_URL = 'dislike.svg'.freeze

  def git_embed(git_id)
    tag.code data: { gist_id: git_id }
  end

  def vote_like(obj, arg = 'like')
    image_tag(LIKE_URL, size: '25', class: 'vote_like', data: data_name(obj, arg))
  end

  def vote_dislike(obj, arg = 'dislike')
    image_tag(DISLIKE_URL, size: '25', class: 'vote_dislike', data: data_name(obj, arg))
  end

  def vote_string_like(obj, arg = 'like')
    link_to arg, send(path_vote_name(obj, arg), obj),
                 class: 'vote_like', data: data_name(obj, arg), method: :put, remote: true
  end

  def vote_string_dislike(obj, arg = 'dislike')
    link_to arg, send(path_vote_name(obj, arg), obj),
                 class: 'vote_dislike', data: data_name(obj, arg), method: :put, remote: true
  end

  def data_name(obj, arg)
    Hash["#{arg}-#{obj.model_name.human.downcase}", obj.id, :type, :json]
  end

  def path_vote_name(obj, arg)
    "#{arg}_#{obj.model_name.human.downcase}_path".to_sym
  end

  def rating
    tag.div class: :rating do
      '0'
    end
  end
end
