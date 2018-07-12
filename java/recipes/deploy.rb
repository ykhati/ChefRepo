
    execute "run_jar" do
        user                "deploy"
        cwd                 "srv/www/app-gigyacurrent"
        command             "nohup /usr/bin/java8 -jar #{node[application.to_s]['jar']} > /var/log/awslogs.log 2> /var/log/awslogs.log < /dev/null &"
    end

