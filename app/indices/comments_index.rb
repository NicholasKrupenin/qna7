ThinkingSphinx::Index.define :comment, with: :active_record do
  #fields
  indexes body

  #attributes
  has user_id, created_at, updated_at, commentable_type, commentable_id
end
