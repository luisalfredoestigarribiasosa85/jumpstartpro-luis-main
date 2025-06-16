class ActiveStorage::BlobResource < Madmin::Resource
  # Attributes
  attribute :id, form: false
  attribute :key
  attribute :filename
  attribute :content_type
  attribute :byte_size
  attribute :checksum
  attribute :created_at, form: false
  attribute :service_name
  attribute :analyzed
  attribute :identified
  attribute :composed
  attribute :preview_image, index: false

  # Associations
  attribute :attachments
  attribute :variant_records

  # Add scopes to easily filter records
  # scope :published

  # Add actions to the resource's show page
  # member_action do |record|
  #   link_to "Do Something", some_path
  # end

  # Customize the display name of records in the admin area.
  # def self.display_name(record) = record.name

  # Customize the default sort column and direction.
  # def self.default_sort_column = "created_at"
  #
  # def self.default_sort_direction = "desc"
end
