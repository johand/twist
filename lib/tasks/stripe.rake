# frozen_string_literal: true

require 'stripe_plan_fetcher'

desc 'Import plans from Stripe'
task import_plans: :environment do
  StripePlanFetcher.store_products_locally
  StripePlanFetcher.store_plans_locally
end
