require 'test_helper'

class ProductTest < ActiveSupport::TestCase
	fixtures :products

	test "product attributes must not be empty" do 
		product = Product.new
		assert product.invalid?
		assert product.errors[:title].any?
		assert product.errors[:description].any?
		assert product.errors[:price].any?
	end


	##########################
	# price
	##########################

	test "product price must be positive" do
		product = Product.new(
			title: "My Book Title",
			description: "foo!",
			image_url: "bar.jpg" ) 
					product.price = -1 #set an invalid price
					assert product.invalid?
					assert_equal ["must be greater than or equal to 0.01"],
					product.errors[:price]

	 	product.price = 0 #set an invalid price
	 	assert product.invalid?
	 	assert_equal ["must be greater than or equal to 0.01"],
	 	product.errors[:price]

	 	product.price = 1 #set a valid price
	 	assert product.valid?
	 end

	##########################
	# image_url
	##########################

	def new_product(image_url) 
		Product.new(
			title: "My Book Title",
			description: "yyy", 
			price: 1, 
			image_url: image_url)
	end

	test "image url" do
		ok = %w{ fred.gif fred.jpg fred.png FRED.JPG FRED.Jpg
			http://a.b.c/x/y/z/fred.gif }
		bad = %w{ fred.doc fred.gif/more fred.gif.more }

		ok.each do |name|
			assert new_product(name).valid?, "#{name} shouldn't be invalid"
		end
		bad.each do |name|
			assert new_product(name).invalid?, "#{name} shouldn't be valid"
		end 
	end

	##########################
	# title
	##########################
	test "product is not valid without a unique title" do
		product = Product.new(
			title: products(:ruby).title, # title is extracted from fixture row's title
			description: "foo bar baz",
			price: 1,
			image_url: "foo.gif"
			)	

		assert product.invalid?
		assert_equal [I18n.translate('activerecord.errors.messages.taken')], product.errors[:title]
	end

	test "title should be at least 10 characters long" do
		product = Product.new(
			title: "shorty!",
			description: "no way this will pass",
			price: 1,
			image_url: "foobar.png"
			)

		assert product.invalid?
		assert_equal ["is too short (minimum is 10 characters)"], product.errors[:title]
	end
end #class
