class Link < ApplicationRecord
  belongs_to :linkable, polymorphic: true

  validates :name, presence: true
  validates :url, presence: true,
                  format: { with: URI::DEFAULT_PARSER.make_regexp(%w[http https]),
                                              message: "external_url is invalid" }
end
