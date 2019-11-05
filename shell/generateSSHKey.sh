#!/bin/bash
ssh-keygen -t rsa -b 4096 -C $1

echo 如果openssh private key 应用不支持，可以使用
echo ssh-keygen -p -m PEM -f ~/.ssh/id_ras 来转换