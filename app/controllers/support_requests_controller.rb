class SupportRequestsController < ApplicationController
  before_action :find_support_request, only: [:show, :edit, :update, :destroy]

  def index
     @support_requests = SupportRequest.order("complete ASC").page(params[:page]).per(7)

     @dep_count = {
      sales:  SupportRequest.where("department = ?", 0).count,
      marketing:      SupportRequest.where("department = ?", 1).count,
      technical:  SupportRequest.where("department = ?", 2).count,
    } #marketing, sales, technical


  end

  def new
    @support_request = SupportRequest.new

  end

  def create
    @support_request = SupportRequest.new(support_request_params)
    if @support_request.save
      flash[:notice] = "Support Request Successfully Submitted"
      redirect_to support_request_path(@support_request)
    else
      flash[:alert] = "Support Request Unsuccessful "
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update

    if @support_request.update(support_request_params)
      redirect_to update_success_direction(support_request_params, @support_request), notice: "Support updated"
    else
      flash[:alert] = "Support Request was not updated -- Please check errors below"
      render :edit
    end
  end

  def destroy
    @support_request.destroy
    redirect_to root_path, alert: "Support Request was deleted"
  end



  def search

    if params[:search_term]
     @search_term = params[:search_term]
     @search_results = SupportRequest.search_requests(params[:search_term]).page(params[:page]).per(7)

    end
  end

  private

    def support_request_params
       params.require(:support_request).permit([:name, :email, :department, :message, :complete])
    end

    def find_support_request
      @support_request = SupportRequest.find(params[:id])
    end

    def update_success_direction(params, support_request)
      if support_request_params.has_key?(:complete)
        support_requests_path
      else
        support_request_path(@support_request)
      end
    end


end
