def consolidate_cart(cart)
  new_cart = {}
  cart.each do |hash|
    hash.each do |name, describe| 
      if new_cart[name]
        new_cart[name][:count] += 1
      else
        new_cart[name] = describe
        new_cart[name][:count] = 1 
      end
    end
  end
  new_cart
end
end

def apply_coupons(cart, coupons)
   hash = cart
  coupons.each do |coupon_hash|
    item = coupon_hash[:item]

    if !hash[item].nil? && hash[item][:count] >= coupon_hash[:num]
      temp = {"#{item} W/COUPON" => {
        :price => coupon_hash[:cost],
        :clearance => hash[item][:clearance],
        :count => 1
        }
      }
      
      if hash["#{item} W/COUPON"].nil?
        hash.merge!(temp)
      else
        hash["#{item} W/COUPON"][:count] += 1
      end
      
      hash[item][:count] -= coupon_hash[:num]
    end
  end
  hash
end

def apply_clearance(cart)
 cart.each do |item, price_hash|
    if price_hash[:clearance] == true
      price_hash[:price] = (price_hash[:price] * 0.8).round(2)
    end
  end
  cart
end

def checkout(cart, coupons)
    cart = consolidate_cart(items)
  cart1 = apply_coupons(cart, coupons)
  cart2 = apply_clearance(cart1)
  
  total = 0
  
  cart2.each do |name, price_hash|
    total += price_hash[:price] * price_hash[:count]
  end
  
  total > 100 ? total * 0.9 : total
end
