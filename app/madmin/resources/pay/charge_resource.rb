class Pay::ChargeResource < Madmin::Resource
  menu parent: "Payments", position: 3

  # Attributes
  attribute :id, form: false
  attribute :processor_id, index: true
  attribute :amount, index: true
  attribute :amount_refunded, index: true
  attribute :created_at, form: false
  attribute :updated_at, form: false
  attribute :application_fee_amount
  attribute :currency, index: true
  attribute :metadata
  attribute :stripe_account
  attribute :type
  attribute :payment_method_type
  attribute :brand
  attribute :last4
  attribute :exp_month
  attribute :exp_year
  attribute :email
  attribute :username
  attribute :bank
  attribute :subtotal
  attribute :tax

  # Associations
  attribute :customer
  attribute :subscription

  # Uncomment this to customize the display name of records in the admin area.
  # def self.display_name(record)
  #   record.name
  # end

  # Uncomment this to customize the default sort column and direction.
  # def self.default_sort_column
  #   "created_at"
  # end
  #
  # def self.default_sort_direction
  #   "desc"
  # end

  member_action do
    case @record.type
    when "Pay::Stripe::Charge"
      link_to "View on Stripe", ["https://dashboard.stripe.com", ("/test" if Pay::Stripe.public_key&.start_with?("pk_test")), "/payments/#{@record.processor_id}"].join, class: "btn btn-secondary", target: :_blank
    end
  end
end
