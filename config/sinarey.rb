
require 'sinarey'

require "sinatra/multi_route"
require "sinatra/content_for"

require 'sinarey_support'
require 'erb_safe_ext'

require 'sequel'
require 'will_paginate'
require 'timerizer'
require 'oj'

require 'nokogiri'

#require 'newrelic_rpm' #线上监控

db_opts = {
  adapter: Sinarey.dbconfig['adapter'],
  host: Sinarey.dbconfig['host'],
  port: Sinarey.dbconfig['port'],
  database: Sinarey.dbconfig['database'],
  user: Sinarey.dbconfig['username'],
  password: Sinarey.dbconfig['password'],
  max_connections: Sinarey.dbconfig['pool']||1,
  textsize: 2147483647,
  logger: nil && Logger.new(STDOUT)
}

DB = Sequel.connect(db_opts)
DB.extension(:pagination)

Sequel::Model.plugin :timestamps, update_on_create:true

module Sinarey

  class Application < Sinatra::SinareyBase

    set :default_encoding, 'utf-8'

    helpers Sinatra::ContentFor

    register WillPaginate::Sinatra
    register Sinatra::MultiRoute

    set :static, false

    #logger configure
    set :logging, nil

    set :erb, trim: '>'

    set :raise_errors, false
    set :dump_errors, false

    case Sinarey.env
    when 'production'
      set :show_exceptions, false
    else
      require "sinatra/sinarey_reloader"
      register Sinatra::SinareyReloader
      Dir["#{Sinarey.root}/app/*/*.rb"].each {|f| also_reload f }
      set :show_exceptions, true
    end

    #use custom logic for finding template files
    def find_template(views, name, engine, &block)
      paths = views.map { |d| Sinarey.root + '/app/views/' + d }
      Array(paths).each { |v| super(v, name, engine, &block) }
    end

    #常规访问日志
    def access_logger
      current_day = Time.now.strftime('%Y-%m-%d')
      if (@@access_logger_day||=nil) != current_day
        @@access_logger_day = current_day
        @@access_logger = ::Logger.new(Sinarey.root+"/log/#{current_day}_access.log")
      end
      @@access_logger
    end

    def accesslog(msg)
      access_logger << (msg.to_s + "\n")
    end

    helpers do

      def escape_javascript(javascript)
        if javascript
          javascript.gsub(/(\\|<\/|\r\n|\342\200\250|\342\200\251|[\n\r"'])/u) {|match| JS_ESCAPE_MAP[match] }
        else
          ''
        end
      end

      def app_logger
        current_day = Time.now.strftime('%Y-%m-%d')
        if (@@app_logger_day||=nil) != current_day
          @@app_logger_day = current_day
          @@app_logger = ::Logger.new(Sinarey.root+"/log/#{current_day}_app.log")
        end
        @@app_logger
      end

      def dump_errors
        boom = env['sinatra.error']
        if boom.present?
          msg = ["#{boom.class} - #{boom.message}:", *boom.backtrace].join("\n\t")
          puts(msg)
        end
      end

      def p(msg)
        app_logger << (msg.inspect + "\n")
      end

      def puts(msg)
        app_logger << (msg.to_s + "\n")
      end
      
      #开发环境，日志转到STDOUT
      if Sinarey.env=='development'

        def app_logger 
          Logger.new(STDOUT) 
        end
      end

    end


  end
end

JS_ESCAPE_MAP = {
  '\\'    => '\\\\',
  '</'    => '<\/',
  "\r\n"  => '\n',
  "\n"    => '\n',
  "\r"    => '\n',
  '"'     => '\\"',
  "'"     => "\\'"
}

JS_ESCAPE_MAP["\342\200\250".force_encoding(Encoding::UTF_8).encode!] = '&#x2028;'
JS_ESCAPE_MAP["\342\200\251".force_encoding(Encoding::UTF_8).encode!] = '&#x2029;'

class ApplicationController < Sinarey::Application ; end #init