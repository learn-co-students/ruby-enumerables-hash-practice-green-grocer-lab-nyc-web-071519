def consolidate_cart(cart)
  organized_cart = {}
  count = 0 
  
  cart.each do |elem| 
    elem.each do |fruit, hash|
      organized_cart[fruit] ||= hash
      organized_cart[fruit][:count] ||= 0 
      organized_cart[fruit][:count] += 1 
    end 
  end 
  return organized_cart 
end

def apply_coupons(cart, coupons)
    result = {}
    cart.each do |food, info|
    coupons.each do |coupon|
      if food == coupon[:item] && info[:count] >= coupon[:num]
        info[:count] =  info[:count] - coupon[:num]
        
        if result["#{food} W/COUPON"]
          result["#{food} W/COUPON"][:count] += 1
        else
          result["#{food} W/COUPON"] = {:price => coupon[:cost], :clearance => info[:clearance], :count => 1}
        end
      end
    end
    result[food] = info
  
  result
end

def apply_clearance(cart)
   cart.each do |item, price_hash|
    if price_hash[:clearance] == true
      price_hash[:price] = (price_hash[:price] * 0.8).round(2)
    end
  end
  
end

def checkout(cart, coupons)
  consolidated_cart = consolidate_cart(cart)
end
