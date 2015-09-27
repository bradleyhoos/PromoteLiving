class HealthSavingsAccountsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_health_savings_account, only: [:show, :edit, :update, :destroy]

  def index
    @health_savings_accounts = HealthSavingsAccount.all
  end

  def show
  end

  def new
    @health_savings_account = HealthSavingsAccount.new
  end

  def edit
  end

  def create
    @health_savings_account = HealthSavingsAccount.new(health_savings_account_params)

    respond_to do |format|
      if @health_savings_account.save
        format.html { redirect_to @health_savings_account, notice: 'Health savings account was successfully created.' }
        format.json { render :show, status: :created, location: @health_savings_account }
      else
        format.html { render :new }
        format.json { render json: @health_savings_account.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @health_savings_account.update(health_savings_account_params)
        format.html { redirect_to @health_savings_account, notice: 'Health savings account was successfully updated.' }
        format.json { render :show, status: :ok, location: @health_savings_account }
      else
        format.html { render :edit }
        format.json { render json: @health_savings_account.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @health_savings_account.destroy
    respond_to do |format|
      format.html { redirect_to health_savings_accounts_url, notice: 'Health savings account was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_health_savings_account
      @health_savings_account = HealthSavingsAccount.find(params[:id])
    end

    def health_savings_account_params
      params.require(:health_savings_account).permit(:account_number, :routing_number, :account_name, :user_id)
      # params[:health_savings_account]
    end
end
