module ReportsHelper

  def vendor_name(v_id)
      current_organization.vendors.find(v_id).name
  end

  def vendors_bills(bills,v_id)
  	  vendors_bills = bills.where(vendor_id: v_id) 
  end

  def self.vendor_name_csv(v_id)
      Vendor.find(v_id).name
  end

  def self.vendors_bills_csv(bills,v_id)
  	  vendors_bills = bills.where(vendor_id: v_id) 
  end

end
