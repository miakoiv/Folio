class ActivityChannel < ApplicationCable::Channel
  def subscribed
    unit = Unit.find(params[:unit_id])
    stream_for unit
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
