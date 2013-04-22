class Amazon
  class << self
    def create_access_token (organization, username, duration, actions)
      sts = init_sts(organization)
      iam = init_iam(organization)

      group = create_or_get_group(iam)
      create_user_if_needed(iam, group, username)

      session = sts.new_federated_session(username,
                                          :policy => access_policy(actions),
                                          :duration => duration.hours)

      issuer_url = "https://vamdemo.vnocportal.com/"
      console_url = "https://console.aws.amazon.com/ec2"
      signin_url = "https://signin.aws.amazon.com/federation"

      session_json = {
        :sessionId => session.credentials[:access_key_id],
        :sessionKey => session.credentials[:secret_access_key],
        :sessionToken => session.credentials[:session_token]
      }.to_json

      get_signin_token_url = signin_url + "?Action=getSigninToken" \
                             + "&SessionType=json&Session=" + CGI.escape(session_json)

      returned_content    = URI.parse(get_signin_token_url).read
      signin_token        = JSON.parse(returned_content)['SigninToken']
      signin_token_param  = "&SigninToken=" + CGI.escape(signin_token)
      issuer_param        = "&Issuer=" + CGI.escape(issuer_url)
      destination_param   = "&Destination=" + CGI.escape(console_url)

      signin_url + "?Action=login" + signin_token_param + issuer_param + destination_param
    end

    private

    def create_user_if_needed (iam, group, username)
      user = iam.users.find {|u| u.name == username }
      group_user = group.users.find {|u| u.name == username }

      user = iam.users.create(username) unless user
      group.users.add(user) unless group_user
    end

    def create_or_get_group (iam, name='VAM')
      group = iam.groups.find {|g| g.name == name }
      group ||= iam.groups.create(name)
    end

    def access_policy (actions)
      policy = AWS::STS::Policy.new
      policy.allow(:actions => actions, :resources => :any)
      policy
    end

    def init_iam (organization)
      @iam ||= AWS::IAM.new(:access_key_id => organization.aws_key_id,
                            :secret_access_key => organization.aws_secret_key)
    end

    def init_sts (organization)
      @sts ||= AWS::STS.new(:access_key_id => organization.aws_key_id,
                            :secret_access_key => organization.aws_secret_key)
    end
  end
end
