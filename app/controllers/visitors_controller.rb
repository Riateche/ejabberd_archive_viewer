class VisitorsController < ApplicationController
  def index
    @jids = Collection.pluck('with_user, with_server').uniq.map{ |row| row.join("@") }.sort
  end

  def view_history
    jid_parts = params[:jid].split('@')
    if jid_parts.count != 2
      raise ActionController::RoutingError.new('invalid jid')
    end
    collections = Collection.where(with_user: jid_parts[0], with_server: jid_parts[1]).pluck('id')
    @messages = Message.where(coll_id: collections).order('id')
    per_page = 200
    page = params[:page] || [((@messages.count - 1) / per_page) + 1, 1].max
    @messages = @messages.paginate(page: page, per_page: per_page)
  end
end
