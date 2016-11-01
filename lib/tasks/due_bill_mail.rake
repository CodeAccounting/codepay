desc "Bill Reminder"
task :due_bill_mail => :environment do
  bills = Bill.all
  bills.each do |bill|
    due_date = bill.due_date
    if (Time.now > due_date)
			BillMailer.reminder(bill).deliver_later 	
      puts "#{bill.id} was due and informed!"
    else
    	puts "#{bill.id} has time to pay!"
    end
  end 
end