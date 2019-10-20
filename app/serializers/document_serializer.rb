class DocumentSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes :id, :title, :draft,:content, :abstract ,:auxiliaries
#  has_many :posts,  serializer: PostSerializer
#  belongs_to :user
  def auxiliaries
    object.auxiliaries
  end

  def content
    object.send(:content).to_s
  end
end
