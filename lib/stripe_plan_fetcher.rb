# frozen_string_literal: true

class StripePlanFetcher
  def self.store_products_locally
    Stripe::Product.list.each do |product|
      if (local_product = Product.find_by(product: product.id))
        local_product.update(
          product: product.id,
          name: product.name
        )
      else
        Product.create(
          product: product.id,
          name: product.name
        )
      end
    end
  end

  def self.store_plans_locally
    Stripe::Plan.list.each do |plan|
      if (local_plan = Plan.find_by(product_id: plan.product))
        local_plan.update(
          amount: plan.amount,
          product_id: plan.product
        )
      else
        Plan.create(
          amount: plan.amount,
          product_id: plan.product
        )
      end
    end
  end
end
