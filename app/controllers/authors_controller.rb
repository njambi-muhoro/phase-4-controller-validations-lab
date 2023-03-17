class AuthorsController < ApplicationController
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

  def show
    author = Author.find(params[:id])
    render json: author
  end

  def create
    author = Author.new(author_params)
    if author.save
      render json: author, status: :created
    else
      raise ActiveRecord::RecordInvalid.new(author)
    end
  end

  private

  def author_params
    params.permit(:email, :name)
  end

  def render_unprocessable_entity_response(exception)
    render json: { errors: exception.record.errors }, status: :unprocessable_entity
  end
end
