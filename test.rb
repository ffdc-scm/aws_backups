#!/usr/bin/env ruby

require 'rubygems'
require 'bundler/setup'
require 'right_aws'
require 'pp'
require 'yaml'
require 'logger'
require './creds.rb'
require './lib/backup.rb'

@logger = Logger.new(STDOUT)   if !@logger
@ec2   = RightAws::Ec2.new(@aws_key,@aws_secret, :logger => @logger)

vols = []
vols += @ec2.describe_volumes(:filters => { 'tag:backup:enabled' => '1' })
#vols += @ec2.describe_volumes(:filters => { 'volume-id' => 'vol-63d1f029' })

#vols = YAML.load_file("fixtures/vols.yaml")
vols.each do |v|
  obj = Backup.from_ec2(v, :logger => @logger)
  obj.api = @ec2
  obj.parse_ec2_snaps(@ec2.describe_snapshots(:filters => { 'volume-id' => obj.id }))
  #obj.parse_ec2_snaps(YAML.load_file("fixtures/snaps.yaml"))
  obj.api = nil
  obj.backup
  obj.prune_snaps!
  puts "Current Latest:"
  pp obj.latest
end

