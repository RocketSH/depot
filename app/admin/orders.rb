ActiveAdmin.register Order do
  permit_params do
    permitted = [:name, :address, :email, :pay_type, :user_id]

    case permitted[3]
    when 1
      permitted << [:credit_card_number, :expiration_date]
    when 0
      permitted << [:routing_number, :account_number]
    when 2
      permitted << [:po_number]
    else
      []
    end
    permitted
  end
end
