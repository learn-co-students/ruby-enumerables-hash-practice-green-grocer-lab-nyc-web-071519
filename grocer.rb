def consolidate_cart(cart)
  new_hash = Hash.new
  cart.each do |k, v|
    if !new_hash.include?(k)
      new_hash[k] = v
      new_hash.each do |dif_k, dif_v|
      dif_v[:count] = 1
      end
    else
      new_hash.each do |diff_k, diff_v|
        diff_v[:count] += 1
      end
    end
  end
  new_hash
end


def apply_coupons(cart, coupons)
  cart.each do |k, v|
    if coupons[:item] = k
      v[:price] = (coupons[:cost] / coupons[:num])
    end
  end
  cart
end

def apply_clearance(cart)
  cart.each do |k, v|
    if v[:clearance] = true
      v[:price] *= 0.80
    end
  end
  cart
end

def checkout(cart, coupons)
  sorted = consolidate_cart(cart)
  apply = apply_coupons(sorted, coupons)
  done = apply_clearance(apply)
  done
end
