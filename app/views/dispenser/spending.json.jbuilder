json.amount @total_spending
json.usages_count @dispenser.dispenser_usages.count
json.usages @dispenser.dispenser_usages do |usage|
  json.opened_at usage.open_time
  json.closed_at usage.close_time || Time.now
  json.flow_volume @dispenser.flow_volume
  json.total_spending usage.spending
end
