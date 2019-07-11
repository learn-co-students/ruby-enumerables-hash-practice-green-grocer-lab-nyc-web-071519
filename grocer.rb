def consolidate_cart(cart)
  organized_cart = {}
   count = 0
   cart.each do |element|
     element.each do |fruit, hash|
       organized_cart[fruit] ||= hash
       organized_cart[fruit][:count] ||= 0
       organized_cart[fruit][:count] += 1
     end
   end
   return organized_cart
end

def apply_coupons(cart, coupons)
  return cart if coupons == []

  new_cart = cart

  coupons.each do |coupon|
    name = coupon[:item]
    num_of_c = coupon[:num]
    if cart.include?(name) && cart[name][:count] >= num_of_c
       new_cart[name][:count] -= num_of_c
       if new_cart["#{name} W/COUPON"]
         new_cart["#{name} W/COUPON"][:count] += 1
       else
         new_cart["#{name} W/COUPON"] = {
           :price => coupon[:cost],
           :clearance => new_cart[name][:clearance],
           :count => 1
         }
       end
     end
   end
   new_cart
end

def apply_clearance(cart)
  new_cart = cart
  cart.each do |name, hash|
     if hash[:clearance]
       new_cart[name][:price] = (cart[name][:price] * 0.8).round(2)
     end
 end
 new_cart
end

def checkout(cart, coupons)
  def checkout(cart, coupons)
  new_cart = consolidate_cart(cart)
  apply_coupons(new_cart, coupons)
  apply_clearance(new_cart)

total = 0
  new_cart.each do |name, hash|
    total += (hash[:price] * hash[:count])
  end

if total >= 100
    total *= 0.9
  end

  total
end
