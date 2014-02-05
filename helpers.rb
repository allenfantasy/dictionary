module ApplicationHelper
  def authenticated?(params)
    if params[:nonce].nil? or params[:timestamp].nil? or params[:signature].nil?
      false
    else
      params[:signature] == Digest::SHA1.hexdigest([TOKEN, params[:nonce], params[:timestamp]].sort.join)
    end
  end
end
