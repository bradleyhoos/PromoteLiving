class InsurancesController < ApplicationController
  before_filter :authenticate_user!
  # before_action :check_for_complete_account, [:]
  before_action :set_insurance, only: [:show, :edit, :update, :destroy]

  def index
    if current_user.insurance_policy.present?
      @insurance = current_user.insurance
      render :show
    else
      render 'home/index'
    end
  end

  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @insurance }
    end
  end

  def new
    @insurance = Insurance.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @insurance }
    end
  end

  def edit
  end

  def create
    @insurance = Insurance.new(insurance_params.merge!(user_id: current_user.id))
    if @insurance.save
      check_for_complete_account
    else
      respond_to do |format|
        format.html { render :new }
        format.json { render json: @insurance.errors, status: :unprocessable_entity }
      end
    end
    # respond_to do |format|
    #   if @insurance.save
    #     check_for_complete_account
    #     format.html { redirect_to @insurance, notice: 'Your Insurance was successfully added.'}
    #     format.json { render json: @insurance, status: :created, location: @insurance }
    #   else
    #     format.html { render :new }
    #     format.json { render json: @insurance.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  def update
    respond_to do |format|
      if @insurance.update(insurance_params)
        # check_for_complete_account
        format.html { redirect_to @insurance, notice: 'Your Insurance was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :edit }
        format.json { render json: @insurance.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @insurance.destroy
    respond_to do |format|
      format.html { redirect_to insurances_path, notice: 'Insurance was successfully Deleted.' }
      format.json { head :no_content }
    end
  end

  private

    def set_insurance
      @insurance = Insurance.find(params[:id])
    end

    def insurance_params
      params.require(:insurance).permit(:enrollee_id, :group_number, :user_id)
    end

end
