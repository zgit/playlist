class Req

  def self.req_all_scripts
    Dir.glob("#{$pageObjDir}/**/*.rb") do |require_all|
      require_relative require_all
    end
  end

  def self.req_config(configfile,env)
    begin
        if (File.exist? (configfile)) == true then
          config_ = YAML.load_file("#{configfile}")
            if (config_.has_key? (env)) == true
              $config = config_[env]
            else
              puts "\e[1;31m Unable to find Env: #{env} in config.yaml file."
              exit
            end
          end
    rescue => e
        puts e
    end
  end

  def self.req_all_data_files(filepath)
    if (File.exist? (filepath)) == true then
      $test_data = YAML.load_file("#{filepath}")
    end
  end

end
