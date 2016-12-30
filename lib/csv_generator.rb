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

  def payments_to_csv(options = {})
     CSV.generate(options) do |csv|
      csv << [
        "vendor_name",
        "vendor_account",
        "bill_number",
        "due_date",
        "processed_date",
        "delivery_date",
        "amount",
        "payment_method",
        "check_number",
        "memo",
        "description"
      ]
      @data.each do |payment|
        csv << [
          payment.vendor_name,
          payment.vendor_account,
          payment.bill.bill_number,
          payment.try(:due_date).try(:strftime,"%d %B %Y"),
          payment.try(:processing_date).try(:strftime, "%d %B %Y"),
          payment.try(:delivery_date).try(:strftime,"%d %B %Y"),
          payment.try(:amount),
          payment.try(:payment_method),
          payment.try(:check_number),
          payment.try(:memo),
          payment.try(:description)
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
  
  def unpaid_bills_to_csv(options = {})
      @due_not_passed_bills = @data.where("due_date > ?", Date.today)
      @due_passed_30_days_bills = @data.where("due_date <= ? and due_date > ?", Date.today, (Date.today-30.days))
      @due_30_to_60_days_bills = @data.where("due_date <= ? and due_date > ?", (Date.today-30.days), (Date.today-60.days))
      @due_60_to_90_days_bills = @data.where("due_date <= ? and due_date > ?", (Date.today-60.days), (Date.today-90.days))
      @due_above_90_bills = @data.where("due_date <= ?", (Date.today-90.days))

     CSV.generate(options) do |csv|
      csv << [" ","  <---","----------","---------","Bills","due","date","not","passed", "yet","----------","---->   "]
      csv << []
      csv << [
        "Vendor_name",
        "Bill_number",
        "Bill_date",
        "Due_date",
        "Due_amount",
        "Payment_terms",
        "Location",
        "Department",
        "Po_number",
        "Sales_rep",
        "Message",
        "Created_at",
        "Updated_at"
      ]
      @due_not_passed_bills.each do |bill|
        csv << [
          bill.vendor.name,
          bill.bill_number,
          bill.bill_date.strftime("%d %B %Y"),
          bill.due_date.strftime("%d %B %Y"),
          bill.due_amount,
          bill.payment_term.try(:name),
          bill.location.try(:name),
          bill.department.try(:name),
          bill.po_number,
          bill.sales_rep,
          bill.message,
          bill.created_at.strftime("%d %B %Y"),
          bill.updated_at.strftime("%d %B %Y")
        ]
      end
      csv << []
      csv << []
      csv << [" ","  <---", "----------","---------","Bills","under","30","days","past", "due","----------","---->   "]
      csv << []
      csv << [
        "Vendor_name",
        "Bill_number",
        "Bill_date",
        "Due_date",
        "Due_amount",
        "Payment_terms",
        "Location",
        "Department",
        "Po_number",
        "Sales_rep",
        "Message",
        "Created_at",
        "Updated_at"
      ]
      @due_passed_30_days_bills.each do |bill|
        csv << [
          bill.vendor.name,
          bill.bill_number,
          bill.bill_date.strftime("%d %B %Y"),
          bill.due_date.strftime("%d %B %Y"),
          bill.due_amount,
          bill.payment_term.try(:name),
          bill.location.try(:name),
          bill.department.try(:name),
          bill.po_number,
          bill.sales_rep,
          bill.message,
          bill.created_at.strftime("%d %B %Y"),
          bill.updated_at.strftime("%d %B %Y")
        ]
      end
      csv << []
      csv << []
      csv << [" ","  <---","----------","---------","Bills","30","to","60","days","past","due","---->   "]
      csv << []
      csv << [
        "Vendor_name",
        "Bill_number",
        "Bill_date",
        "Due_date",
        "Due_amount",
        "Payment_terms",
        "Location",
        "Department",
        "Po_number",
        "Sales_rep",
        "Message",
        "Created_at",
        "Updated_at"
      ]
      @due_30_to_60_days_bills.each do |bill|
        csv << [
          bill.vendor.name,
          bill.bill_number,
          bill.bill_date.strftime("%d %B %Y"),
          bill.due_date.strftime("%d %B %Y"),
          bill.due_amount,
          bill.payment_term.try(:name),
          bill.location.try(:name),
          bill.department.try(:name),
          bill.po_number,
          bill.sales_rep,
          bill.message,
          bill.created_at.strftime("%d %B %Y"),
          bill.updated_at.strftime("%d %B %Y")
        ]
      end
      csv << []
      csv << []
      csv << [" ","  <---","----------","---------","Bills","60","to","90","days","past","due","---->   "]
      csv << []
      csv << [
        "Vendor_name",
        "Bill_number",
        "Bill_date",
        "Due_date",
        "Due_amount",
        "Payment_terms",
        "Location",
        "Department",
        "Po_number",
        "Sales_rep",
        "Message",
        "Created_at",
        "Updated_at"
      ]
      @due_60_to_90_days_bills.each do |bill|
        csv << [
          bill.vendor.name,
          bill.bill_number,
          bill.bill_date.strftime("%d %B %Y"),
          bill.due_date.strftime("%d %B %Y"),
          bill.due_amount,
          bill.payment_term.try(:name),
          bill.location.try(:name),
          bill.department.try(:name),
          bill.po_number,
          bill.sales_rep,
          bill.message,
          bill.created_at.strftime("%d %B %Y"),
          bill.updated_at.strftime("%d %B %Y")
        ]
      end
      csv << []
      csv << []
      csv << [" ","  <---","----------","---------","Bills","above","90","days","past","due","----------","---->   "]
      csv << []
      csv << [
        "Vendor_name",
        "Bill_number",
        "Bill_date",
        "Due_date",
        "Due_amount",
        "Payment_terms",
        "Location",
        "Department",
        "Po_number",
        "Sales_rep",
        "Message",
        "Created_at",
        "Updated_at"
      ]
      @due_above_90_bills.each do |bill|
        csv << [
          bill.vendor.name,
          bill.bill_number,
          bill.bill_date.strftime("%d %B %Y"),
          bill.due_date.strftime("%d %B %Y"),
          bill.due_amount,
          bill.payment_term.try(:name),
          bill.location.try(:name),
          bill.department.try(:name),
          bill.po_number,
          bill.sales_rep,
          bill.message,
          bill.created_at.strftime("%d %B %Y"),
          bill.updated_at.strftime("%d %B %Y")
        ]
      end
    end  
  end

  def vendors_bills_to_csv(options = {})
    vendor_ids = @data.map(&:vendor_id).uniq
    CSV.generate(options) do |csv|
      vendor_ids.each do |v_id|
          csv << ["","","","","","","","",""
                ]
          csv << ["--","--","--","Vendor",ReportsHelper.vendor_name_csv(v_id),"--","--","--"
                ]
          csv << ["","","","","","","","",""
                ]
          csv << [
            "bill_number",
            "bill_date",
            "due_date",
            "payment_terms",
            "location",
            "department",
            "po_number",
            "sales_rep",
            "due_amount"
          ]
          total_amount = 0
        ReportsHelper.vendors_bills_csv(@data,v_id).each do |bill|
          csv << [
            bill.bill_number,
            bill.bill_date,
            bill.due_date.strftime("%d %B %Y"),
            bill.payment_term.try(:name),
            bill.location.try(:name),
            bill.department.try(:name),
            bill.po_number,
            bill.sales_rep,
            bill.due_amount
          ]
          total_amount = total_amount + bill.due_amount.to_f
        end
        csv << ["","","","","","","","total_due_amount:",total_amount
                ]
      end
    end  
  end

end	