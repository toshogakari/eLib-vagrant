VM_BOX_NAME = "pyar6329/xenial64".freeze

Vagrant.configure(2) do |config|
  config.vm.box = VM_BOX_NAME
  # config.vm.hostname = "xenial64"
  config.vm.network :private_network, ip: "192.168.38.5"
  config.ssh.forward_agent = true
  config.vm.provision :shell, path: "./provision/bootstrap.sh", privileged: true

  config.vm.synced_folder ".", "/vagrant", type: "nfs"
  config.vm.synced_folder "./shared", "/home/vagrant/shared", type: "nfs"

  config.vm.provider :virtualbox do |vb|
    vb.name = "eLib_vagrant_#{VM_BOX_NAME.split('/').last.gsub(/[-.]/, '_')}"
    vb.linked_clone = false # 差分のみでboxを生成しない。provisioning中にマウント出来ず失敗する
    vb.gui = false # GUIは使わない
    vb.customize [
      "modifyvm", :id,
      "--cpus", "2", # CPUは2つ
      "--memory", "1024", # メモリは1024MB(1GB)
      "--hwvirtex", "on", # vt-xを有効
      "--ioapic", "on", # マルチCPUを利用するのに必要っぽい
      "--acpi", "on", # acpi_pm(clocksource)で時間設定を同期するのに必要
      "--pae", "on", # メモリ使用量(物理アドレス拡張)を増やす
      "--nestedpaging", "off", # 仮想マシン内で仮想マシンを動作させる
      "--largepages", "on", # バッファメモリを利用する
      "--paravirtprovider", "kvm", # ハイパバイザー
    ]
    # 時刻をhostと同期しない(systemdでnictと同期)
    vb.customize [
      "setextradata", :id,
      "VBoxInternal/Devices/VMMDev/0/Config/GetHostTimeDisabled", 1
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
