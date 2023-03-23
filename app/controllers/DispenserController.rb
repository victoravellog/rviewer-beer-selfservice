class DispenserController < ApplicationController
  before_action :set_dispenser, only: [:show, :open, :close, :spending]

  def show
  end

  def create
    @dispenser = Dispenser.new(dispenser_params)
    if @dispenser.save!
      render action: 'show', status: :created
    end

    rescue ActiveRecord::RecordInvalid => e
    render json: { error: 'error' }, status: :unprocessable_entity
  end

  def open
    Dispenser::OpenDispenser.call(dispenser: @dispenser)

  rescue ActiveRecord::RecordInvalid => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  def close
    Dispenser::CloseDispenser.call(dispenser: @dispenser)

  rescue ActiveRecord::RecordInvalid => e
    render json: { error: e.message }, status: :unprocessable_entity
  rescue ServiceActor::Failure => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  def spending
    @total_spending = Dispenser::CalculateDispenserSpending.call(dispenser: @dispenser).spending
  end

  private

  def set_dispenser
    @dispenser = Dispenser.find(params[:id])
  rescue ActiveRecord::RecordNotFound => e
    render json: { error: e.message }, status: :not_found
  end

  def dispenser_params
    params.require(:dispenser).permit(:flow_volume)
  end
end
