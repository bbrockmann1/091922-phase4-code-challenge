class HeroPowersController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

    def create
        hp = HeroPower.create!(hp_params)
        render json: hp, status: :created
    end

    private
    def hp_params
        params.permit(:strength, :power_id, :hero_id)
    end

    def render_unprocessable_entity_response(invalid)
        render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
    end
end
