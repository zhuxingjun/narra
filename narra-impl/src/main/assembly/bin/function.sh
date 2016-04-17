#!/bin/sh
DATE=`date "+%Y%m%d%H%M"`
job=$1
work=durian
work1=durian-impl
dir_work="/guolele/app/build.$work"
project="/guolele/app/build.$work/$work"
target="$project/$work1/target"
deploy_target="/guolele/app/build.$work"
backup="backup"
logfile="/guolele/app/build.$work/dubbo-durian-provider.log"
case "$job" in
        deploy)
                cd $project
                git checkout master
                git pull
                cd $project/$work1
                mvn clean package -DskipTests -Pproduct -U
                WAR=`ls $target|grep .tar.gz`
                echo $WAR
                cp target/$WAR $deploy_target/$backup/$WAR.$DATE
                rm -rf $deploy_target/ROOT
                mkdir $deploy_target/ROOT
                tar zxvf target/$WAR -C $deploy_target/ROOT/
                mv $deploy_target/ROOT/**/* $deploy_target/ROOT/
                $deploy_target/ROOT/bin/restart.sh
        ;;
        update)
                cd $project
                git checkout master
                git pull
        ;;
        ROOT)
                cd $dir_work
                tar cfz ROOT.$DATE.tar.gz ROOT
                mv ROOT.$DATE.tar.gz $wars/
esac