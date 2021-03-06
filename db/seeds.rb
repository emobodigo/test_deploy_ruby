# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Invoice.all.each_with_index do |invoice, index|
#   invoice.volume = invoice.shipping_instruction.volume
#   invoice.port_of_loading = invoice.shipping_instruction.port_of_loading
#   invoice.save!
#   puts "Invoices #{index}" if index%10 == 0
# end
# Note.all.each_with_index do |note, index|
#   note.volume = note.shipping_instruction.volume
#   note.port_of_loading = note.shipping_instruction.port_of_loading
#   note.save!
#   puts "Notes #{index}" if index%10 == 0
# end
# DebitNote.all.each_with_index do |dbn, index|
#   dbn.volume = dbn.shipping_instruction.volume
#   dbn.port_of_loading = dbn.shipping_instruction.port_of_loading
#   dbn.save!
#   puts "Debit Notes #{index}" if index%10 == 0
# end



# ShippingInstructionHistory.where("si_no LIKE ?", "IBL14%").each_with_index do |sih, index|
#   sih.volume = sih.shipping_instruction.volume
#   sih.shipping_schedule = sih.shipping_instruction.shipping_schedule
#   sih.save!
#   puts "SI Histories 2014 #{index}" if index%10 == 0
# end
# ShippingInstructionHistory.where("si_no LIKE ?", "IBL15%").each_with_index do |sih, index|
#   sih.volume = sih.shipping_instruction.volume
#   sih.shipping_schedule = sih.shipping_instruction.shipping_schedule
#   sih.save!
#   puts "SI Histories 2015 #{index}" if index%10 == 0
# end
# ShippingInstructionHistory.where("si_no LIKE ?", "IBL16%").each_with_index do |sih, index|
#   sih.volume = sih.shipping_instruction.volume
#   sih.shipping_schedule = sih.shipping_instruction.shipping_schedule
#   sih.save!
#   puts "SI Histories 2016 #{index}" if index%10 == 0
# end



# Payment.all.each_with_index do |payment, index|
#   # ref.amount_payment = ref.amount.gsub(',', '').to_f
#   payment.amount = payment.amount.gsub(',', '').to_f
#   payment.save(validate: false)
#   puts "Payment #{index}" if index%10 == 0
# end
# PaymentReference.all.each_with_index do |ref, index|
#   # ref.amount_payment = ref.amount.gsub(',', '').to_f
#   ref.amount = ref.amount.gsub(',', '').to_f
#   ref.save(validate: false)
#   puts "Reference #{index}" if index%10 == 0
# end



# Container.create(container_type: 'Type')



# CostRevenue.all.sort_by{|p| p.shipping_instruction.ibl_ref}.each_with_index do |revenue, index|
#   cr_container = []

#   si = revenue.shipping_instruction
#   si.si_containers.each do |item|
#     cr_container << { container_id: item.container_id, volum: item.volum }
#   end
  
#   revenue.ibl_ref = si.ibl_ref 
#   revenue.master_bl_no = si.master_bl_no 
#   revenue.shipper_reference = si.shipper_reference 
#   # revenue.carrier = si.carrier 
#   revenue.carrier_id = Carrier.find_by(name: si.carrier).try(:id)
#   revenue.shipper = si.shipper 
#   revenue.consignee = si.consignee 
#   revenue.trade = si.trade 
#   revenue.vessel_name = si.first_vessel_name 
#   revenue.etd_date = si.first_etd_date 
#   revenue.port_of_loading = si.port_of_loading 
#   revenue.port_of_discharge = si.port_of_discharge 
#   revenue.final_destination = si.final_destination 
#   revenue.volume = si.volume 

#   revenue.cr_containers.destroy_all
  
#   revenue.cr_containers.build(cr_container)
#   revenue.save!
#   puts "Revenue #{index}" if index%10 == 0
# end



