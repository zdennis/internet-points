require 'rails_helper'

describe "Viewing a person's profile" do
  def json_response
    JSON.parse(page.body)
  end

  scenario "for a non-existent person" do
    visit "/people/matt"
    expect(page.status_code).to be 200
    expect(json_response["person"]["nick"]).to eq "matt"
    expect(json_response["person"]["lifetime_points"]).to eq 0
  end

  scenario "for an existing person" do
    person = FactoryGirl.create(:person, nick: "matt")
    person.points.create value: 1, created_at: 1.year.ago
    person.points.create value: 2, created_at: Time.zone.now.beginning_of_month
    person.points.create value: 3, created_at: Time.zone.now.beginning_of_week
    person.points.create value: 4, created_at: Time.zone.now - 1.day
    person.points.create value: 5

    visit "/people/matt"
    expect(page.status_code).to be 200
    expect(json_response["person"]["nick"]).to eq "matt"
    expect(json_response["person"]["lifetime_points"]).to be
    expect(json_response["person"]["monthly_points"]).to be
    expect(json_response["person"]["weekly_points"]).to be
    expect(json_response["person"]["daily_points"]).to be
  end

  scenario "is not case sensitive" do
    person = FactoryGirl.create(:person, nick: "matt")
    person.points.create value: 1, created_at: 1.year.ago
    person.points.create value: 2, created_at: Time.zone.now.beginning_of_month
    person.points.create value: 3, created_at: Time.zone.now.beginning_of_week
    person.points.create value: 4, created_at: Time.zone.now - 1.day
    person.points.create value: 5

    visit "/people/matt"
    expect(page.status_code).to be 200
    expect(json_response["person"]["nick"]).to eq "matt"

    visit "/people/MaTT"
    expect(page.status_code).to be 200
    expect(json_response["person"]["nick"]).to eq "matt"
  end

end
