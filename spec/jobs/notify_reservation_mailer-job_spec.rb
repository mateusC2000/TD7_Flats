require 'rails_helper'

RSpec.describe NotifyReservationMailerJob, type: :job do
  it "should respond to #perform" do
    expect(NotifyReservationMailerJob.new).to respond_to(:perform)
  end

  describe 'NotifyReservationMailerJob' do
    # before do
    #   Sidekiq::Extensions.enable_delay!
    #   Sidekiq::Worker.clear_all
    # end

    it 'should enqueue a Email job' do
      reservation = create(:property_reservation)

      row = JSON.generate({ reservation_id: reservation.id})

      assert_equal 0, Sidekiq::Queues["default"].size
      NotifyReservationMailerJob.perform_async(row, 1)
      assert_equal 1, Sidekiq::Queues["default"].size
    end
  end
end