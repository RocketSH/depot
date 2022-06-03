ActiveAdmin.register Product do
  permit_params :title, :description, :price, :image_data
end
