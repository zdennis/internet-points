class PointsController < ApplicationController
  def index
    person = find_person.first_or_initialize
    render json: person.points
  end

  def create
    person = find_person.first_or_create!
    points = person.points.create!(
      value: permitted_params[:points],
      message: permitted_params[:message])
    render json: points
  end

  private

  def permitted_params
    @permitted_params ||= params.permit(:person_id, :points, :message)
  end

  def find_person
    @person ||= Person.where(nick: permitted_params[:person_id].downcase)
  end
end
