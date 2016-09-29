class Person < ApplicationRecord
  has_many :points

  def daily_points
    points.during(
      Time.zone.now.beginning_of_day..Time.zone.now.end_of_day
    ).sum(:value)
  end

  def lifetime_points
    points.sum(:value)
  end

  def monthly_points
    points.during(
      Time.zone.now.beginning_of_month..Time.zone.now.end_of_month
    ).sum(:value)
  end

  def weekly_points
    points.during(
      Time.zone.now.beginning_of_week..Time.zone.now.end_of_week
    ).sum(:value)
  end

end
