module ApplicationHelper
  def git_embed(git_id)
    tag.code data: { gist_id: git_id }
  end
end
