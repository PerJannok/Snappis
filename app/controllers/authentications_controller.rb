def index
  @authentications = current_user.authentications if current_user
end

def create
#  auth = request.env["rack.auth"]
#  current_user.authentications.find_or_create_by_provider_and_uid(auth['provider'], auth['uid'])
  flash[:notice] = "authentications_controller successful."
#  redirect_to authentications_url
  #render :text => request.env["rack.auth"].to_yaml
end

def destroy
  @authentication = current_user.authentications.find(params[:id])
  @authentication.destroy
  flash[:notice] = "Successfully destroyed authentication."
  redirect_to authentications_url
end


