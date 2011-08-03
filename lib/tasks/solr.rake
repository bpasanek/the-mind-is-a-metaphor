namespace :solr do
  
  jetty_dir =        ENV['dir'] || 'solr'
  jetty_start_port = ENV['port'] || 8983
  jetty_stop_port =  ENV['stop_port'] || 8079
  jetty_stop_key =   ENV['stop_key'] || 'STOPME'
  java_opts =       '-Xmx1024M -Xms1024M'
  
  desc 'Starts jetty; Will attempt to stop jetty/solr first.'
  task :start=>['stop'] do
    puts "*** starting jetty on port #{jetty_start_port}..."
    cmd = "java -Djetty.port=#{jetty_start_port} -DSTOP.KEY=#{jetty_stop_key} -DSTOP.PORT=#{jetty_stop_port} -jar start.jar"
    cmd = "cd #{jetty_dir}; #{cmd}"
    `#{cmd}`
  end
  
  desc 'Stops jetty'
  task :stop do
    `cd #{jetty_dir} && java #{java_opts} -DSTOP.KEY=#{jetty_stop_key} -DSTOP.PORT=#{jetty_stop_port} -jar start.jar --stop`
  end
  
end