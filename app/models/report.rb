class Report
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, type: String
  field :link, type: String
  field :content, type: String
  field :pub_date, type: DateTime
end
