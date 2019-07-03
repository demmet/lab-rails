class WirecardController < ApplicationController
  skip_before_action :verify_authenticity_token

  def store
    puts "Webhook received:"
    puts "#{params}"

    if payment.present? && checkout_api.show_payment(payment_id).present?
      payment_id = params[:resource][:payment][:id]
      status = params[:resource][:payment][:status]

      payment = Payment.create(wirecard_id: payment_id)
    end
    
    render status: 200, json: @controller.to_json
  rescue => e
    render status: 422, json: @controller.to_json
  end

  def new
    @public_key = ENV["FAEL_WIRECARD_SANDBOX_PUBLIC_KEY"]
  end

  def create
    binding.pry
  end
end
