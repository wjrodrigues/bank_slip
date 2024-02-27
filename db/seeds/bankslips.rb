# frozen_string_literal: true

return if Bankslip::Record.exists?

puts('Start seed - Bankslips 🚀')

FactoryBot.create_list(:bankslip_record, 3)
FactoryBot.create_list(:bankslip_record, 3, :overdue)
FactoryBot.create_list(:bankslip_record, 3, :canceled)
FactoryBot.create_list(:bankslip_record, 3, :expired)
