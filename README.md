[Deprecated]

開発には以下のURLを使用してください
[https://github.com/toshogakari/eLib-docker](https://github.com/toshogakari/eLib-docker)

# vagrant

|name|version|
|:----|:-----|
|ホストOS|OSX EI Capitan 10.11.4|
|ゲストOS|ubuntu 16.04 64bit|
|provisioning| ansible(ubuntu内にインストール済み)|
|box| bento(packer会社が作ったやつ)|
|vagrant| 1.8.4|
|virtualbox| 5.0.22|
|shared|nfs|

## Installation

先に以下をインストールしておく。

- vagrant
- virtualbox

OSはmac or linux or unix (nfs, sshがあるもの)。
windowsは不可。

OSで必要な物は特に無い。

`vagrant` と `virtualbox` があれば全部 `ゲストOS側(ubuntu)` でやってくれる。 (ansibleもゲスト内で実行)

```bash
$ git clone git@github.com:toshogakari/eLib-vagrant.git
$ cd eLib-vagrant
$ git clone git@github.com:toshogakari/eLib.git ./shared/eLib

$ vagrant up
$ vagrant ssh

vagrant$ cd ~/shared
vagrant$ bundle install --path .bundle
vagrant$ bundle exec rake db:migrate
vagrant$ bundle exec rake db:seed
vagrant$ bundle exec rails s -p 8000 -b 0.0.0.0
```

rbenvがインストールするのに時間がかかるため、snapshotを撮っておくのがおすすめ

e.g.

```bash
$ vagrant snapshot save 20160404_100405_init
```

`vagrant up` に失敗したら、 `vagrant provision` で再度実行。

それでもだめなら、以下のディレクトリを削除して再 `vagrant up`すると上手くいくかも

```bash
$ rm -rf ./vagrant
$ rm -rf ~/.vagrant/tmp
$ vagrant up
```

## Version

### インストール済みなもの

|name|version|
|:----|:-----|
|ruby|2.3.1|
|rbenv|1.0.0|
|redis|apt-getの最新版|
|elasticsearch|2.x|
|postgresql|9.5|
|nginx|apt-getの最新版|
|java|openjdk-8の最新版|
|python2|apt-getの最新版|
|python3|apt-getの最新版|
|nodejs|apt-getの最新版|
|npm|apt-getの最新版|

### そのうち入れるもの

- kibana 4.5.1
	- elasticsearchを可視化できるもの？
- pyenv
	- pythonのバージョン管理に
- ndenv
	- nodejsのバージョン管理に

## shared_folder

|host path|guest path|
|:----|:-----|
|このリポジトリのroot|/vagrant|
|このリポジトリのroot/shared|~/shared|

`shared`ディレクトリにelibを `git clone` (mac側で) しておくと、作業ができるはず。

## IPとport番号

|name|number|
|:----|:-----|
|IP|192.168.38.5|

|name|port|check command|
|:----|:-----|:-----|
|nginx|80| `curl -XGET '192.168.38.5:80'`、[ページを開く](http://192.168.38.5)|
|elasticsearch|9200|`curl -XGET '192.168.38.5:9200'`、[ページを開く](http://192.168.38.5:9200)|
|redis|6379| `redis-cli -h 192.168.38.5` |
|postgresql|5432| `psql -h 192.168.38.5 -U elib -d elib` |
|rails| 8000 |`bundle exec rails s -p 8000` 後、 [ページを開く](http://192.168.38.5) |

port 8000 -> 80 に port forwardされているので、 railsで `-p 8000 -b 0.0.0.0` でポート指定して起動する。

[http://192.168.38.5](http://192.168.38.5)で見れるはず。

## 動作が重い時は…

Vagrantfileでvirtualboxの設定をする。

自分のPCに合わせて、下記のメモリ数を上げたりするといいかも

```ruby
vb.customize [
  "modifyvm", :id,
  "--cpus", "2", # CPUは2つ
  "--memory", "512", # メモリは512MB
  .....
```
