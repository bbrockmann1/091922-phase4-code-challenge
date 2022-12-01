class PowersController < ApplicationController
rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

    def index
        powers = Power.all
        render json: powers, status: :ok
    end

    def show
        power = Power.find_by(id: params[:id])
            if power
                render json: power, status: :ok
            else render json: {"error": "Power not found"}, status: :not_found
        end
    end

    def update
        power = Power.find(params[:id])
            power.update!(power_params)
            render json: power, status: :accepted
    end

    private
    def power_params
        params.permit(:description)
    end

    def render_unprocessable_entity_response(invalid)
        render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
    end
end
