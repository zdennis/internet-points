require 'rails_helper'

RSpec.describe Person, :type => :model do

  describe "points" do
    subject(:person){ FactoryGirl.create(:person, nick: "sally") }

    before do
      person.points.create value: 1, created_at: 1.year.ago
      person.points.create value: 2, created_at: 1.week.ago
      person.points.create value: 3, created_at: Time.zone.now.beginning_of_month
      person.points.create value: 4, created_at: Time.zone.now.beginning_of_month + 1.day
      person.points.create value: 5, created_at: Time.zone.now.beginning_of_week
      person.points.create value: 6, created_at: Time.zone.now.end_of_week
      person.points.create value: 7, created_at: Time.zone.now.beginning_of_day
      person.points.create value: 8, created_at: Time.zone.now.beginning_of_day + 1.hour
      person.points.create value: 9, created_at: Time.zone.now.end_of_day
      person.points.create value: 10, created_at: Time.zone.now.end_of_day - 1.hour
    end

    describe "#lifetime_points" do
      it "returns the sum total of all of the points the person has been given" do
        expect(person.lifetime_points).to eq(55)
      end
    end

    describe "#monthly_points" do
      it "returns the sum total of all of the points for the current month" do
        expect(person.monthly_points).to eq(47)
      end
    end

    describe "#daily_points" do
      it "returns the sum total of all of the points for the current month" do
        expect(person.daily_points).to eq(34)
      end
    end

    describe "#weekly_points" do
      it "returns the sum total of all of the points for the current month" do
        expect(person.weekly_points).to eq(52)
      end
    end
  end

end
