# packer
Some of my packer builds

## Azure
[Help With Azure](https://docs.microsoft.com/en-us/azure/virtual-machines/windows/build-image-with-packer)

## AWS
I had problems with AWS and winrm, the solution was to create a security group that allowed WinRM over http/https (Ports 5985/5986) and a script to enable WinRM on the VM itself.

[Help With AWS WinRM](https://gist.github.com/zachtuttle/6a9d05e40c9a6b6c51bd6dc93e05c8a4)
