class ConsigneeReport
  include ActiveModel::Model
  include ActiveModel::Validations

  mattr_accessor :row_ids, :columns
  attr_accessor :format, :monthly, :from, :to

  # validates_presence_of :row_ids, :columns, :format
  validates_presence_of :format
  validates_inclusion_of :format, in: ["pdf", "xls"]

  def filename
    tmp = "Consignees"
    tmp.upcase
  end

  def title
    tmp = "Consignees"
    tmp.upcase
  end

  def populate_data
    data = Consignee.with_custom_fields
    data
  end

  def template
    "consignee_report"
  end
end
