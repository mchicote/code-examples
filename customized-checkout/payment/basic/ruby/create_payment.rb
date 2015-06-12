require 'mercadopago.rb'

$mp = MercadoPago.new('ACCESS_TOKEN')

paymentData = Hash[
		"transaction_amount" => 100,
		"token" => "ff8080814c11e237014c1ff593b57b4d",
		"description" => "Title of what you are paying for",
		"installments" => 1,
		"payment_method_id" => "visa",
		"payer" => Hash[
			"email" => "test_user_19653727@testuser.com"
		]
	]

payment = $mp.post("/v1/payments", paymentData);

puts payment
