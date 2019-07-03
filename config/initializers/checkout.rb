require 'checkout'

Checkout.configure do |c|
  c.wirecard = {
    key: ENV['WIRECARD_SANDBOX_KEY'],
    token: ENV['WIRECARD_SANDBOX_TOKEN'],
    webhook_url: "#{ENV['ROOT_URL'] || ENV['LOCAL_ROOT_URL']}/wirecard/webhook",
    env: :development
  }
end