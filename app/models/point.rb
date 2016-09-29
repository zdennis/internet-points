class Point < ApplicationRecord
  belongs_to :person

  scope :during, -> (time_range) do
    sql = "created_at >= ? AND created_at <= ?"
    where(sql, time_range.begin, time_range.end)
  end
end
