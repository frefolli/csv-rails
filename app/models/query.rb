class Query < ApplicationRecord
  has_one_attached :context
  validates :name, presence: true
  validates :context, presence: true
  validates :timestamp, presence: true
  
  def process
    blob = self.context.download

    lines = split_into_lines(blob)
    header = split_into_fields(lines[0])
    rows = []
    lines.drop(1).each do |line|
        rows.append(split_into_fields(line))
    end
    return {:header => header, :rows => rows}
  end

  private
    def split_into_lines(obj)
      return obj.strip().split("\n")
    end

    def split_into_fields(line)
      fields = []
      line.strip().split(",").each do |f|
        fields.append(f.strip())
      end
      return fields
    end
end
