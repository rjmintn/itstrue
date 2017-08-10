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

    # If stripe transaction completes, charge is returned
    # charge.paid is a boolean on success of payment processing
    current_user.update_attribute(:role, "premium") if charge.paid?

    #puts current_user.role

      flash[:notice] = "Thanks for all the money, #{current_user.email}! Feel free to pay me again. "
      redirect_to new_charge_path(current_user)

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

  # downgrades user account when hitting this page.
  # not a great solution since someone can just type
  # the page link and downgrade the account
  def edit
    user = current_user
    user.update_attribute(:role, "standard")
  end
end