# ShippingInstruction.where(is_shadow: false, is_cancel: ShippingInstruction::UNCANCELED).each_with_index do |shipping_instruction, index|
#   # SiMonitoringWorker.process_si_monitoring(shipping_instruction.id)
#   # BlMonitoringWorker.process_bl_monitoring(shipping_instruction.id)
#   # CrMonitoringWorker.process_cr_monitoring(shipping_instruction.id)
#   DocumentMonitoringWorker.process_document_monitoring(shipping_instruction.id)
#   InvoiceMonitoringWorker.process_invoice_monitoring(shipping_instruction.id)
#   # PaymentMonitoringWorker.process_payment_monitoring(shipping_instruction.id)
#   # SellCostMonitoringWorker.process_sell_cost_monitoring(shipping_instruction.id)
#   # ShipmentMonitoringWorker.process_shipment_monitoring(shipping_instruction.id)
#   puts "SI #{index}" if index%100 == 0
# end



# # CostRevenue.where("created_at <= ?", Date.parse('2016-07-20').end_of_day).order(ibl_ref: :desc).each_with_index do |revenue, index|
# CostRevenue.all.order(ibl_ref: :desc).each_with_index do |revenue, index|
#   if((revenue.selling_rate.to_f == 0) && (revenue.buying_rate.to_f == 0)) 
# 	  revenue.selling_rate = 13000
# 	  revenue.buying_rate = 13000

# 	  revenue.save!
#   else
#     puts revenue.ibl_ref
# 	end
#   puts "Revenue #{index}" if index%10 == 0
# end



# # CostRevenue.includes(:cost_revenue_items).where("ibl_ref LIKE ? AND created_at <= ?", "IBL16%", Date.parse('2016-07-20').end_of_day).order(ibl_ref: :desc).each_with_index do |revenue, index|
# CostRevenue.includes(:cost_revenue_items).where("ibl_ref LIKE ?", "IBL16%").order(ibl_ref: :desc).each_with_index do |revenue, index|
#   if((revenue.cost_revenue_items.map{|p| p.selling_total_after_tax}.sum(&:to_f) == 0) && (revenue.cost_revenue_items.map{|p| p.buying_total_after_tax}.sum(&:to_f) == 0)) 
# 	  revenue.cost_revenue_items.each do |item|
#       item.selling_total_after_tax = item.selling_total
#   	  item.buying_total_after_tax = item.buying_total

#   	  item.save!
#     end
#   else
#     puts revenue.ibl_ref
#   end
#   puts "Revenue #{index}" if index%10 == 0
# end
# # CostRevenue.includes(:cost_revenue_items).where("ibl_ref LIKE ? AND created_at <= ?", "IBL15%", Date.parse('2016-07-20').end_of_day).order(ibl_ref: :desc).each_with_index do |revenue, index|
# CostRevenue.includes(:cost_revenue_items).where("ibl_ref LIKE ?", "IBL15%").order(ibl_ref: :desc).each_with_index do |revenue, index|
#   if((revenue.cost_revenue_items.map{|p| p.selling_total_after_tax}.sum(&:to_f) == 0) && (revenue.cost_revenue_items.map{|p| p.buying_total_after_tax}.sum(&:to_f) == 0)) 
#     revenue.cost_revenue_items.each do |item|
#       item.selling_total_after_tax = item.selling_total
#       item.buying_total_after_tax = item.buying_total

#       item.save!
#     end
#   else
#     puts revenue.ibl_ref
#   end
#   puts "Revenue #{index}" if index%10 == 0
# end
# # CostRevenue.includes(:cost_revenue_items).where("ibl_ref LIKE ? AND created_at <= ?", "IBL14%", Date.parse('2016-07-20').end_of_day).order(ibl_ref: :desc).each_with_index do |revenue, index|
# CostRevenue.includes(:cost_revenue_items).where("ibl_ref LIKE ?", "IBL14%").order(ibl_ref: :desc).each_with_index do |revenue, index|
#   if((revenue.cost_revenue_items.map{|p| p.selling_total_after_tax}.sum(&:to_f) == 0) && (revenue.cost_revenue_items.map{|p| p.buying_total_after_tax}.sum(&:to_f) == 0)) 
#     revenue.cost_revenue_items.each do |item|
#       item.selling_total_after_tax = item.selling_total
#       item.buying_total_after_tax = item.buying_total

#       item.save!
#     end
#   else
#     puts revenue.ibl_ref
#   end
#   puts "Revenue #{index}" if index%10 == 0
# end



