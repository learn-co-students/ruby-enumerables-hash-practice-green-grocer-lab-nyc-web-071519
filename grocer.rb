#created a method that takes an array of hashes as a parameter
def consolidate_cart(cart)
  #create an empty hash for the updated cart
  my_cart = {}
#iterate over the cart to create the new hash
  cart.each do |hash|
#create a keys variable == to the cart's item names(keys)
    keys = hash.keys
#iterate over the keys
      keys.each do |k|
#create a variable for the values of each key
      v = hash[k]
#create a variable == the item
      my_cart_item_value = my_cart[k]
#conditional, if the item == nil
        if my_cart_item_value.nil?
#then add a value of 1 to a new value called :count
          v[:count] = 1
#sets the item in the updated cart == to the value
          my_cart[k] = v
        else
#if there is an item already in the cart, increment the :count value by 1
          v[:count] = my_cart_item_value[:count] + 1
#sets the item in the updated cart == to the value
          my_cart[k] = v
        end
#output "items: values"
        puts "#{k}: #{my_cart[k]}"
      end
    end
#return cart
    my_cart
  end


#created a method that takes 2 arrays of hashes
  def apply_coupons(cart, coupons)
#iterate over the coupons array
    coupons.each do |coupon|
#conditional: if any of the keys of items in the cart array == item in the coupon array
      if cart.keys.any? coupon[:item]
#secondary-conditional: if the cart/coupon :count value is greater than or equal to the coupon :num value
        if cart[coupon[:item]][:count] >= coupon[:num]
#then create a variable within the cart array for the discounted product which is == :item within the coupons array
          discounted_product = "#{coupon[:item]} W/COUPON"
#tertiary condiitonal: if there is a discounted product within the cart array
          if cart[discounted_product]
#then the :count value of the discounted product is added from the coupon :num value
            cart[discounted_product][:count] += coupon[:num]
          else
#otherwise, the discounted product's values within the cart array are == to the following
            cart[discounted_product] = {
            #count: is == the corresponding coupon's :num value
              count: coupon[:num],
            #price: is == the corresponding coupon's :cost value divided by the coupon's :num value
              price: coupon[:cost]/coupon[:num],
            #clearance: is added from the cart array's item value :clearance
              clearance: cart[coupon[:item]][:clearance]
            }
          end
#Finally, if coupon was applied to an item(s) reduce the item's :count value by the coupon's :num v
          cart[coupon[:item]][:count] -= coupon[:num]
        end
      end
    end
#return cart
    cart
end

#create a method that takes in an array of items
def apply_clearance(cart)
#create a variable == to cart
  my_cart = cart
#iterate over the new cart array
  my_cart.each do |key,value|
#conditional: if an item within the new cart of arrays has a :clearance value
    if my_cart[key][:clearance]
#update the item's price by multiplying by .8 then rounding the decimal to the second spot
      my_cart[key][:price] = (my_cart[key][:price] * 0.8).round(2)
    end
  end
#return cart
  my_cart
end


def checkout(cart, coupons)
  #created a variable - my_cart == to calling the consolidated_cart method on the cart array
    my_cart = consolidate_cart(cart)
  #created the variable coupon_cart set == the apply_coupons methods taking in my_cart and the coupons array
      coupon_cart = apply_coupons(my_cart, coupons)
    #created the variable clearance_cart == the apply_clearance method taking in the coupon_cart array
        clearance_cart = apply_clearance(coupon_cart)
      #created a variable - total == 0.0
        total = 0.0
        #iterating over the keys of the clearance_cart array
        clearance_cart.keys.each do |item|
        #total = the sum of the clearance_cart value :price mutliplied by the same arrays :count value
        total += clearance_cart[item][:price] * clearance_cart[item][:count]
    #Conditional: If the total amounts to over 100
    if total > 100
      #then the total will be multiplied by 0.9(10%)
      total = total * 0.9
    end
    end
  #return total
  total
end
