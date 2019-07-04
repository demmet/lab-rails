class WirecardController < ApplicationController
  skip_before_action :verify_authenticity_token

  def store
    Rails.logger.info "Webhook received:"
    Rails.logger.info "#{params}"

    payment_id = params[:resource][:payment][:id]
    status = params[:resource][:payment][:status]

    payment = Payment.create(wirecard_id: payment_id, status: status)
    
    render status: 200, json: @controller.to_json
  rescue => e
    render status: 422, json: @controller.to_json
  end

  def new
    @public_key = ENV["WIRECARD_SANDBOX_PUBLIC_KEY"]
  end

  def create
    credit_card_data = {
      card_hash: params["card_hash"],
      card_holder_name: params["card_holder_name"],
      birthdate: params["birthdate_input"],
      card_holder_cpf: params["cpf_input"]
    }

    response = CheckoutService.new.create_wirecard_payment(credit_card_data)
    redirect_to action: :new
  end
end
