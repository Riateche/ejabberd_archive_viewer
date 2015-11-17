class MainController < ApplicationController
  def index
    @jids = Collection.where(us: Rails.application.secrets.jabber_user).pluck('with_user, with_server')
                .uniq
                .map{ |row| row.join("@") }
                .map{ |jid| ViewerAlias.to_alias(jid) || jid }
                .uniq
                .sort
    p @jids
  end

  def view_history
    find_messages
    per_page = 200
    page = params[:page] || [((@messages.count - 1) / per_page) + 1, 1].max
    @messages = @messages.paginate(page: page, per_page: per_page)
  end

  def set_alias
    ViewerAlias.where(jid: params[:jid]).delete_all
    ViewerAlias.create!(jid: params[:jid], alias: params[:alias])
    redirect_to root_path, notice: 'Renamed.'
  end

  def search
    find_messages
    @messages = @messages.to_a.select{ |m| m.body.include?(params[:query])}
  end

  private

  def find_messages
    @alias = params[:alias]
    @jids = ViewerAlias.to_jids(@alias)
    @jids = [@alias] unless @jids.any?
    collections = @jids.map { |jid |
      jid_parts = jid.split('@')
      if jid_parts.count != 2
        raise ActionController::RoutingError.new('invalid jid')
      end
      Collection.where(
          us: Rails.application.secrets.jabber_user,
          with_user: jid_parts[0],
          with_server: jid_parts[1]
      ).pluck('id')
    }.flatten

    @messages = Message.where(coll_id: collections).order('id')
  end


end
