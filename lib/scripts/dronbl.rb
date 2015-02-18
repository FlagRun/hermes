# encoding: utf-8
require 'ipaddress'
require 'dnsbl/client'

Script :dnsbl do

  Author 'Liothen'
  Version '0.1'
  Description 'Lookup'

  def initialize
  end

  client.on :message do |user, channel, line|
    match = line.match(/\.lookup (.+)/)
    if match
        c = DNSBL::Client.new
        r = c.lookup match[1]
        if r.empty?
          channel.say 'No Results Found'
        elsif r.last.dnsbl == 'URIBL' && r.last.meaning == '127.0.0.1'
          channel.say 'No Results Found'
        else
          channel.say "Listed ⁘ #{match[1]} ⁜ #{r.last.meaning} ⁜ Hits: #{r.count}"
        end
    end
  end

end
