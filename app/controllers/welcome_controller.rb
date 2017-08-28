class WelcomeController < ApplicationController
  def index
    @announcements = (Announcement.escalated(8).sort_by!(&:created_at).reverse + Announcement.desc(:created_at).limit(8).to_a).first(8).uniq
    # First 8 escalated announcements. If there aren't 8, we'll pad with the latest announcements and hopefully that'll make up for it.
    @links = Link.escalated(5).sort_by!(&:created_at)
  end

  def about
  end
end
