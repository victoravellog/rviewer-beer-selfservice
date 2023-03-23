class Dispenser::CalculateDispenserSpending < Actor

  input :dispenser, type: Dispenser

  output :spending, type: BigDecimal
  def call
    # BigDecimal is used to avoid floating point errors
    self.spending = BigDecimal(dispenser.dispenser_usages.sum(&:spending)).round(4)
  end
end
