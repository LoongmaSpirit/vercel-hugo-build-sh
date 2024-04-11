#!/bin/bash
set -e

# 获取发行版信息
get_distribution() {
	lsb_dist=""
	if [ -r /etc/os-release ]; then
		lsb_dist="$(. /etc/os-release && echo "$ID")"
	fi
	echo "$lsb_dist"
}

# 安装 go 环境
install_golang() {
    distro="$1"
    case "$distro" in
        "ubuntu" | "debian")
            apt install -y golang
            ;;
        "centos" | "rhel")
            yum install -y golang
            ;;
        "fedora")
            dnf install -y golang
            ;;
        "amzn")
            if command -v dnf &> /dev/null; then
                echo "dnf found. Installing golang using dnf..."
                dnf install -y golang
            else
                echo "dnf not found. Using yum to install golang..."
                yum install -y golang
            fi
            ;;
        "arch")
            pacman -S --noconfirm go
            ;;
        *)
            echo "Unsupported distribution: $distro"
            return 1
            ;;
    esac
    return 0
}

main() {
    distro=$(get_distribution)

    if [ -n "$distro" ]; then
        echo "Detected Linux distribution: $distro"
        install_golang "$distro"
        echo "Golang has been successfully installed."
        chmod +x ./hugo
        ./hugo --gc
    else
        echo "Unable to detect Linux distribution. Script supports Ubuntu, Debian, CentOS, RHEL, Fedora, Amzn and Arch."
        exit 1
    fi
}

# 执行安装
main