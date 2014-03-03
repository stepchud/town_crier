require_dependency "town_crier/application_controller"

module TownCrier
  class ProclamationsController < ApplicationController
    before_action :set_proclamation, only: [:show, :edit, :update, :destroy]
    before_action :set_contact, only: [:new, :create]

    # GET /proclamations/new
    def new
      @proclamation = Proclamation.new
    end

    # POST /proclamations
    def create
      @proclamation = Proclamation.new(proclamation_params)
      logger.info("proclamation options=#{proclamation_params[:options]}")

      if @proclamation.save
        redirect_to @proclamation, notice: 'Proclamation was successfully created.'
      else
        render action: 'new'
      end
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_proclamation
        @proclamation = Proclamation.find(params[:id])
      end

      def set_contact
        @contact = session[:current_contact] ? Contact.find(session[:current_contact]) : Contact.first
      end

      # Only allow a trusted parameter "white list" through.
      def proclamation_params
        params[:proclamation].permit(:full_text, {:options => [:to, :via]})
      end
  end
end
