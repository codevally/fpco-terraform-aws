#!/bin/bash

set -x

if [ -z "${depot_path}" ]; then
  DEPOT_PATH=$$(mktemp -d)
else
  DEPOT_PATH="${depot_path}"
fi

CA_CREATE="false"
if [ ${ca_force_new} -ne 0 ]; then
  CA_CREATE="true"
fi

# Check if CA SSL already exist locally or on AWS
if [ "$CA_CREATE" = "false" ]; then
  if [ ! -e "$DEPOT_PATH/${ca_common_name}.crt" ]; then
    ${credstash_get_cmd} -a "${ca_cert_name}" > "$DEPOT_PATH/${ca_common_name}.crt" || \
      CA_CREATE="true"
  fi
  if [ ! -e "$DEPOT_PATH/${ca_common_name}.key" ]; then
    ${credstash_get_cmd} -a "${ca_key_name}" > "$DEPOT_PATH/${ca_common_name}.key" || \
      CA_CREATE="true"
  fi
fi
if [ "$CA_CREATE" = "false" ]; then
  # Here we already have an existing CA cert and key, so need to check if it aligns with a supplied CN
  CURRENT_CA_CN=openssl x509 -noout -subject -in "$DEPOT_PATH/${ca_common_name}.crt" | awk -F "/CN=" '{print $2}'
  test "$CURRENT_CA_CN" == "${ca_common_name}" || CA_CREATE="true"
fi

# If we still do need to create new CA, get rid of any previously created or
# downloaded one and generate new SSL CA Certificate and Key
if [ "$CA_CREATE" = "true" ]; then
  rm -f "$DEPOT_PATH/${ca_common_name}.crt" "$DEPOT_PATH/${ca_common_name}.key"
  certstrap --depot-path "$DEPOT_PATH" init --common-name "${ca_common_name}" --passphrase "${ca_passphrase}"
fi

# Remove any old certificate
rm -f "$DEPOT_PATH/${domain_name}.crt" \
   "$DEPOT_PATH/${domain_name}.csr" \
   "$DEPOT_PATH/${domain_name}.key"

certstrap --depot-path "$DEPOT_PATH" request-cert --domain "${domain_name}" --passphrase ""
certstrap --depot-path "$DEPOT_PATH" sign "${domain_name}" --CA "${ca_common_name}" --passphrase "${ca_passphrase}"

# Convert into PKCS8 format.

openssl pkcs8 -topk8 -inform PEM -outform PEM -nocrypt -in "$DEPOT_PATH/${domain_name}.key" -out "$DEPOT_PATH/${domain_name}.pkcs8.key"

${credstash_put_cmd} -a "${ca_cert_name}" "@$DEPOT_PATH/${ca_common_name}.crt"
${credstash_put_cmd} -a "${ca_key_name}" "@$DEPOT_PATH/${ca_common_name}.key"
${credstash_put_cmd} -a "${server_cert_name}" "@$DEPOT_PATH/${domain_name}.crt"
${credstash_put_cmd} -a "${server_key_name}" "@$DEPOT_PATH/${domain_name}.pkcs8.key"

# Remove a folder with generated certificates if it was in fact a temporary folder
if [ -z "${depot_path}" ]; then
  chmod -R u+Xrw "$DEPOT_PATH"
  rm -R "$DEPOT_PATH"
fi