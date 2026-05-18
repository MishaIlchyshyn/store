class ProductMailer < ApplicationMailer
  def in_stock
    @product = params[:product]
    @subscriber = params[:subscriber]

    mail to: @subscriber.email, subject: "The product #{@product.name} is back in stock!"
  end
end
