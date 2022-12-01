#!/bin/bash
#Stop execution if any error in encountered
set -e

DIR=/usr/local/src/spk

function install_dpdk {
    dnf install git meson python3-pip
    pip3 install pyelftools

    #Clone and install DPDK, OVS, OVN
    cd $DIR
    wget https://fast.dpdk.org/rel/dpdk-21.11.2.tar.xz
    tar xf dpdk-21.11.2.tar.xz
    export DPDK_DIR=$DIR/dpdk-stable-21.11.2
    cd $DPDK_DIR

    export DPDK_BUILD=$DPDK_DIR/build
    meson build
    ninja -C build
    ninja -C build install
    ldconfig
}

function config_path {
    export PKG_CONFIG_PATH=/usr/local/lib64/pkgconfig
    export PATH=$PATH:/usr/local/share/openvswitch/scripts
    export DB_SOCK=/usr/local/var/run/openvswitch/db.sock
    export PATH=$PATH:/usr/local/share/ovn/scripts
    export PYTHONPATH=/usr/local/share/openvswitch/python
    export LD_LIBRARY_PATH=/usr/local/lib64
}
function install_ovs_ovn {
    cd $DIR
    #Build and install OVS with DPDK shared libraries
    git clone https://github.com/openvswitch/ovs.git
    cd ovs && ./boot.sh
    ./configure --with-dpdk=shared
    make; make install

    ovs-ctl start

    cd $DIR #Build and install OVN
    git clone https://github.com/ovn-org/ovn.git
    cd ovn && ./boot.sh; ./configure --with-ovs-source=$DIR/ovs
    make; make install
    ovs-vsctl set open . external_ids:ovn-remote="unix:/usr/local/var/run/ovn/ovnsb_db.sock"

}

function install_frr {
    #Build and install FRR
    dnf groupinstall "Development Tools"

    subscription-manager register --username=rh-ee-spk --password=Redhat27  --consumerid=270454d7-cae4-4165-8fa6-5ee69b68fc0d

    subscription-manager repos --enable codeready-builder-for-rhel-8-x86_64-rpms

    yum module enable python39-devel

    dnf install json-c-devel.x86_64 elfutils-libelf-devel.x86_64 python39-devel.x86_64 readline-devel.x86_64 libcap-devel.x86_64 byacc.x86_64 patch python3-sphinx.noarch python3-pytest.noarch texinfo nmap cmake pcre2-devel

    dnf install protobuf.x86_64 protobuf-c.x86_64 protobuf-c-compiler.x86_64 protobuf-c-devel.x86_64 protobuf-compiler.x86_64
    cd $DIR
    git clone https://github.com/CESNET/libyang.git
    cd libyang
    git checkout v2.0.0
    mkdir build; cd build
    dnf install cmake doxygen pcre2-devel
    cmake -D CMAKE_INSTALL_PREFIX:PATH=/usr -D CMAKE_BUILD_TYPE:String="Release" ..
    make
    make install

    dnf install readline readline-devel.x86_64 libcap libcap-devel.x86_64
    cd $DIR
    git clone https://github.com/FRRouting/frr.git
    cd frr
    ./bootstrap.sh
    ./configure     --prefix=/usr     --localstatedir=/var/run/frr     --sbindir=/usr/lib/frr     --sysconfdir=/etc/frr     --enable-pimd     --enable-watchfrr --enable-fpm --enable-protobuf
    make && make install
}
#DONE


# OVN - 1 router, 1 switch
# OVS - Namespace connecting to OVS using veth interfaces

# OVN: sw0-port1 -- sw0 --- lr0 --- Public --- ln-public ~~~~~~ br-ex
# OVS: sw0-port1 ~~~~~ veth0 -- br-int -- br-ex -- eno2 ~~~~~~~ ln-public
# NS - red: eth0-r ~~~~~ veth0
# NS - green: acts as a external network, NS - red acts as a VM in system with OVS OVN.

#Create network namespace

function create_topo {
    ip netns list
    ip netns add red
    ip link add eth0-r type veth peer name veth-r


    ip link set eth0-r netns red
    ovs-vsctl --may-exist add-br br-int
    ip link set veth-r up
    ip netns exec red ip link
    ovs-vsctl add-port br-int veth-r
    ovs-vsctl set interface veth-r external_ids:iface-id=sw0-port1
    ovs-vsctl show
    ip netns exec red ip link set dev lo up
    ip netns exec red ip link set dev eth0-r up
    ip netns exec red ip address add 10.0.0.2/24 dev eth0-r
    ip netns exec red ip addr
    mac_red=$(ip netns exec red ip a show dev eth0-r | grep ether | awk -F " " '{print $2}')
    echo "MAC: $mac_red"

    ip netns add green
    ip link add eth0-g type veth peer name veth-g
    ip link set eth0-g netns green
    ip netns exec green ip link set dev lo up
    ip netns exec green ip link set dev eth0-g up
    ip netns exec green ip a a 5.5.5.4/24 dev eth0-g

    ovs-vsctl add-br br-ex
    ovs-vsctl add-port br-ex veth-g
    ovs-vsctl add-port br-ex patch-br-ex-br-int -- set interface patch-br-ex-br-int type=patch options:peer=patch-br-int-br-ex -- add-port br-int patch-br-int-br-ex -- set interface patch-br-int-br-ex type=patch options:peer=patch-br-ex-br-int

    vlan_tag=0
    #OVN topology
    ovn-nbctl ls-add sw0
    ovn-nbctl set logical_switch sw0 other_config:subnet="10.0.0.0/24" other_config:exclude_ips="10.0.0.1"
    ovn-nbctl lsp-add sw0 sw0-port1
    ovn-nbctl lsp-set-addresses sw0-port1 "${mac_red} 10.0.0.2"

    ovn-nbctl lsp-add sw0 lrp0-attachment
    ovn-nbctl lsp-set-type lrp0-attachment router
    ovn-nbctl lsp-set-options lrp0-attachment router-port=lrp0
    ovn-nbctl lsp-set-addresses lrp0-attachment router
    ovn-nbctl lr-add lr0
    ovn-nbctl lrp-add lr0 lrp0 00:00:00:00:ff:01 10.0.0.1/24
    ovn-nbctl lrp-add lr0 lr0-public 0a:00:20:20:12:13 5.5.5.1/24
    ovn-nbctl ls-add public
    ovn-nbctl lsp-add public ln-public "" $vlan_tag
    ovn-nbctl lsp-set-type ln-public localnet
    ovn-nbctl lsp-set-addresses ln-public unknown
    ovn-nbctl lsp-set-options ln-public network_name=public
    ovn-nbctl clear logical_switch_Port ln-public parent_name
    ovn-nbctl lsp-add public public-lr0
    ovn-nbctl lsp-set-type public-lr0 router
    ovn-nbctl lsp-set-addresses public-lr0 router
    ovn-nbctl lsp-set-options public-lr0 router-port=lr0-public

    mgmt_ip=`hostname -I | awk '{print $1}'`
    ovs-vsctl set open . external_ids:ovn-bridge-mappings="public:br-ex"
    ovs-vsctl set open . external_ids:ovn-encap-type=geneve
    ovs-vsctl set open . external_ids:ovn-encap-ip=$mgmt_ip


    ip netns exec red ip r a default via 10.0.0.1 dev eth0-r


    #On the external network
    ip netns exec green ip r a 192.168.0.0/24 via 5.5.5.1 dev eth0-g

    #Ping between external network(green) to netns red should work
    ip netns exec red ping 5.5.5.4
}
