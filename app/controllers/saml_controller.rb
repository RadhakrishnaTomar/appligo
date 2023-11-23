class SamlController < ApplicationController
    skip_before_action :verify_authenticity_token, only: [:consume, :create_sso_organization,:create_user]
    before_action :validate_token ,only: [:create_sso_organization,:create_user]
    before_action :get_saml_setting,only: [:init,:consume, :logout]

    def sign
    end

    def init
        request = OneLogin::RubySaml::Authrequest.new
        settings = saml_settings
        settings.name_identifier_value_requested = params["email"]
        redirect_to(request.create(settings),allow_other_host: true)
    end

    def consume
        response = OneLogin::RubySaml::Response.new(params[:SAMLResponse], settings: saml_settings)
        if response.is_valid?
          nameid = response.nameid
          team_member = TeamMember.find_by(email: nameid)
        if team_member
          session[:userid] = team_member.email
          session[:attributes] = response.attributes
          sign_in team_member
          redirect_to root_path
        else
          redirect_to saml_sign_path
          flash[:alert] = "Authorization failed:User not found"
        end
        else
          redirect_to saml_sign_path
          flash[:alert] = "Authorization failed: #{response.errors}"
        end
    end

    def logout
      request = OneLogin::RubySaml::Logoutrequest.new
      settings = saml_settings
      settings.name_identifier_value_requested = current_team_member&.email
      redirect_to(request.create(settings),allow_other_host: true)
    end

    def logout_response
       response = logout_response = OneLogin::RubySaml::Logoutresponse.new(params[:SAMLResponse], settings)
       if response.is_valid?
          member = TeamMember.find_by(params["email"])
          sign_out member
        else
        end
    end

    def saml_settings
      settings = OneLogin::RubySaml::Settings.new
      settings.assertion_consumer_service_url = "#{request.base_url}/saml/consume?email=#{params["email"]}"
      settings.sp_entity_id                   = "#{request.base_url}/saml/metadata"
      settings.idp_sso_service_url            = @saml_setting.sso_url
      settings.idp_slo_service_url            = @saml_setting.slo_url
      settings.idp_cert_fingerprint_algorithm = "http://www.w3.org/2000/09/xmldsig#sha1"
      settings.name_identifier_format = "urn:oasis:names:tc:SAML:1.1:nameid-format:emailAddress"
      settings.idp_cert = @saml_setting.certificate
      settings
    end

    def create_sso_organization
      company = Company.create(name: params[:org_name])
      if company.valid?
        params[:role_id] = Role.admin.first&.id
        member = company.team_members.create(member_params)
        setting = company.build_saml_setting(saml_params).save

        if member.present? && setting.present?
          render json: { message: 'Records created successfully' }, status: :created
        else
          render json: { errors: "Failed to create the records" }, status: :unprocessable_entity
        end
      else
        render json: {errors: "Company is not valid "}
      end
    end

     def create_user
      setting = SamlSetting.find_by(org_uuid: params[:org_uuid])
      return "saml_setting not present" unless setting.present?
      params[:role_id] = Role.find_by(id: '78ea0138-06ae-4f60-ad68-9e53ee498494').id
      member = setting&.company&.team_members.create(member_params)
      if member.present?
        render json: { message: 'Records created successfully' }, status: :created
      else
         render json: { errors: "Failed to create the records" }, status: :unprocessable_entity
      end 
     end
     
  private

  def saml_params
    params.permit(:org_uuid, :app_uuid, :certificate)
  end

  def member_params
    params[:name] = params.delete(:user_name)
    params[:email] = params.delete(:user_email)
    params.permit(:name, :email, :role_id)
  end

  def get_saml_setting
    email = params["email"] || current_team_member.email
    member = TeamMember.find_by(email: email)
    if member.present?
      @saml_setting = member.company.saml_setting
      return "" unless @saml_settin.present?
    else
      flash.now[:alert] = "Invalid EmailID."
      render :sign
    end

  end

  def validate_token
     app_token = request.headers["HTTP_APP_TOKEN"]
      if app_token != ENV["TOKEN"]
        render json: { errors: "Unauthorized. Invalid token." }, status: :unauthorized
      end
  end

end


