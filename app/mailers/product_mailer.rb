class ProductMailer < ApplicationMailer
  def in_stock
    @product = params[:product]

    mail to: params[:subscriber].email, subject: "The product #{@product.name} is back in stock!"
  end
end
