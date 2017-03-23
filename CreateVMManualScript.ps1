https://docs.microsoft.com/en-us/azure/virtual-machines/virtual-machines-windows-quick-create-powershell
login-azurermaccount
new-azureRmResourceGroup -Name CSAtestRS01 -Location westeurope
$subnetConfig = New-AzureRmVirtualNetworkSubnetConfig -Name CSAtestSubnet01 -AddressPrefix 192.168.1.0/24
$vnet = New-AzureRmVirtualNetwork -ResourceGroupName CSAtestRS01 -Location westeurope -Name CSAtestvNet01 -AddressPrefix 192.168.0.0/16 -Subnet $subnetConfig
$pubip = New-AzureRmPublicIpAddress -ResourceGroupName CSAtestRS01 -Location westeurope -AllocationMethod Static -IdleTimeoutInMinutes 4 -name "mypublicdns$(Get-Random)"
$CSATestnsgRDPRule = New-AzureRmNetworkSecurityRuleConfig -name CSAtestNSGRuleRDP -Protocol Tcp -Direction Inbound -Priority 1000 -SourceAddressPrefix * -SourcePortRange * -DestinationAddressPrefix * -DestinationPortRange 3389 -Access Allow
$CSAtestNSG01 = New-AzureRmNetworkSecurityGroup -ResourceGroupName CSAtestRS01 -Location westeurope -Name CSAtestNSG01 -SecurityRules $CSATestnsgRDPRule