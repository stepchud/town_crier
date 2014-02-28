require_dependency "town_crier/application_controller"

module TownCrier
  class ProclamationsController < ApplicationController
    before_action :set_proclamation, only: [:show, :edit, :update, :destroy]

    # GET /proclamations
    def index
      @proclamations = Proclamation.all
    end

    # GET /proclamations/1
    def show
    end

    # GET /proclamations/new
    def new
      @proclamation = Proclamation.new
    end

    # GET /proclamations/1/edit
    def edit
    end

    # POST /proclamations
    def create
      @proclamation = Proclamation.new(proclamation_params)

      if @proclamation.save
        redirect_to @proclamation, notice: 'Proclamation was successfully created.'
      else
        render action: 'new'
      end
    end

    # PATCH/PUT /proclamations/1
    def update
      if @proclamation.update(proclamation_params)
        redirect_to @proclamation, notice: 'Proclamation was successfully updated.'
      else
        render action: 'edit'
      end
    end

    # DELETE /proclamations/1
    def destroy
      @proclamation.destroy
      redirect_to proclamations_url, notice: 'Proclamation was successfully destroyed.'
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_proclamation
        @proclamation = Proclamation.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def proclamation_params
        params[:proclamation]
      end
  end
end
