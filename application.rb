#!/usr/bin/env ruby

require 'sinatra'
require 'slim'
require 'sass'

get '/' do
  slim :home
end

get '/build/:name.css' do |name|
  require './views/scss/bourbon/lib/bourbon.rb'
  content_type :css
  scss :"scss/#{name}", :layout => false
end

redirects = {
  "/proposal" =>  "https://docs.google.com/document/d/11-5EMSkbsVMd6X6QUlOgnrqSKC4-I284Ig9VzZhrtlU/edit",
  "/summary" =>  "https://docs.google.com/document/d/1GC1TlAeCeFyNOQzm5JDmQ7scqZY0-lv2q7SoquXc3KU/edit",
  "/svc" => "https://docs.google.com/document/d/1gOnCZUtlVsw1aWU7hxu8u_sndhHc_RFm7r-TwwTk0Gs/edit"
}

redirects.each do |short_link, full_link|
  get short_link do
    redirect full_link
  end
end

["proposal", "team", "contact"].each do |url|
  get "/#{url}" do
    slim url.to_sym
  end
end
