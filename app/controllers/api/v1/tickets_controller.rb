class Api::V1::TicketsController < ApplicationController
  require "will_paginate/array"

  # GET /tickets
  def index
    $page = params[:page] ? params[:page] : 1
    $per_page = params[:per_page] ? params[:per_page] : 10
    @tickets = Ticket.paginate(:page => $page, :per_page => $per_page).order('created_at DESC')

    render json: @tickets
  end

  # GET /tickets/:id
  def show
    @ticketId = Ticket.where(id: params[:id]).present?

    if @ticketId
      render json: Ticket.find(params[:id])
    else
      render json: { message: "Ticket not found" }, status: 404
    end
  end

  # POST /tickets
  def create
    @ticket = Ticket.new(ticket_params)

    if @ticket.save
      render json: { ticket: @ticket }, status: 200
    else
      render json: { message: @ticket.errors }, status: 400
    end
  end

  # PATCH/PUT /tickets/:id
  def update
    @ticketId = Ticket.where(id: params[:id]).present?

    if @ticketId
      @ticket = Ticket.find(params[:id])
      @ticket.update(ticket_params)

      render json: { ticket: @ticket }, status: 200
    else
      render json: { message: "Ticket not found" }, status: 404
    end
  end

  # DELETE /tickets/:id
  def destroy
    @ticketId = Ticket.where(id: params[:id]).present?

    if @ticketId
      @ticket = Ticket.find(params[:id])
      @ticket.destroy

      render json: { message: "Ticket deleted successfully" }, status: 200
    else
      render json: { message: "Ticket not found" }, status: 404
    end
  end

  private
    # Only allow a list of trusted parameters through.
    def ticket_params
      params.require(:ticket).permit(:subject, :description, :status, :priority, :requester)
    end
end
