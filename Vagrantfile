VM_BOX_NAME = "bento/ubuntu-16.04".freeze

Vagrant.configure(2) do |config|
  config.vm.box = VM_BOX_NAME
  # config.vm.hostname = "xenial64"
  config.vm.network :private_network, ip: "192.168.38.5"
  config.ssh.forward_agent = true
  config.vm.provision :shell, path: "./provision/bootstrap.sh", privileged: true
  # config.vm.provision :shell, privileged: true, inline: <<-SHELL
  #   declare -a rm_dir=( \
  #     "/var/lib/apt/lists/lock" \
  #     "/var/cache/apt/archives/lock" \
  #     "/var/lib/dpkg/lock" \
  #   )
  #
  #   for rm_item in ${rm_dir[@]}; do
  #     if [[ -f $rm_item ]]; then
  #       rm -rf ${rm_item}
  #     fi
  #   done
  #   apt-get -y update
  #   apt-get -y install python2.7
  #   apt-get -y install software-properties-common
  #   apt-get -y install python-software-properties
  #   apt-add-repository ppa:ansible/ansible
  #   apt-get -y update
  #   apt-get -y upgrade
  #   apt-get -y install ansible
  #   cd /vagrant/provision
  #   ansible-playbook site.yml
  # SHELL

  config.vm.synced_folder ".", "/vagrant", type: "nfs"
  # config.vm.synced_folder "./shared", "/home/vagrant/shared", tycpe: "nfs"

  config.vm.provider :virtualbox do |vb|
    vb.name = "eLib_vagrant_#{VM_BOX_NAME.split('/').last.gsub(/[-.]/, '_')}"
    vb.linked_clone = false # 差分のみでboxを生成しない。provisioning中にマウント出来ず失敗する
    vb.gui = false # GUIは使わない
    vb.customize [
      "modifyvm", :id,
      "--cpus", "2", # CPUは2つ
      "--memory", "512", # メモリは512MB
      "--vram", "1", # GPUメモリは1MB
      "--hwvirtex", "on", # vt-xを有効
      "--ioapic", "on", # マルチCPUを利用するのに必要っぽい
      "--acpi", "off", # 電源情報を通知しない
      "--pae", "on", # メモリ使用量(物理アドレス拡張)を増やす
      "--nestedpaging", "off", # 仮想マシン内で仮想マシンを動作させる
      "--largepages", "on", # バッファメモリを利用する
      "--paravirtprovider", "kvm", # ハイパバイザー
    ]
    # # SSDにする
    # vb.customize [
    #   "storagectl", :id,
    #   "--name", "SCSI Controller",
    #   "--hostiocache", "on"
    # ]
    # vb.customize [
    #   "storageattach", :id,
    #   "--storagectl", "SCSI Controller",
    #   "--port", "0",
    #   "--device", "0",
    #   "--nonrotational", "on"
    # ]
    # vb.customize [
    #   "storageattach", :id,
    #   "--storagectl", "SCSI Controller",
    #   "--port", "1",
    #   "--device", "0",
    #   "--nonrotational", "on"
    # ]

  end
end
