class CancelAccountForm < Form
  include Virtus.model

  attribute :password, String
end
