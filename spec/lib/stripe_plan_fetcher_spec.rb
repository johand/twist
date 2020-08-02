# frozen_string_literal: true

require 'rails_helper'
require 'stripe_plan_fetcher'

describe StripePlanFetcher do
  let(:product) { FactoryBot.create(:product) }
  let(:plan) { FactoryBot.create(:plan) }

  it 'fetches and stores products' do
    expect(Stripe::Product).to receive(:list).and_return([product])
    expect(Product).to receive(:find_by).with(product: product.product)
    expect(Product).to receive(:create).with({
                                               product: product.product,
                                               name: product.name
                                             })

    StripePlanFetcher.store_products_locally
  end

  it 'fetches and stores plans' do
    expect(Stripe::Plan).to receive(:list).and_return([plan])
    expect(Plan).to receive(:find_by).with(product_id: plan.product)
    expect(Plan).to receive(:create).with({
                                            amount: plan.amount,
                                            product_id: product
                                          })

    StripePlanFetcher.store_plans_locally
  end

  it 'checks and updates products' do
    expect(Stripe::Product).to receive(:list).and_return([product])
    expect(Product).to receive(:find_by).with(product: product.product).and_return(product)

    expect(product).to receive(:update).with({ product: product.product, name: product.name })
    expect(Product).to_not receive(:create)
    StripePlanFetcher.store_products_locally
  end

  it 'checks and updates plans' do
    expect(Stripe::Plan).to receive(:list).and_return([plan])
    expect(Plan).to receive(:find_by).with(product_id: plan.product).and_return(plan)

    expect(plan).to receive(:update).with({ amount: plan.amount, product_id: plan.product })
    expect(Plan).to_not receive(:create)
    StripePlanFetcher.store_plans_locally
  end
end
