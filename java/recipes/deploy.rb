node[:deploy].each do |application, deploy|

    if node[application.to_s]["type"] != "java"
        log "error_incompat" do
            message         "This application is not a Java application"
            level           :error
        end
        next
    end

    execute "run_jar" do
        user                "#{deploy[:user]}"
        cwd                 "#{deploy[:deploy_to]}/current"
        command             "nohup /usr/bin/java8 -jar #{node[application.to_s]['jar']} > /var/log/awslogs.log 2> /var/log/awslogs.log < /dev/null &"
    end

end
