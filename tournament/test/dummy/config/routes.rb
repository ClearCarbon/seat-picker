Rails.application.routes.draw do

  mount Tournament::Engine => "/tournament"
end
