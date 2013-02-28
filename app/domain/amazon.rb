require 'rubygems'
require 'json'
require 'open-uri'
require 'cgi'
require 'aws-sdk'

class Amazon

  # Normally, the temporary credentials will come from your identity
  # broker, but for this example we create them here

  sts = AWS::STS.new(:access_key_id => "*** Your AWS Access Key ID ***",
        :secret_access_key => "*** Your AWS Secret Access Key ***")

  # A sample policy for accessing Amazon SNS in the console.
  policy = AWS::STS::Policy.new
  policy.allow(:actions => "sns:*",:resources => :any)

  session = sts.new_federated_session(
    "UserName",
    :policy => policy,
    :duration => 3600)

  # The issuer parameter specifies your internal sign-in
  # page, for example https://mysignin.internal.mycompany.com/.
  # The console parameter specifies the URL to the destination console of the
  # AWS Management Console. This example goes to the Amazon SNS console.
  # The signin parameter is the URL to send the request to.

  issuer_url = "https://mysignin.internal.mycompany.com/"
  console_url = "https://console.aws.amazon.com/sns"
  signin_url = "https://signin.aws.amazon.com/federation"

  # Create the sign-in token using temporary credentials,
  # including the Access Key ID, Secret Access Key, and security token.
  session_json = {
    :sessionId => session.credentials[:access_key_id],
    :sessionKey => session.credentials[:secret_access_key],
    :sessionToken => session.credentials[:session_token]
  }.to_json

  get_signin_token_url = signin_url + "?Action=getSigninToken"
                         + "&SessionType=json&Session=" + CGI.escape(session_json)

  returned_content = URI.parse(get_signin_token_url).read
  signin_token = JSON.parse(returned_content)['SigninToken']

  signin_token_param = "&SigninToken=" + CGI.escape(signin_token)

  # The issuer parameter is optional, but recommended. Use it to direct users
  # to your sign-in page when their session expires.

  issuer_param = "&Issuer=" + CGI.escape(issuer_url)
  destination_param = "&Destination=" + CGI.escape(console_url)
  login_url = signin_url + "?Action=login" + signin_token_param + issuer_param + destination_param
end
