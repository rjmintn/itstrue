class ChargesController < ApplicationController
  def create
    customer = Stripe::Customer.create(
      email: current_user.email,
      card: params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      customer: customer.id,
      amount: 1000,
      description: "BigMoney Membership - #{current_user.email}",
      currency: 'usd'
    )

    current_user.update_attribute(:role, "premium") if charge.paid?

    puts current_user.role

      flash[:notice] = "Thanks for all the money, #{current_user.email}! Feel free to pay me again. "
      redirect_to new_charge_path(current_user)

      #Stripe::Carderror! {self.role = :premium}

    rescue Stripe::CardError => e
      flash[:alert] = e.message
      redirect_to new_charge_path
  end

  def new
    @stripe_btn_data = {
      key: "#{ Rails.configuration.stripe[:publishable_key] }",
      description: "BigMoney Membership = #{current_user.email}",
      amount: 1000
    }
  end

  def downgrade
    current_user.update_attribute(:role, "standard")
  end
end
