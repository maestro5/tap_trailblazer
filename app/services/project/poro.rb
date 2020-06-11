# paginating Projects collection

class Project::Poro
  VALID_ORDERS      = %w(asc desc)
  VALID_SORT_ATTRS  = %w(id name type)

  DEFAULT_ORDER     = 'asc'
  DEFAULT_SORT_ATTR = 'id'

  attr_reader :records, :options, :sort_attr, :order

  def self.call(*args)
    new(*args).call
  end

  def initialize(records, options = {})
    @records   = records
    @options   = options
    @sort_attr = options['sort_attr']&.downcase
    @order     = options['order']&.downcase
  end

  def call
    records.offset(offset).limit(per).order(order_string)
  end

  private

  def page
    page  = options['page'].to_i

    page < 0 ? 1 : page
  end

  def per
    per  = options['per'].to_i

    per <= 0 ? nil : per
  end

  def offset
    return unless page && per

    (page - 1) * per
  end

  def sort_attribute
    VALID_SORT_ATTRS.include?(sort_attr) ? sort_attr : DEFAULT_SORT_ATTR
  end

  def order_direction
    VALID_ORDERS.include?(order) ? order : DEFAULT_ORDER
  end

  def order_string
    "#{sort_attribute} #{order_direction}"
  end
end
