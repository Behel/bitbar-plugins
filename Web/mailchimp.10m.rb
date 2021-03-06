#!/usr/bin/ruby
# <xbar.title>MailChimp Subscribers</xbar.title>
# <xbar.version>v0.1.0</xbar.version>
# <xbar.author>Tim Novis</xbar.author>
# <xbar.author.github>timnovis</xbar.author.github>
# <xbar.desc>Display your MailChimp subscriber count for a given list</xbar.desc>
# <xbar.image>https://www.novis.co/media/misc/mc-bitbar.png</xbar.image>
# <xbar.dependencies>ruby</xbar.dependencies>

require 'net/http'
require 'json'

def main
  mc_user = "" # your mailchimp username
  mc_key = "" # a valid mailchimp API key
  mc_list = "" # the list ID you woud like to track
  mc_dc = "" # your mc datacenter location, e.g. us16

  req_uri = URI("https://#{mc_dc}.api.mailchimp.com/3.0/lists/#{mc_list}")

  http = Net::HTTP.new(req_uri.host, req_uri.port)
  http.use_ssl = true

  request = Net::HTTP::Get.new(req_uri)
  request.basic_auth(mc_user, mc_key)

  res = http.request(request)

  response = JSON.parse(res.body)

  return "MailChimp: " + response['stats']['member_count'].to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse
end

puts main
