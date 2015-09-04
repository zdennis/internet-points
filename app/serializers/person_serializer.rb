class PersonSerializer < ActiveModel::Serializer
  attributes :id, :nick, :daily_points, :lifetime_points, :monthly_points, :weekly_points
end
