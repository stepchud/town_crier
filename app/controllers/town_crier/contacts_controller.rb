require_dependency "town_crier/application_controller"

module TownCrier
  class ContactsController < ApplicationController
    before_action :set_contact, only: [:show, :edit, :update, :destroy]

    # GET /contacts
    def index
      @contacts = Contact.all
    end

    # GET /contacts/1
    def show
    end

    # GET /contacts/new
    def new
      session.delete(:current_contact)
      @contact = Contact.new
    end

    # GET /contacts/1/edit
    def edit
    end

    # POST /contacts
    def create
      @contact = Contact.new(contact_params)

      if @contact.save
        session[:current_contact] = @contact.id
        redirect_to new_proclamation_path, notice: 'Contact info saved.'
      else
        render action: 'new'
      end
    end

    # PATCH/PUT /contacts/1
    def update
      if @contact.update(contact_params)
        redirect_to @contact, notice: 'Contact was updated.'
      else
        render action: 'edit'
      end
    end

    # DELETE /contacts/1
    def destroy
      @contact.destroy
      redirect_to contacts_url, notice: 'Contact was destroyed.'
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_contact
        @contact = Contact.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def contact_params
        params[:contact].permit(:name, :email, :cell_number, :cell_allows_mms, :cell_carrier, :im)
      end
  end
end
