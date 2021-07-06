def consolidate_cart(cart)
  newCart = {}
  cart.each do |itemHash|
    itemHash.each do |item, descriptionHash| 
      if newCart.include?(item) == false
        newCart[item] = descriptionHash
        newCart[item][:count] = 1
      else
        newCart[item][:count] += 1
      end
    end
  end
  return newCart
end

def apply_coupons(cart, coupons) 
  coupons.each do |couponHash| 
    item = couponHash[:item] 
    if cart.include?(item) && cart[item][:count] >= couponHash[:num] 
      cart[item][:count] = cart[item][:count] - couponHash[:num] 
      if cart.include?(item + " W/COUPON")
        cart[item + " W/COUPON"][:count] += couponHash[:num] 
      else 
        newPrice = couponHash[:cost]/couponHash[:num]
        cart[item + " W/COUPON"] = {:price => newPrice, 
        :clearance => cart[item][:clearance], :count => couponHash[:num]} 
      end 
    end 
  end 
  return cart 
end

def apply_clearance(cart)
  cart.each do |item, priceHash|
    if priceHash[:clearance] == true
      priceHash[:price] -= (priceHash[:price] * 0.2)
      priceHash[:price] = priceHash[:price].round(2)
    end
  end
  return cart
end

def checkout(items, coupons)
  colsolidatedCart = consolidate_cart(items)
  couponedCart = apply_coupons(colsolidatedCart, coupons)
  finalCart = apply_clearance(couponedCart)
  
  priceTotal = 0
  finalCart.each do |name, priceHash|
    priceTotal += priceHash[:price] * priceHash[:count]
  end
  
  if priceTotal > 100 
    priceTotal-= priceTotal * 0.1
  end
  
  return priceTotal 
end
