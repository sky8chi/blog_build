docker rm -f hexo
docker run -itd --net docker1 --ip 172.0.1.101 \
        -v /root/.ssh:/root/.ssh -v /data/store/Hexo/blog:/Hexo/blog \
        --name hexo hexo:1.1 /Hexo/start.sh
