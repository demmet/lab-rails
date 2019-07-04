class CheckoutService
  def create_wirecard_payment(credit_card_data)
    checkout_api = Checkout::Wirecard::Api.new

    order_hash = checkout_api.create_order_with_hash(create_order_hash)

    payment_hash = create_credit_card_hash(credit_card_data)

    payment_response = checkout_api.create_payment_with_hash order_hash[:id], payment_hash

    save_payment_data payment_response
  rescue => e
    e
  end

  def create_order_hash
    {
      id: 1,
      items: [
        { product: 'Testing Payment Refund', quantity: 1, price: 1.0 }
      ],
      customer: {
        id: 1,
        full_name: 'Testing Payment Refund',
        email: 'test@test.com',
        tax_document: {
          type: 'CPF',
          number: '384.413.020-90',
        },
        shipping_address: {
          zip_code: '80250-104',
          street: 'Rua Pasteur',
          street_number: '463',
          city: 'Curitiba',
          district: 'Batel',
          state: 'PR',
          complement: 'Sala 602'
        },
        phone: {
          area_code: "41",
          number: "99999999"
        }
      }
    }
  end

  def create_credit_card_hash(credit_card_data)
    {
      statement_descriptor: "Refund",
      installment_count: 1,
      funding_instrument: {
        credit_card: {
          hash: credit_card_data[:card_hash],
          holder: {
            fullname: credit_card_data[:card_holder_name],
            birthdate: credit_card_data[:birthdate],
            tax_document: {
              type: "CPF",
              number: credit_card_data[:card_holder_cpf].tr('^0-9', '')
            }
          }
        }
      }
    }
  end

  def save_payment_data(payment_response)
    return nil unless payment_response.present? && payment_response[:id].present?
    Payment.create(status: payment_response[:status], wirecard_id: payment_response[:id])
  end
end