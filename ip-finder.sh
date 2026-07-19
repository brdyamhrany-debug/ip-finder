#!/bin/bash

# IP Finder Script
# A simple tool to fetch the IP address of any domain.

# Colors for better UI
GREEN='\033[0;32m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}=======================================${NC}"
echo -e "${BLUE}       🌐 WEBSITE IP FINDER           ${NC}"
echo -e "${BLUE}======================================${NC}"

echo -e "Enter the website URL (e.g., https://google.com):"
read -r url

# Remove protocol and extra paths using sed
domain=$(echo "$url" | sed -e 's|https\?://||' -e 's|[/].*||')

if [[ -z "$domain" ]]; then
    echo -e "${RED}❌ Error: Invalid URL provided.${NC}"
    exit 1
fi

echo -e "\n🔍 Fetching IP address for: ${GREEN}$domain${NC} ..."
# Try fetching IP using dig
ip=$(dig +short "$domain" 2>/dev/null | head -1)

# If dig fails, try nslookup
if [[ -z "$ip" ]]; then
    ip=$(nslookup "$domain" 2>/dev/null | awk '/^Address: / { print $2 }' | tail -n1)
fi

echo -e "${BLUE}---------------------------------------${NC}"

if [[ -z "$ip" ]]; then
    echo -e "${RED}❌ Error: Could not retrieve IP address for $domain${NC}"
    echo -e "${BLUE}💡 Hint: Make sure 'dnsutils' is installed (pk install dnsutils)${NC}"
    exit 1
else
    echo -e "${GREEN}✅ Success!${NC}"
    echo -e "🌐 Domain: $domain"
    echo -e "📍 IP Address: ${GRE}$ip${NC}"
fi

echo -e "${BLUE}=======================================${NC}"
