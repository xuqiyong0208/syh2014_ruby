
class StaticRoute < Sinarey::Application

  #静态文件支持不应该由动态服务器来实现，生产环境打出访问日志来提示
  after do
    if Sinarey.env == 'production'
      accesslog "static file!!! | #{Time.now.strftime('%H:%M:%S')} | #{request.fullpath}"
    end
  end

  def halt_public_folder
    path = File.expand_path("#{Sinarey.root}/public#{unescape(request.path_info)}" )
    halt 404,'404' unless File.file?(path)
    env['sinatra.static_file'] = path
    send_file path, :disposition => nil
  end

  get '/assets/*' do
    halt_public_folder
  end

end
