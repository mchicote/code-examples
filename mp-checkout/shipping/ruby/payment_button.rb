require 'rubygems'
require 'rack'
require 'mercadopago.rb'

class Button
	def call(env)
		mp = MercadoPago.new('CLIENT_ID', 'CLIENT_SECRET')
		preferenceData = {
			"items" => [
				[
					"title"=>"Multicolor kite",
					"quantity"=>1,
					"unit_price"=>10.0,
					"currency_id"=>"CURRENCY_ID", # Available currencies at: https://api.mercadopago.com/currencies
					"dimensions"=>"30x30x30,500"
				]
			],
			"shipments" => [
				"mode" => "me2",
				"local_pickup" => true,
				"free_methods" => [
					[
						"id" => 100009
					]
				]
			]
		}
		preference = mp.create_preference(preferenceData)

		html =  '<!doctype html>
				<html>
					<head>
						<title>Pay</title>
					</head>
					<body>
						<a href="' + preference['response']['init_point'] + '">Pay</a>
					</body>
				</html>'

		return [200, {'Content-Type' => 'text/html'}, [html]]
	end
end

Rack::Handler::WEBrick.run(Button.new, :Port => 9000)