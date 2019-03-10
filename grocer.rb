def consolidate_cart(cart)
  cart.each_with_object({}) {|item, result|
  item.each{|type, attribute|
    if result[type]
      attribute[:count] +=1
    else
      attribute[:count] =1
      result[type] = attribute
    end}}
end

def apply_coupons(cart, coupons)
  coupons.each{|coupon|
  name = coupon[:item]
    if cart[name] && cart[name][:count] >= coupon[:num]
      if cart["#{name} W/COUPON"]
      cart["#{name} W/COUPON"][:count] += 1
      else
        cart["#{name} W/COUPON"] = {:price => coupon[:cost], :count => 1}
        cart["#{name} W/COUPON"][:clearance] = cart[name][:clearance]
      end
    cart[name][:count] -= coupon[:num]
  end}
  cart
end

def apply_clearance(cart)
  cart.each{|item, attribute|
  if attribute[:clearance]
  attribute[:price] = (attribute[:price] * 0.8).round(2)
end}
end

def checkout(cart, coupons)
  consolidated_cart = consolidate_cart(cart)
  couponed_cart = apply_coupons(consolidated_cart, coupons)
  cleared_cart = apply_clearance(couponed_cart)
  total = 0
  cleared_cart.each{|item, attribute|
    total = total + attribute[:price] * attribute[:count]}
  if total > 100
    total = total * 0.9
  else
  total
  end
end