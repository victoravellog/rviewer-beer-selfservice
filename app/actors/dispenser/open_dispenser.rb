class Dispenser::OpenDispenser < Actor

  input :dispenser, type: Dispenser

  def call
    dispenser.dispenser_usages.create!(open_time: Time.now)
  end
end
