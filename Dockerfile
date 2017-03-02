FROM centos:7
MAINTAINER skychi, <sky8chi@gmail.com>

RUN \
    yum update -y && \
    yum install -y epel-release && \
    yum install -y nodejs && \
    yum install -y npm && \
    yum install -y git && \
    npm --registry=https://registry.npm.taobao.org \
        --cache=$HOME/.npm/.cache/cnpm  \
        --disturl=https://npm.taobao.org/dist \
        --userconfig=$HOME/.cnpmrc \
        install hexo-cli -g

RUN npm install -g gulp

RUN yum install -y vim

ENV "TZ=Asia/Shanghai"

WORKDIR /Hexo/blog

RUN \
    echo "set tabstop=4" >> ~/.vimrc && \
    echo "set termencoding=utf-8" >> ~/.vimrc && \
    echo "set encoding=prc" >> ~/.vimrc && \
    echo "set fileencodings=utf-8" >> ~/.vimrc && \
    echo "set fileencoding=utf-8" >> ~/.vimrc

RUN \
    echo -e "\
        git clone -b backup git@github.com:sky8chi/blog.git . \n\
        git clone git@github.com:sky8chi/blog.git public/ \n \
        npm install  \n \
        npm install hexo-deployer-git --save \n \
        npm install hexo-git-backup --save \n \
        npm install hexo-algoliasearch --save \n \
        npm install hexo-asset-image --save \n \
        npm install gulp --save \n \
        npm install gulp-htmlclean --save \n \
        npm install gulp-htmlmin --save \n \
        npm install gulp-minify-css --save \n \
        npm install gulp-uglify --save \n \
	hexo server&" >> /Hexo/init.sh

RUN \
   echo -e "\
	cd /Hexo/blog \n \
	git config --global user.email "sky8chi@gmail.com" \n\
	git config --global user.name "sky8chi" \n\
	git remote add github git@github.com:sky8chi/blog.git" >> /Hexo/restart.sh

RUN \
    echo -e "\
	sh /Hexo/init.sh \n\
	sh /Hexo/restart.sh" >> /Hexo/start.sh

EXPOSE 4000
ENTRYPOINT ["/bin/bash"]
