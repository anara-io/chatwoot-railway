class Platform::Api::V1::UserApiKeysController < PlatformController
  def show
    @resource = User.find(params[:user_id])
    validate_platform_app_permissible
    render json: { api_key: @resource.access_token.token }
  end

  private

  def set_resource
    @resource = User.find(params[:user_id])
  end
end
