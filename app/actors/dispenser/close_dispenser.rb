class Dispenser::CloseDispenser < Actor

  input :dispenser, type: Dispenser

  def call
    fail!(error: 'Dispenser is not open') if dispenser.dispenser_usages.empty?

    dispenser.dispenser_usages.last.update!(close_time: Time.now)
  end
end
