class Log < ActiveRecord::Base
  # RELATIONS #
  belongs_to :report
  belongs_to :author, class_name: 'User'

  # SCOPE #
  default_scope -> { order :created_at }

  # INSTANCE METHODS #
  def broadcast
    message_sent = false
    report.accepted_responders.each do |responder|
      Message.send(body, to: responder.phone) && message_sent = true
    end
    self.update_attribute(:sent_at, Time.now) if message_sent
  end

  def broadcasted?
    sent_at.present?
  end
end
