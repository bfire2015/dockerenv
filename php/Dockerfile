FROM daocloud.io/php:7.2.4-fpm
MAINTAINER StevenAn<alz8888@qq.com>

# 将本地源文件复制到镜像
ADD sources.list /etc/apt/sources.list

# 扩展依赖
RUN apt-get update \
	&& apt-get install -y \
		vim \
		telnet \
		curl \
		wget \
		cron \
		procps \
		rsyslog \
		zip \
		libz-dev \
		libssl-dev \
		libnghttp2-dev \
		libpcre3-dev \
		zlib1g-dev

# Mysqli 扩展（系统自带）
RUN docker-php-ext-install mysqli

# PDO 扩展（系统自带）
RUN docker-php-ext-install pdo_mysql

# Bcmath 扩展（系统自带）
RUN docker-php-ext-install bcmath

# 操作图像元数据（系统自带）
RUN docker-php-ext-install exif

# 子进程（系统自带）
RUN docker-php-ext-install pcntl

# 压缩
RUN docker-php-ext-install zip

# 加密
RUN apt-get install -y libmcrypt-dev && pecl install mcrypt-1.0.1 && docker-php-ext-enable mcrypt

# mongodb
RUN wget http://pecl.php.net/get/mongodb-1.5.3.tgz -O /tmp/mongodb.tgz \
	&& pecl install /tmp/mongodb.tgz \
	&& rm -rf /tmp/mongodb.tgz \
	&& docker-php-ext-enable mongodb

# Swoole
RUN wget https://github.com/swoole/swoole-src/archive/v4.3.2.tar.gz -O /tmp/swoole.tar.gz \
	&& mkdir -p /tmp/swoole \
	&& tar -xf /tmp/swoole.tar.gz -C /tmp/swoole --strip-components=1 \
	&& rm /tmp/swoole.tar.gz \
	&& ( \
		cd /tmp/swoole \
		&& phpize \
		&& ./configure --enable-async-redis --enable-mysqlnd --enable-openssl --enable-http2 \
		&& make -j$(nproc) \
		&& make install \
	) \
	&& rm -r /tmp/swoole \
	&& docker-php-ext-enable swoole

# 安装gd库
RUN apt-get install -y libwebp-dev libjpeg-dev libpng-dev libfreetype6-dev \
	&& docker-php-source extract \
	&& cd /usr/src/php/ext/gd \
	&& docker-php-ext-configure gd --with-webp-dir=/usr/include/webp --with-jpeg-dir=/usr/include --with-png-dir=/usr/include --with-freetype-dir=/usr/include/freetype2 \
	&& docker-php-ext-install gd

# 安装后清理
RUN rm -rf /var/lib/apt/lists/* && \
	rm -rf /var/log/* && \
	apt-get clean && \
	apt-get autoremove 

RUN groupadd -g 995 vboxsf && useradd -u 1000 -G vboxsf -m www
RUN ll="alias ll='ls -laF --color=auto --time-style \"+[%Y-%m-%d %H:%M:%S]\"'" && echo $ll >> ~/.bashrc && echo $ll >> /home/www/.bashrc
COPY crontab /etc/crontab
RUN echo 'Asia/Shanghai' > /etc/timezone && ln -snf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && chmod -R 777 /var/log/ && chmod 644 /etc/crontab

RUN ln -s /data/wwwroot/syslib/chlib/composer.phar /usr/bin/composer

VOLUME ["/data/wwwroot/"]

WORKDIR /data/wwwroot

EXPOSE 9000

CMD ["/data/wwwroot/docker/php/start.sh"]