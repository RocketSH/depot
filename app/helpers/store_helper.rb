module StoreHelper
  def session_counter_greater_than_five(counter)
    if counter && counter > 5
      "You have accessed this page: #{pluralize(counter, 'time')}"
    end
  end
end
