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
  "/initial_proposal" => "https://docs.google.com/document/d/11-5EMSkbsVMd6X6QUlOgnrqSKC4-I284Ig9VzZhrtlU/edit",
  "/summary" =>  "https://docs.google.com/document/d/1GC1TlAeCeFyNOQzm5JDmQ7scqZY0-lv2q7SoquXc3KU/edit",
  "/svc" => "https://docs.google.com/document/d/1gOnCZUtlVsw1aWU7hxu8u_sndhHc_RFm7r-TwwTk0Gs/edit",
  "/donate" => "http://www.causes.com/actions/1701185",
  "/fellowship" => "https://docs.google.com/a/techintheworld.org/spreadsheet/viewform?usp=sharing&formkey=dENtSk5iQ3pmemExYUt6eUY5NjY3dVE6MQ#gid=0",
  "/application" => "https://docs.google.com/a/techintheworld.org/forms/d/1Tp24p5iWpaqsQOaxsBiz1Bpc3vXsZARZ3pygI5m7rPE/viewform",
  "/donate" => "https://www.causes.com/campaigns/64757-develop-global-health-software-solutions-in-tanzania"
}

redirects.each do |short_link, full_link|
  get short_link do
    redirect full_link
  end
end

["proposal", "team", "pilot", "documentary"].each do |url|
  get "/#{url}" do
    slim url.to_sym
  end
end
