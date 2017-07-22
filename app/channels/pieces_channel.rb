class PiecesChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'pieces'
  end
end