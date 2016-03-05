class UserVoicesController < ApplicationController
  before_action :set_user_voice, only: [:show, :edit, :update, :destroy]
  before_action :admin?, :except => [:new, :create]

  # GET /user_voices
  # GET /user_voices.json
  def index
    @user_voices = UserVoice.paginate(page: params[:page], per_page: 10).order(id: :desc)
  end

  # GET /user_voices/1
  # GET /user_voices/1.json
  def show
  end

  # GET /user_voices/new
  def new
    @user_voice = UserVoice.new
  end

  # GET /user_voices/1/edit
  def edit
  end

  # POST /user_voices
  # POST /user_voices.json
  def create
    @user_voice = UserVoice.new(user_voice_params)

    if @user_voice.save
      flash.now[:success] = "좋은 의견, 진심으로 감사합니다! 더 좋은 서비스가 되도록 노력하겠습니다!!!"
    else
      flash.now[:danger] = "문제가 발생했습니다. 불편을 드려 죄송합니다."
    end

    respond_to do |format|
      format.js { render layout: false }
    end    
  end

  # PATCH/PUT /user_voices/1
  # PATCH/PUT /user_voices/1.json
  def update
    respond_to do |format|
      if @user_voice.update(user_voice_params)
        format.html { redirect_to @user_voice, notice: 'User voice was successfully updated.' }
        format.json { render :show, status: :ok, location: @user_voice }
      else
        format.html { render :edit }
        format.json { render json: @user_voice.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_voices/1
  # DELETE /user_voices/1.json
  def destroy
    @user_voice.destroy
    respond_to do |format|
      format.html { redirect_to user_voices_url, notice: 'User voice was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_voice
      @user_voice = UserVoice.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_voice_params
      params.require(:user_voice).permit(:name, :email, :title, :description)
    end
end
