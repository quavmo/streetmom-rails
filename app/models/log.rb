class Log < ActiveRecord::Base
  # RELATIONS #
  belongs_to :report
  belongs_to :author, class_name: 'User'

  # CALLBACKS #
  after_commit :refresh_report

  # SCOPE #
  default_scope -> { order :created_at }

  # INSTANCE METHODS #
  def broadcast
    message_sent = false

    report.accepted_responders.each do |responder|
      Telephony.send(body, responder.phone) && message_sent = true
    end

    update_attribute(:sent_at, Time.now) if message_sent
  end

  def broadcasted?
    sent_at.present?
  end

private

  def refresh_report
    Pusher.trigger("report-#{report.id}", "message", {'inner_html' => LogPresenter.new(self).inner_html, 'id' => self.id})
  end

end
