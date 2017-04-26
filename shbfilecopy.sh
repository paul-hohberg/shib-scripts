#!/bin/bash                                                                                                         

cd /usr/local/ALM/staging

for file in *; do
  if [[ "$file" = *metadata* && -N "$file" ]]; then
    cp $file /opt/shibboleth-idp/metadata/
    elif [[ "$file" != *metadata* && -N "$file" ]]; then
    cp $file /opt/shibboleth-idp/conf/
  fi
done

cd /usr/local/SATcopy/qa/dist

for file in *; do
  if [[ "$file" = *metadata* && -N "$file" ]]; then
    cp $file /opt/shibboleth-idp/metadata/
    elif [[ "$file" != *metadata* && -N "$file" ]]; then
    cp $file /opt/shibboleth-idp/conf/
  fi
done
exit