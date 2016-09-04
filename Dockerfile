# Pythonは公式イメージ
FROM hypriot/rpi-python

# 各ライブラリインストール
# Pythonがパッケージ依存するものもインストール
# Pythonプロフェッショナルプログラミング第2版P9より
RUN apt-get update
RUN apt-get upgrade -y
# よく使うコマンド
RUN apt-get install -y 	vim \
						sudo \
                        wget \
                        git

# Python3インストールに必要
RUN apt-get install -y build-essential \
                       libncursesw5-dev \
                       libgdbm-dev \
                       libc6-dev \
                       zlib1g-dev \
                       libsqlite3-dev \
                       tk-dev \
                       libssl-dev \
                       openssl \
                       libbz2-dev \
                       libreadline-dev

# Python3をインストール
RUN wget https://www.python.org/ftp/python/3.5.2/Python-3.5.2.tgz
RUN tar xvf Python-3.5.2.tgz 
WORKDIR Python-3.5.2
RUN ./configure && make && make install

# pip3をインストール
RUN apt-get install -y python3-pip
RUN pip3 install --upgrade pip

# pipでインストール
# virtualenv Pythonの仮想環境構築コマンド
# bottle Pytrhonの軽量フレームワーク
# flake8 コーディングスタイル/シンタックスのチェック
# ipython Pythonのインタラクティブモード拡張
RUN pip3 install virtualenv \
				bottle \
				ipython \
				flake8

# ユーザ作成
RUN groupadd web
RUN useradd -d /home/bottle -m bottle

# MySQLドライバ"mysql-connector-python"をインストール
# pipのを使うとエラーなので、git clone
RUN git clone https://github.com/mysql/mysql-connector-python.git
WORKDIR mysql-connector-python
RUN python3 ./setup.py build
RUN python3 ./setup.py install

# bottleを使ったサーバ起動ファイルをコピー
ADD ./app/server.py /home/bottle/server.py

# ポートは8080(bottleは8080らしい)にし、サーバ起動ファイルを新しく作成した"bottle"ユーザで起動
EXPOSE 8080
# ENTRYPOINT ["/usr/local/bin/python3", "/home/bottle/server.py"]
USER bottle

# vim の設定ファイル
ADD ./vim/.vimrc /home/bottle/
WORKDIR /home/bottle
RUN mkdir /home/bottle/.vim
RUN mkdir /home/bottle/.vim/ftplugin
ADD ./vim/python.vim /home/bottle/.vim/ftplugin/
RUN mkdir /home/bottle/.vim/bundle
RUN git clone https://github.com/Shougo/neobundle.vim /home/bottle/.vim/bundle/neobundle.vim
