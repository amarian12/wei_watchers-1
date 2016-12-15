class EventFilter < ActiveRecord::Base

  belongs_to :event, inverse_of: :event_filters
  belongs_to :filter, inverse_of: :event_filters

  validates :event, presence: true, uniqueness: { scope: [:filter] }
  validates :filter, presence: true

  after_create :log_event_with_subscriber


  private

  def log_event_with_subscriber
    filter.subscriber.event event_id
  end

end
