require 'sinatra'
require 'json'
require '../lib/docdsl'

# simple sinatra app to demo how you use DocDSL
class DocumentedApp < Sinatra::Base
  register Sinatra::DocDsl 
  
  
  page do      
    title "DocDSL demo"
    header "DocDSL is a tool to document REST APIs implemented using Sinatra"
    introduction "It is awesome"
    footer "This page was generated by sinatra-docdsl"
    configure_renderer do
      self.html
    end
  end
  
  documentation "redirect to the documentation" do
    response "redirects"
    status 303,"see other"
  end
  get "/" do
    redirect "/doc"
  end

  documentation "get a list of things"
  get "/things" do
    [200,"[1,2,3]"]
  end
  
  documentation "post a blob" do
    payload "some json content"
    response "some other json content"
  end

  post "/things" do
    [200,"[42]"]
  end

  documentation "you can document" do
    param :param1, "url parameters"
    query_param :queryParam1, "query string parameters"
    header 'Content-Type', "header"
    header 'Etag', "another header"
    payload "the payload", {:gimme=>"danger"}
    response "and of course a the response", {:some_field=>'sample value'}
    status 200,"okidokie"
    status 400,"that was bad"
  end
  post "/everything/:param1" do | param1 |    
    [200,{:theThing=>param1}.to_json]
  end
end

map '/' do
  run DocumentedApp
end