# frozen_string_literal: true
ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: proc { I18n.t("active_admin.dashboard") } do
    columns do
      column do
        panel "Recent Orders" do
          ul do
            Order.last(10).map do |order|
              li link_to(order.name, admin_order_path(order))
            end
          end
        end
      end

      column do
        panel "Lastest Products" do
          ul do
            Product.last(10).map do |product|
              li link_to(product.title, admin_order_path(product))
            end
          end
        end
      end

      column do
        panel "New Sign-up User" do
          ul do
            User.last(10).map do |user|
              li link_to(user.email, admin_order_path(user))
            end
          end
        end
      end
    end
  end # content
end
