class SecretGroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_secret_group, only: %i[ show edit update destroy ]

  # GET /secret_groups or /secret_groups.json
  def index
    @secret_groups = current_user.secret_groups.all
  end

  # GET /secret_groups/name or /secret_groups/name.json
  def show
  end

  # GET /secret_groups/new
  def new
    @secret_group = SecretGroup.new
  end

  # GET /secret_groups/1/edit
  def edit
  end

  # POST /secret_groups or /secret_groups.json
  def create
    @secret_group = current_user.secret_groups.new(secret_group_params)

    respond_to do |format|
      if @secret_group.save
        format.html { redirect_to user_secret_group_path(name: @secret_group.name, owner: @secret_group.owner), notice: "Secret group was successfully created." }
        format.json { render :show, status: :created, location: @secret_group }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @secret_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /secret_groups/1 or /secret_groups/1.json
  def update
    respond_to do |format|
      if @secret_group.update(secret_group_params)
        format.html { redirect_to user_secret_group_path(owner: @secret_group.owner, name: @secret_group.name), notice: "Secret group was successfully updated." }
        format.json { render :show, status: :ok, location: @secret_group }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @secret_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /secret_groups/1 or /secret_groups/1.json
  def destroy
    @secret_group.destroy!

    respond_to do |format|
      format.html { redirect_to user_secret_groups_path(owner: current_user.name), notice: "Secret group was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_secret_group
      @secret_group = current_user.secret_groups.find_by_name(params[:name])
    end

    # Only allow a list of trusted parameters through.
    def secret_group_params
      params.require(:secret_group).permit(:name, :description)
    end
end
