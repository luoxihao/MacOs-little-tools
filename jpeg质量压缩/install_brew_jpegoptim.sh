#!/bin/bash

# 检查是否已经安装 Homebrew
if command -v brew >/dev/null 2>&1; then
    echo "Homebrew 已经安装。"
else
    echo "Homebrew 未安装，正在进行安装..."

    # 确保系统上安装了 Xcode 命令行工具（适用于 macOS）
    if [[ "$(uname)" == "Darwin" ]]; then
        if ! xcode-select -p >/dev/null 2>&1; then
            echo "Xcode 命令行工具未安装，正在安装..."
            xcode-select --install
        else
            echo "Xcode 命令行工具已安装。"
        fi
    fi

    # 使用国内镜像源安装 Homebrew
    /bin/bash -c "$(curl -fsSL https://gitee.com/cunkai/HomebrewCN/raw/master/Homebrew.sh)"
    
    # 设置 Homebrew 环境变量（适用于 macOS）
    if [[ "$(uname)" == "Darwin" ]]; then
        echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi

    # 设置 Homebrew 环境变量（适用于 Linux）
    if [[ "$(uname)" == "Linux" ]]; then
        echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> ~/.profile
        eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    fi

    echo "Homebrew 安装完成。"
fi

# 根据提示添加的
if [ -f "$HOME/.zprofile" ]; then
    source "$HOME/.zprofile"
else
    echo "未找到 $HOME/.zprofile 文件"
fi

# 使用 Homebrew 安装 jpegoptim
if brew list jpegoptim >/dev/null 2>&1; then
    echo "jpegoptim 已经安装。"
else
    echo "正在安装 jpegoptim..."
    
    # 使用国内源安装 jpegoptim
    brew install jpegoptim
    
    echo "jpegoptim 安装完成。"
fi

# 验证安装
echo "验证安装..."
if command -v jpegoptim >/dev/null 2>&1; then
    echo "jpegoptim 已成功安装。"
else
    echo "jpegoptim 安装失败。"
fi
