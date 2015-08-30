class InsurancesController < ApplicationController
  before_action :set_insurance, only: [:show, :edit, :update, :destroy, :index]

  def index
    binding.pry
    render :show
  end

  def show
  end

  def new
    @insurance = Insurance.new
  end

  def edit
  #I don't think you really have to do this. MJB

    respond_to do |format|
      if @insurance.update(insurance_params)
        format.html { redirect_to @insurance, notice: 'Your Insurance was successfully updated.' }
        format.json { render :show, status: :ok, location: @insurance }
      else
        format.html { render :edit }
        format.json { render json: @insurance.errors, status: :unprocessable_entity }
      end
    end
  end

  def create
    @insurance = Insurance.new(insurance_params)
    respond_to do |format|
      if @insurance.save
        # Handle a successful save.
        format.html { redirect_to @insurance, notice: 'Your Insurance was successfully added. '}
          format.json { render :show, status: :ok, location: @insurance }
      else
        render :'new'
      end
    end

  end

  def update
    respond_to do |format|
      if @insurance.update(insurance_params)
        format.html { redirect_to @insurance, notice: 'Your Insurance was successfully updated. ' + current_user.id.to_s }
        format.json { render :show, status: :ok, location: @insurance }
      else
        format.html { render :'show' }
        format.json { render json: @insurance.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @insurance.destroy
    respond_to do |format|
      format.html { render 'home/index', notice: 'Insurance was successfully Deleted.' }
      format.json { head :no_content }
    end
  end

  private

    def set_insurance
      # binding.pry
      if user_signed_in?
        @insurance = Insurance.find_by(user_id: current_user.id)
        if (@insurance.nil?)
          @insurance = Insurance.new
          render :'new'
        end
      else
        # Not sure if we need this one. Matt is a Noob.
        render 'home/index'
      end
   end

    def insurance_params
      params.require(:insurance).permit(:first_name, :last_name, :enrolee_id,
                                   :group_number, :user_id)
    end

end
