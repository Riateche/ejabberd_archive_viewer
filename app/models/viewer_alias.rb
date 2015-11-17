class ViewerAlias < ActiveRecord::Base
  def self.to_alias(jid)
    ViewerAlias.where(jid:jid).first.try(:alias)
  end

  def self.to_jids(alias_)
    ViewerAlias.where("alias" => alias_).pluck('jid').sort
  end
end
