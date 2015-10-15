class RewardsCardsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_rewards_card, only: [:show, :edit, :update, :destroy]

  # GET /rewards_cards
  # GET /rewards_cards.json
  def index
    @rewards_cards = current_user.rewards_cards
  end

  # GET /rewards_cards/1
  # GET /rewards_cards/1.json
  def show
  end

  # GET /rewards_cards/new
  def new
    find_retailer
    @rewards_card = current_user.rewards_cards.new(retailer: @retailer)
    #RewardsCard.new
  end

  # GET rewards_cards/rewards_card_chooser
  def rewards_card_chooser
    @retailers = Retailer.all
  end

  # GET /rewards_cards/1/edit
  def edit
  end

  # POST /rewards_cards
  # POST /rewards_cards.json
  def create
    @rewards_card = current_user.rewards_cards.new(rewards_card_params)#RewardsCard.new(rewards_card_params)

    respond_to do |format|
      if @rewards_card.save
        format.html { redirect_to @rewards_card, notice: 'Rewards card was successfully created.' }
        format.json { render :show, status: :created, location: @rewards_card }
      else
        format.html { render :new }
        format.json { render json: @rewards_card.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rewards_cards/1
  # PATCH/PUT /rewards_cards/1.json
  def update
    respond_to do |format|
      if @rewards_card.update(rewards_card_params)
        format.html { redirect_to @rewards_card, notice: 'Rewards card was successfully updated.' }
        format.json { render :show, status: :ok, location: @rewards_card }
      else
        format.html { render :edit }
        format.json { render json: @rewards_card.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rewards_cards/1
  # DELETE /rewards_cards/1.json
  def destroy
    @rewards_card.destroy
    respond_to do |format|
      format.html { redirect_to rewards_cards_url, notice: 'Rewards card was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rewards_card
      @rewards_card = RewardsCard.find(params[:id])
    end

    def find_retailer
      @retailer = Retailer.find(params['retailer'])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def rewards_card_params
      params.require(:rewards_card).permit(:rewards_number, :retailer, :user_id,
       :retailer_id)
      # user_id: integer, retailer_id: integer, rewards_number
      # params[:rewards_card]
    end
end
