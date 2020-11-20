# deploy a new windows machine in azure

New-AzResourceGroup `
   -ResourceGroupName "myResourceGroupVM" `
   -Location "East US"
   -Force
 
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


########################################
# now onboard this virtual machine     #
########################################
# Define the FQDN for the REST APIs
$FQDN = 'https://comp01.cybr.com'


$logonInfo = @{}

  $logonInfo.username = "dapprovisioning"
  $logonInfo.password = "Cyberark1"
  
  #$logonuser = ConvertFrom-SecureString -SecureString $env:pvwausername -AsPlainText
  #$logonpwd = ConvertFrom-SecureString -SecureString $env:pvwapassword -AsPlainText
  #$logonInfo.username = $logonuser
  #$logonInfo.password = $logonpwd
  
  # get the api logon credentials
# here we will use the dap integration
# to retrieve the api credentials

# We got the creds for the REST APIs so we are good to go!
 "$(Get-Date) Credentials retrieved, logging in to REST APIs"
  

$targetaddress = (Get-AzPublicIpAddress -ResourceGroupName myResourceGroupVM).IpAddress

 "$(Get-Date) test input done "
 
