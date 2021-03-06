require 'socket'
require 'sludge/core_ext'

module Sludge
  def self.daemonize
    Thread.new do
      Server.new.run
    end
  end

  class Server
    SOCK = "/tmp/.sludge.sock"

    def initialize
      File::delete(SOCK) if File::exists?(SOCK)
      @socket  = UNIXServer.new(SOCK).tap { |s| s.listen(5) }
      @clients = []
    end

    def run
      loop do
        begin
          @clients << @socket.accept_nonblock
        rescue Errno::EINTR, Errno::EAGAIN
          sleep 0.1
        end

        next unless (ready = IO.select(@clients, nil, nil, 1))

        ready.first.map do |client|
          input = client.read

          if input == ""
            @clients.delete(client)
            next
          end

          process(input)
        end
      end
    end

    def process(input)
      load input
    rescue Exception => e
      puts e.message
      puts e.backtrace.grep(/#{input}/).join("\n")
    end
  end
end
