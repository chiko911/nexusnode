#!/bin/bash

# Скрипт установки ноды Nexus для Ubuntu

# Проверка прав root
if [[ $EUID -ne 0 ]]; then
   echo "Этот скрипт должен быть запущен с правами root" 
   exit 1
fi

# Обновление системы
echo "Обновление системы..."
apt update && apt upgrade -y

# Установка необходимых компонентов
echo "Установка необходимых компонентов..."
apt install -y \
    build-essential \
    pkg-config \
    libssl-dev \
    git-all \
    protobuf-compiler \
    cargo \
    screen

# Установка Rust с автоматическим согласием
echo "Установка Rust..."
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

# Настройка переменных окружения Rust
export PATH="$HOME/.cargo/bin:$PATH"
source $HOME/.cargo/env
echo 'export PATH="$HOME/.cargo/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc

# Обновление Rust
rustup update

# Создание и подключение screen-сессии для Nexus
echo "Создание screen-сессии и запуск установки Nexus..."
screen -S nexus
