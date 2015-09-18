class PeopleController < ApplicationController
  def show
    person = find_person.first_or_initialize(nick: permitted_params[:id])
    render json: person
  end

  private

  def permitted_params
    @permitted_params ||= params.permit(:id)
  end

  def find_person
    @person ||= Person.where(nick: permitted_params[:id].downcase)
  end

end