# # CostRevenue.includes(:cost_revenue_items).where("((cost_revenue_items.selling_usd != ? && cost_revenue_items.selling_idr != ?) OR (cost_revenue_items.buying_usd != ? && cost_revenue_items.buying_idr != ?)) AND cost_revenue.created_at <= ?", 0, 0, 0, 0, Date.parse('2016-07-20').end_of_day).references(:cost_revenue_items)
# # CostRevenue.includes(:cost_revenue_items).where("ibl_ref LIKE ? AND created_at <= ?", "IBL140631", Date.parse('2016-07-20').end_of_day).each_with_index do |revenue, index|
# # CostRevenue.includes(:cost_revenue_items).where("ibl_ref LIKE ? AND created_at <= ?", "IBL16%", Date.parse('2016-07-20').end_of_day).each_with_index do |revenue, index|
# CostRevenue.includes(:cost_revenue_items).where("ibl_ref LIKE ?", "IBL16%").each_with_index do |revenue, index|
#   revenue.cost_revenue_items.each do |item|
#     if((item.selling_usd != 0 && item.selling_idr != 0) || (item.buying_usd != 0 && item.buying_idr != 0))
#       CostRevenueItem.create(cost_revenue: revenue, description: item.description, selling_volume: item.selling_volume, selling_idr: item.selling_idr, selling_total_after_tax: item.selling_idr, buying_volume: item.buying_volume, buying_idr: item.buying_idr, buying_total_after_tax: item.buying_idr)
#       item.selling_idr = 0
#       item.buying_idr = 0
#       item.selling_total_after_tax = item.selling_total
#       item.buying_total_after_tax = item.buying_total
#       item.save!
#     end
#   end
#   puts "Revenue #{index}" if index%10 == 0
# end
# # CostRevenue.includes(:cost_revenue_items).where("ibl_ref LIKE ? AND created_at <= ?", "IBL15%", Date.parse('2016-07-20').end_of_day).each_with_index do |revenue, index|
# CostRevenue.includes(:cost_revenue_items).where("ibl_ref LIKE ?", "IBL15%").each_with_index do |revenue, index|
#   revenue.cost_revenue_items.each do |item|
#     if((item.selling_usd != 0 && item.selling_idr != 0) || (item.buying_usd != 0 && item.buying_idr != 0))
#       CostRevenueItem.create(cost_revenue: revenue, description: item.description, selling_volume: item.selling_volume, selling_idr: item.selling_idr, selling_total_after_tax: item.selling_idr, buying_volume: item.buying_volume, buying_idr: item.buying_idr, buying_total_after_tax: item.buying_idr)
#       item.selling_idr = 0
#       item.buying_idr = 0
#       item.selling_total_after_tax = item.selling_total
#       item.buying_total_after_tax = item.buying_total
#       item.save!
#     end
#   end
#   puts "Revenue #{index}" if index%10 == 0
# end
# # CostRevenue.includes(:cost_revenue_items).where("ibl_ref LIKE ? AND created_at <= ?", "IBL14%", Date.parse('2016-07-20').end_of_day).each_with_index do |revenue, index|
# CostRevenue.includes(:cost_revenue_items).where("ibl_ref LIKE ?", "IBL14%").each_with_index do |revenue, index|
#   revenue.cost_revenue_items.each do |item|
#     if((item.selling_usd != 0 && item.selling_idr != 0) || (item.buying_usd != 0 && item.buying_idr != 0))
#       CostRevenueItem.create(cost_revenue: revenue, description: item.description, selling_volume: item.selling_volume, selling_idr: item.selling_idr, selling_total_after_tax: item.selling_idr, buying_volume: item.buying_volume, buying_idr: item.buying_idr, buying_total_after_tax: item.buying_idr)
#       item.selling_idr = 0
#       item.buying_idr = 0
#       item.selling_total_after_tax = item.selling_total
#       item.buying_total_after_tax = item.buying_total
#       item.save!
#     end
#   end
#   puts "Revenue #{index}" if index%10 == 0
# end



