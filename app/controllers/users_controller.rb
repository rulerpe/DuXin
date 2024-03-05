class UsersController < ApplicationController
  skip_before_action :authenticate_request, only: %i[create create_temp_user]
  include ActionController::Cookies

  # GET /user_data
  def user_from_token
    render json: { message: 'User data', user: @current_user }
  end

  # PUT /user_data
  def update_user_from_token
    if @current_user.update(user_params)
      render json: { message: 'Update success', user: @current_user }
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # POST /users
  def create
    # Create a new user, or get existing user, and send verification code to phone
    @user = User.find_or_initialize_by(phone_number: user_params[:phone_number])

    if @user.save
      # skip verification for test user
      puts "test number #{ENV['test_phone_number']}"
      if @user.phone_number != ENV['test_phone_number']
        OtpVerificationService.new.start_verification(@user.phone_number)
      end
      render json: { message: 'Verification code sent. Please verify your phone number.', status: :ok }
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # POST /temp_user
  def create_temp_user
    # phone number is a uuid from frontend
    @user = User.new(user_params)
    @user.user_type = 'TEMP'
    if @user.save
      token = AuthenticationService.generate_jwt(@user.id)
      cookies.signed[:auth_token] =
        { value: token, httponly: true, same_site: :none, secure: true, expires: 1.week.from_now }
      render json: { message: 'Temp user created.', token:, user: @user }, status: :ok
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /logout
  def logout
    cookies.delete(:auth_token, domain: :all)
    render json: { message: 'Logged out successfully' }, status: :ok
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  private

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:phone_number, :language)
  end
end
