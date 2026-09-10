export subscriptionId="c02cad9f-1ac6-4121-911a-efeb71ff43d6";
export resourceGroup="RG-Taukir";
export tenantId="5f55f95d-95ef-4004-ada2-f1a8ea7c5dcc";
export location="eastus";
export authType="token";
export correlationId="5f9fa7d4-921f-4178-8753-b06a188c837d";
export cloud="AzureCloud";
LINUX_INSTALL_SCRIPT="/tmp/install_linux_azcmagent.sh"
if [ -f "$LINUX_INSTALL_SCRIPT" ]; then rm -f "$LINUX_INSTALL_SCRIPT"; fi;
output=$(wget https://gbl.his.arc.azure.com/azcmagent-linux -O "$LINUX_INSTALL_SCRIPT" 2>&1);
if [ $? != 0 ]; then wget -qO- --method=PUT --body-data="{\"subscriptionId\":\"$subscriptionId\",\"resourceGroup\":\"$resourceGroup\",\"tenantId\":\"$tenantId\",\"location\":\"$location\",\"correlationId\":\"$correlationId\",\"authType\":\"$authType\",\"operation\":\"onboarding\",\"messageType\":\"DownloadScriptFailed\",\"message\":\"$output\"}" "https://gbl.his.arc.azure.com/log" &> /dev/null || true; fi;
echo "$output";
bash "$LINUX_INSTALL_SCRIPT";
sleep 5;
sudo azcmagent connect --resource-group "$resourceGroup" --tenant-id "$tenantId" --location "$location" --subscription-id "$subscriptionId" --cloud "$cloud" --enable-automatic-upgrade --correlation-id "$correlationId";