class SecretsController < ApplicationController
  before_action :authenticate_user!, except: %i[show]

  # GET /secrets?group_name=name or /secrets.json?group_name=name
  def index
    if params[:group_name].present?
      @secretgroup = current_user.secret_groups.find_by_name(params[:group_name])
      redirect_back fallback_location: root_path, notice: "Group not found" unless @secretgroup.present?
      @secrets = @secretgroup.secrets

    else
      @secrets = current_user.secrets
    end
  end

  # GET /secrets/1 or /secrets/1.json
  def show
    @secret = Secret.find(params[:id])
  end

  # GET /secrets/new
  def new
    @secret = current_user.secret_groups.find_by_name(params[:secret_group_name]).secrets.new
  end

  # GET /secrets/1/edit
  def edit
    @secret = current_user.secrets.find(params[:id])
    redirect_back fallback_location: root_path, notice: 'Secret not found' unless @secret.present?
  end

  # POST /secrets or /secrets.json
  def create
    @secret = current_user.secrets.new(secret_create_params)
    respond_to do |format|
      if @secret.save
        format.html { redirect_to secret_url(@secret), notice: 'Secret was successfully created.' }
        format.json { render :show, status: :created, location: @secret }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @secret.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /secrets/1 or /secrets/1.json
  def update
    @secret = Secret.find(params[:id])
    respond_to do |format|
      if @secret.update(secret_update_params)
        format.html do
          redirect_to user_secret_group_secret_path(owner: @secret.owner, secret_group_name: @secret.group_name, id: @secret.id),
                      notice: 'Secret was successfully updated.'
        end
        format.json { render :show, status: :ok, location: @secret }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @secret.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /secrets/1 or /secrets/1.json
  def destroy
    @secret = Secret.find(params[:id])
    @secret.destroy!
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Secret was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def secret_create_params
    params.require(:secret).permit(:name, :description, :value, :interval, :is_google, :length, :group_name)
  end

  def secret_update_params
    params.require(:secret).permit(:name, :description, :group_name)
  end
end
