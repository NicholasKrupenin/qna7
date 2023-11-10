class Link < ApplicationRecord
  belongs_to :linkable, polymorphic: true

  validates :name, presence: true
  validates :url, presence: true,
                  format: { with: URI::DEFAULT_PARSER.make_regexp(%w[http https]),
                                              message: "external_url is invalid" }

  def gist?
    url.match?(/^https:\/\/gist\.github\.com\/.*/)
  end

  def git_id
    match_data = url.match(/^https:\/\/gist\.github\.com\/.*\/(?<gist>.*)/)
    match_data ? match_data[:gist] : nil
  end
  
end
