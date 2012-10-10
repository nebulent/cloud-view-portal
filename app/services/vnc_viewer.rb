#have a proxy service which shoul forward all traffic by tokens
#have a proxy class which will request a proxy url from service
#   have successfull strategies to avoid proxying
#have viewer class which takes a terminal a generates a link to view

class VncViewer
  PROXY_HOST = '127.0.0.1'
  CLIENT_URL = '/clients/vnc/vnc_auto.html'

  def initialize (terminal)
    @terminal = terminal
  end

  def client_query
    [
      "host=#{PROXY_HOST}",
      "user=#{@terminal.username}",
      "port=#{@terminal.port}"
    ].join('\n')
  end

  def connect_link
    "#{CLIENT_URL}?#{client_query}"
  end

end