# # CostRevenue.includes(:cost_revenue_items).where("ibl_ref LIKE ? AND created_at <= ?", "IBL16%", Date.parse('2016-07-20').end_of_day).order(ibl_ref: :desc).each_with_index do |revenue, index|
# CostRevenue.includes(:cost_revenue_items).where("ibl_ref LIKE ?", "IBL16%").order(ibl_ref: :desc).each_with_index do |revenue, index|
#   revenue.cost_revenue_items.each do |item|
#     if item.selling_total_after_tax.to_f == 0 && (item.selling_idr.to_f != 0 || item.selling_usd.to_f != 0)
#       item.selling_total_after_tax = item.selling_total
#       puts revenue.ibl_ref
#       item.save!
#     end

#     if item.buying_total_after_tax.to_f == 0 && (item.buying_idr.to_f != 0 || item.buying_usd.to_f != 0)
#       item.buying_total_after_tax = item.buying_total
#       puts revenue.ibl_ref
#       item.save!
#     end

#   end
#   puts "Revenue #{index}" if index%10 == 0
# end
# # CostRevenue.includes(:cost_revenue_items).where("ibl_ref LIKE ? AND created_at <= ?", "IBL15%", Date.parse('2016-07-20').end_of_day).order(ibl_ref: :desc).each_with_index do |revenue, index|
# CostRevenue.includes(:cost_revenue_items).where("ibl_ref LIKE ?", "IBL15%").order(ibl_ref: :desc).each_with_index do |revenue, index|
#   revenue.cost_revenue_items.each do |item|
#     if item.selling_total_after_tax.to_f == 0 && (item.selling_idr.to_f != 0 || item.selling_usd.to_f != 0)
#       item.selling_total_after_tax = item.selling_total
#       puts revenue.ibl_ref
#       item.save!
#     end

#     if item.buying_total_after_tax.to_f == 0 && (item.buying_idr.to_f != 0 || item.buying_usd.to_f != 0)
#       item.buying_total_after_tax = item.buying_total
#       puts revenue.ibl_ref
#       item.save!
#     end

#   end
#   puts "Revenue #{index}" if index%10 == 0
# end
# # CostRevenue.includes(:cost_revenue_items).where("ibl_ref LIKE ? AND created_at <= ?", "IBL14%", Date.parse('2016-07-20').end_of_day).order(ibl_ref: :desc).each_with_index do |revenue, index|
# CostRevenue.includes(:cost_revenue_items).where("ibl_ref LIKE ?", "IBL14%").order(ibl_ref: :desc).each_with_index do |revenue, index|
#   revenue.cost_revenue_items.each do |item|
#     if item.selling_total_after_tax.to_f == 0 && (item.selling_idr.to_f != 0 || item.selling_usd.to_f != 0)
#       item.selling_total_after_tax = item.selling_total
#       puts revenue.ibl_ref
#       item.save!
#     end

#     if item.buying_total_after_tax.to_f == 0 && (item.buying_idr.to_f != 0 || item.buying_usd.to_f != 0)
#       item.buying_total_after_tax = item.buying_total
#       puts revenue.ibl_ref
#       item.save!
#     end

#   end
#   puts "Revenue #{index}" if index%10 == 0
# end












# CostRevenue.all.sort_by{|p| p.shipping_instruction.ibl_ref}.each_with_index do |revenue, index|
#   revenue.carrier_id == Carrier.find_by(name: revenue.carrier).try(:id)
#   revenue.save!
  
#   puts "Revenue #{index}" if index%100 == 0
# end

# # PaymentReference.all.group_by{|a| a.ibl_ref}.each do |ibl_ref, refs|
# #   puts "#{ibl_ref} - #{refs.map{|p| p.payment_no}.uniq.join(', ')}" if refs.map{|p| p.carrier_name}.uniq.count > 1
# # end

# # InvoicePayment.group_by{|a| a.invoice_id}.each.each_with_index do |inv, index|
# # 	if inv.invoice_no.blank?
# #     inv.close_payment.create(payment_date: inv.payment_date. invoice_no: Invoice.find(inv.invoice_id))
# #     inv.carrier_id == Carrier.find_by(name: inv.carrier).try(:id)
# #     inv.save!
# #   end  
  
# #   puts "Invoice Payment #{index}" if index%100 == 0
# # end