namespace :wirecard do
  task :create_webhook => :environment do
    @wirecard = Checkout::Wirecard::Api.new

    events = ['PAYMENT.*']

    wirecard_webhook = @wirecard.setup_webhook_base events
    puts "Webhook token: #{wirecard_webhook["token"]}"
  end

  task :list_webhook => :environment do
    @wirecard = Checkout::Wirecard::Api.new
    wirecard_webhooks = @wirecard.list_webhooks
    puts wirecard_webhooks
  end

  task :remove_webhook => :environment do
    @wirecard = Checkout::Wirecard::Api.new
    url = ENV['LOCAL_ROOT_URL']

    events = ["ORDER.*", "PAYMENT.*", "MULTIORDER.*", "MULTIPAYMENT.*"]

    webhook = Checkout::Wirecard::Webhook.new(
       url,
       events
    )

    wirecard_webhooks = @wirecard.remove_webhook webhook
    puts wirecard_webhooks
  end

  task :remove_all_webhooks => :environment do
    wirecard = Checkout::Wirecard::Api.new
    wirecard_webhooks = wirecard.list_webhooks
    
    puts "Removing all webhooks..."
    wirecard_webhooks.each do |webhook_hash|
      webhook = Checkout::Wirecard::Webhook.new(
        webhook_hash["target"],
        webhook_hash["events"]
      )

      wirecard.remove_webhook webhook
      puts "The webhook { target=\"#{webhook_hash["target"]}\", events=\"#{webhook_hash["events"]}\" } was removed."
    end
    puts "All webhooks were removed."
  end
end
