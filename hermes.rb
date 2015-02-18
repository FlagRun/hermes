#!/usr/bin/env ruby
# encoding: utf-8
$:.unshift File.dirname(__FILE__) + '/../../library'
require 'blur'


@config_path = File.expand_path 'config.yml'

Blur.connect config: @config_path do
# Raised once for every network upon successful connection.
  on :connection_ready do |network|
    log.info "Connection established and I'm ready for action!"
    network.transmit :MODE, 'hermes-dev', '+B'
    # network.transmit :OPER, 'liothen', 'kushi118O3'
    $network = network
  end

# Raised when a message is sent from a user outside of a channel.
  on :private_message do |user, message|
    # $network.transmit :OPER, 'liothen', 'kushi118O3'
    user.say "Sorry, I do not handle personal business!"
  end
end