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
  end
end
