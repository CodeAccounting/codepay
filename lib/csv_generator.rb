class CsvGenerator

  # Initialize with the directory to zip and the location of the output archive.
  def initialize(data)
    @data = data
  end

  def invoice_to_csv(options = {})
  	 CSV.generate(options) do |csv|
      csv << [
        "id",
        "customer_name",
        "invoice_number",
        "invoice_date",
        "due_date",
        "due_amount",
        "payment_terms",
        "location",
        "department",
        "po_number",
        "sales_rep",
        "message",
        "created_at",
        "updated_at"
      ]
      @data.each do |invoice|
        csv << [
          invoice.id,
          invoice.customer.name,
          invoice.invoice_number,
          invoice.invoice_date.strftime("%d %B %Y"),
          invoice.due_date.strftime("%d %B %Y"),
          invoice.due_amount,
          invoice.payment_term.try(:name),
          invoice.location.try(:name),
          invoice.department.try(:name),
          invoice.po_number,
          invoice.sales_rep,
          invoice.message,
          invoice.created_at.strftime("%d %B %Y"),
          invoice.updated_at.strftime("%d %B %Y")
        ]
    	  end
     end 
  end

  def bill_to_csv(options = {})
     CSV.generate(options) do |csv|
      csv << [
        "id",
        "bill_number",
        "bill_date",
        "due_date",
        "due_amount",
        "payment_terms",
        "location",
        "department",
        "po_number",
        "sales_rep",
        "message",
        "status",
        "created_at",
        "updated_at"
      ]
      @data.each do |bill|
        csv << [
          bill.id,
          bill.bill_number,
          bill.bill_date,
          bill.due_date.strftime("%d %B %Y"),
          bill.due_amount,
          bill.payment_term.try(:name),
          bill.location.try(:name),
          bill.department.try(:name),
          bill.po_number,
          bill.sales_rep,
          bill.message,
          bill.paid,
          bill.created_at.strftime("%d %B %Y"),
          bill.updated_at.strftime("%d %B %Y")
        ]
        end
     end 
  end

  def unpaid_invoice_to_csv(options = {})
      @due_not_passed_invoices = @data.where("due_date > ?", Date.today)
      @due_passed_30_days_invoices = @data.where("due_date <= ? and due_date > ?", Date.today, (Date.today-30.days))
      @due_30_to_60_days_invoices = @data.where("due_date <= ? and due_date > ?", (Date.today-30.days), (Date.today-60.days))
      @due_60_to_90_days_invoices = @data.where("due_date <= ? and due_date > ?", (Date.today-60.days), (Date.today-90.days))
      @due_above_90_invoices = @data.where("due_date <= ?", (Date.today-90.days))

     CSV.generate(options) do |csv|
      csv << [" ","  <---","----------","---------","Invoices","Not","Due","Yet","----------       ", "----------         ","-----------  ","-----------  ","------->   "]
      csv << []
      csv << [
        "id",
        "customer_name",
        "invoice_number",
        "invoice_date",
        "due_date",
        "due_amount",
        "payment_terms",
        "location",
        "department",
        "po_number",
        "sales_rep",
        "message",
        "created_at",
        "updated_at"
      ]
      @due_not_passed_invoices.each do |invoice|
        csv << [
          invoice.id,
          invoice.customer.name,
          invoice.invoice_number,
          invoice.invoice_date.strftime("%d %B %Y"),
          invoice.due_date.strftime("%d %B %Y"),
          invoice.due_amount,
          invoice.payment_term.try(:name),
          invoice.location.try(:name),
          invoice.department.try(:name),
          invoice.po_number,
          invoice.sales_rep,
          invoice.message,
          invoice.created_at.strftime("%d %B %Y"),
          invoice.updated_at.strftime("%d %B %Y")
        ]
      end
      csv << []
      csv << []
      csv << [" ","  <---", "----------","---------","Invoices","under","30","days","past", "due","----------", "----------","---->   "]
      csv << []
      csv << [
        "id",
        "customer_name",
        "invoice_number",
        "invoice_date",
        "due_date",
        "due_amount",
        "payment_terms",
        "location",
        "department",
        "po_number",
        "sales_rep",
        "message",
        "created_at",
        "updated_at"
      ]
      @due_passed_30_days_invoices.each do |invoice|
        csv << [
          invoice.id,
          invoice.customer.name,
          invoice.invoice_number,
          invoice.invoice_date.strftime("%d %B %Y"),
          invoice.due_date.strftime("%d %B %Y"),
          invoice.due_amount,
          invoice.payment_term.try(:name),
          invoice.location.try(:name),
          invoice.department.try(:name),
          invoice.po_number,
          invoice.sales_rep,
          invoice.message,
          invoice.created_at.strftime("%d %B %Y"),
          invoice.updated_at.strftime("%d %B %Y")
        ]
      end
      csv << []
      csv << []
      csv << [" ","  <---","----------","---------","Invoices","30","to","60","days","past","due","----------","---->   "]
      csv << []
      csv << [
        "id",
        "customer_name",
        "invoice_number",
        "invoice_date",
        "due_date",
        "due_amount",
        "payment_terms",
        "location",
        "department",
        "po_number",
        "sales_rep",
        "message",
        "created_at",
        "updated_at"
      ]
      @due_30_to_60_days_invoices.each do |invoice|
        csv << [
          invoice.id,
          invoice.customer.name,
          invoice.invoice_number,
          invoice.invoice_date.strftime("%d %B %Y"),
          invoice.due_date.strftime("%d %B %Y"),
          invoice.due_amount,
          invoice.payment_term.try(:name),
          invoice.location.try(:name),
          invoice.department.try(:name),
          invoice.po_number,
          invoice.sales_rep,
          invoice.message,
          invoice.created_at.strftime("%d %B %Y"),
          invoice.updated_at.strftime("%d %B %Y")
        ]
      end
      csv << []
      csv << []
      csv << [" ","  <---","----------","---------","Invoices","60","to","90","days","past","due","----------","---->   "]
      csv << []
      csv << [
        "id",
        "customer_name",
        "invoice_number",
        "invoice_date",
        "due_date",
        "due_amount",
        "payment_terms",
        "location",
        "department",
        "po_number",
        "sales_rep",
        "message",
        "created_at",
        "updated_at"
      ]
      @due_60_to_90_days_invoices.each do |invoice|
        csv << [
          invoice.id,
          invoice.customer.name,
          invoice.invoice_number,
          invoice.invoice_date.strftime("%d %B %Y"),
          invoice.due_date.strftime("%d %B %Y"),
          invoice.due_amount,
          invoice.payment_term.try(:name),
          invoice.location.try(:name),
          invoice.department.try(:name),
          invoice.po_number,
          invoice.sales_rep,
          invoice.message,
          invoice.created_at.strftime("%d %B %Y"),
          invoice.updated_at.strftime("%d %B %Y")
        ]
      end
      csv << []
      csv << []
      csv << [" ","  <---","----------","---------","Invoices","above","90","days","past","due","----------", "----------","---->   "]
      csv << []
      csv << [
        "id",
        "customer_name",
        "invoice_number",
        "invoice_date",
        "due_date",
        "due_amount",
        "payment_terms",
        "location",
        "department",
        "po_number",
        "sales_rep",
        "message",
        "created_at",
        "updated_at"
      ]
      @due_above_90_invoices.each do |invoice|
        csv << [
          invoice.id,
          invoice.customer.name,
          invoice.invoice_number,
          invoice.invoice_date.strftime("%d %B %Y"),
          invoice.due_date.strftime("%d %B %Y"),
          invoice.due_amount,
          invoice.payment_term.try(:name),
          invoice.location.try(:name),
          invoice.department.try(:name),
          invoice.po_number,
          invoice.sales_rep,
          invoice.message,
          invoice.created_at.strftime("%d %B %Y"),
          invoice.updated_at.strftime("%d %B %Y")
        ]
      end
    end  
  end
  
end	