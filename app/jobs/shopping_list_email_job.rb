class ShoppingListEmailJob < ApplicationJob
  queue_as :mailers

  def perform(*args)
    # Do something later
    today = Date.today.strftime('%A').downcase
    puts "Today is #{today}"

    if today == 'sunday'
      shopping_lists = ShoppingList.where(receive_email: true, receive_email_day: today).or(ShoppingList.where(receive_email: true, receive_email_day: nil))
    else
      shopping_lists = ShoppingList.where(receive_email: true, receive_email_day: today)
    end

    shopping_lists.each do |s|
      if s.user.blocked == false
        ShoppingListMailer.send_shopping_list(s.user, s.shopping_note).deliver_later
      end
    end
  end
end