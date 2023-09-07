require "csv"

class Query < ApplicationRecord
  has_one_attached :context
  validates :name, presence: true
  validates :context, presence: true
  validates :timestamp, presence: true
  
  def process
    blob = self.context.download
    csv = CSV.new(blob)
    header = csv.shift
    rows = csv.read
    return {:header => header, :rows => rows}
  end
end
