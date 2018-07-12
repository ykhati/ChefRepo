node[:deploy].each do |application, deploy|

    if node[:custom_env][application.to_s]["type"] != "java"
        log "error_incompat" do
            message         "This application is not a Java application"
            level           :error
        end
        next
    end

    execute "run_jar" do
        user                "#{deploy[:user]}"
        cwd                 "#{deploy[:deploy_to]}/current"
        command             "nohup /usr/bin/java8 -jar #{node[:custom_env][application.to_s]['jar']} > log.txt 2> error.txt < /dev/null &"
    end

end
