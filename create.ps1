# deploy a new windows machine in azure

New-AzResourceGroup `
   -ResourceGroupName "myResourceGroupVM" `
   -Location "East US"
 
# temp password that will be changed afer onboarding

  $username = "breakglass"
  $PW = [System.Web.Security.Membership]::GeneratePassword(24,0)
  $password = ConvertTo-SecureString $PW -AsPlainText -Force
  $Cred = New-Object System.Management.Automation.PSCredential($username, $password)
   

New-AzVm `
    -ResourceGroupName "myResourceGroupVM" `
    -Name "myVM" `
    -Location "East US" `
    -VirtualNetworkName "myVnet" `
    -SubnetName "mySubnet" `
    -SecurityGroupName "myNetworkSecurityGroup" `
    -PublicIpAddressName "myPublicIpAddress" `
    -OpenPorts 80,3389,139,445 `
    -Credential $Cred 

"$(Get-Date) azure resource created succesfully"

"$(Get-AzPublicIpAddress -Name myPublicIpAddress -ResourceGroupName myResourceGroupVM)"
(Get-AzPublicIpAddress -ResourceGroupName myResourceGroupVM).IpAddress



