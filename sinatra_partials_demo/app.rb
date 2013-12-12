require 'bundler'
Bundler.require

Dir.glob('./lib/*.rb') do |model|
  require model
end

module Partial_Demo
  class App < Sinatra::Base

    before do 
      @cat = Cat.new
      @cats = []
      rand(1..20).times do
        @cats << Cat.new
      end
    end

    #routes
    get '/' do
      erb :index
    end

    get '/cats' do
      erb :test
    end

    helpers do

        def simple_partial(template)
          erb template
        end
    
        def intermediate_partial(template, locals=nil)
          locals = locals.is_a?(Hash) ? locals : {template.to_sym => locals}
          template = :"_#{template}"
          erb template, {}, locals        
        end
   
        def adv_partial(template,locals=nil)
          if template.is_a?(String) || template.is_a?(Symbol)
            template = :"_#{template}"
          else
            locals=template
            template = template.is_a?(Array) ? :"_#{template.first.class.to_s.downcase}" : :"_#{template.class.to_s.downcase}"
          end
          if locals.is_a?(Hash)
            erb template, {}, locals      
          elsif locals
            locals=[locals] unless locals.respond_to?(:inject)
            locals.inject([]) do |output,element|
              output << erb(template,{},{template.to_s.delete("_").to_sym => element})
            end.join("\n")
          else 
            erb template
          end
        end

    end

  end
end
