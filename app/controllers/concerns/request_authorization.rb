module RequestAuthorization
  extend ActiveSupport::Concern

  included do
    before_action :fetch_authorization
  end

  private
    def fetch_authorization
      if authorization_id = session[:authorization_id]
        authorization = Authorization.includes(:user).find(authorization_id)
        if authorization
          Current.authorization = authorization
          Current.user = authorization.user
        end
      end
    end
end