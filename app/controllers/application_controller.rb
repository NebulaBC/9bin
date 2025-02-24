include ERB::Util
class ApplicationController < ActionController::Base
  allow_browser versions: :modern
  skip_before_action :verify_authenticity_token

  def index
    @uuid = helpers.generate_unique_key()
  end

  def about
  end

  def view
    key = params[:slug].upcase
    if !REDIS.exists?(key)
      render json: { error: "This key does not exist" }, status: :not_found
      return
    end
    @slug = key
    @contents = REDIS.get(key)
  end

  def raw
    key = params[:slug].upcase
    if !REDIS.exists?(key)
      render json: { error: "This key does not exist" }, status: :not_found
      return
    end
    @contents = REDIS.get(key)
    render :layout => false
  end

  def create
    body = request.raw_post
    if body.blank?
      render json: { error: "Request body cannot be empty" }, status: :unprocessable_entity
      return
    end
    @slug = helpers.generate_unique_key()
    REDIS.set(@slug, body)
    render json: { key: @slug.downcase }, status: :created
  end

end
