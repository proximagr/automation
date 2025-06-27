#!/usr/bin/env bash
set -e

#––––– 1. Variables you can tweak –––––#
rg="azclitests"
location="germanywestcentral"

# Parallel arrays – keep indices aligned
vnet_names=( "hub-vnet"   "spoke1-vnet"   "spoke2-vnet" )
vnet_addrs=( "10.0.0.0/16" "10.1.0.0/16"  "10.2.0.0/16" )
subnet_names=( "default"  "default"      "default" )
subnet_addrs=( "10.0.0.0/24" "10.1.0.0/24" "10.2.0.0/24" )

#––––– 2. Resource-group –––––#
az group create --name "$rg" --location "$location"

#––––– 3. Create each VNet + subnet –––––#
for i in "${!vnet_names[@]}"; do
  az network vnet create \
    --resource-group "$rg" \
    --location "$location" \
    --name "${vnet_names[$i]}" \
    --address-prefixes "${vnet_addrs[$i]}" \
    --subnet-name "${subnet_names[$i]}" \
    --subnet-prefixes "${subnet_addrs[$i]}"
done

#––––– 4. Collect the VNet resource IDs (needed for peering) –––––#
declare -A vnet_ids
for vnet in "${vnet_names[@]}"; do
  vnet_ids["$vnet"]=$(az network vnet show -g "$rg" -n "$vnet" --query id -o tsv)
done

#––––– 5. Create two-way peerings (full mesh) –––––#
for i in "${!vnet_names[@]}"; do
  for j in "${!vnet_names[@]}"; do
    if [[ $i -lt $j ]]; then
      vnet_a="${vnet_names[$i]}"
      vnet_b="${vnet_names[$j]}"

      # A → B
      az network vnet peering create \
        --name "${vnet_a}-to-${vnet_b}" \
        --resource-group "$rg" \
        --vnet-name "$vnet_a" \
        --remote-vnet "${vnet_ids[$vnet_b]}" \
        --allow-vnet-access

      # B → A
      az network vnet peering create \
        --name "${vnet_b}-to-${vnet_a}" \
        --resource-group "$rg" \
        --vnet-name "$vnet_b" \
        --remote-vnet "${vnet_ids[$vnet_a]}" \
        --allow-vnet-access
    fi
  done
done
