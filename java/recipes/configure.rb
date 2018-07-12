node[:deploy].each do |application, deploy|

    if node[application.to_s]["type"] != "java"
        log "error_incompat" do
            message         "This application is not a Java application"
            level           :error
        end
        next
    end

    template "#{deploy[:deploy_to]}/current/parameters.yml" do
        source              "parameters.yml.erb"
        mode                0644
        group               "root"
        owner               "#{deploy[:user]}"
        variables(
            :parameters =>  node[:deploy][application.to_s][:environment_variables],
            :application => application
        )
    end

    execute "stop_jar" do
        user                "#{deploy[:user]}"
        command             "pkill -cf #{node[application.to_s]['jar']}"
        only_if             "pgrep -f #{node[application.to_s]['jar']}"
    end

    execute "run_jar" do
        user                "#{deploy[:user]}"
        cwd                 "#{deploy[:deploy_to]}/current"
        command             "nohup /usr/bin/java8 -jar #{node[application.to_s]['jar']} > log.txt 2> error.txt < /dev/null &"
    end

end
