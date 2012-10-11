require 'socket'

class PortChecker
  class << self

    def open? (port, host='127.0.0.1')
      begin
        server = TCPServer.new(host, port)
        server.close
        true
      rescue Errno::EADDRINUSE
        false
      end
    end

    def rand_open (host='127.0.0.1')
      port = rand_port
      while not open?(port)
        port = rand_port
      end
      port
    end

    def rand_port
      rand(65000 - 1024) + 1024
    end

  end
end
