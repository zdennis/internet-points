require 'rails_helper'

describe "Giving internet points to someone" do
  def json_response
    JSON.parse(page.body)
  end

  scenario "Pointing a non-existent person creates a new person in the process" do
    expect(Person.find_by_nick("zdennis")).to be nil

    page.driver.post "/people/zdennis/points/100"
    expect(page.status_code).to eq 200
    expect(json_response).to include("value" => 100)

    visit "/people/zdennis/points.json"
    expect(json_response.length).to eq(1)
    expect(json_response[0]).to include("value" => 100)
  end

  scenario "Pointing an existent person adds to their points" do
    person = FactoryGirl.create(:person, nick: "bob")
    page.driver.post "/people/bob/points/100"
    expect(page.status_code).to eq 200
  end

  scenario "Retrieving points for a non-existent person" do
    expect(Person.find_by_nick("zdennis")).to be nil

    visit "/people/zdennis/points.json"
    expect(page.status_code).to eq 200
    expect(json_response.empty?).to be true
  end

end
