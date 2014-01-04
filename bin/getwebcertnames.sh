#! /bin/bash
# Show all the names (CNs and SANs) listed in the SSL certificate
# for a given domain
    if [ -z "${1}" ]; then
        echo "ERROR: No domain specified."
        exit 1
    fi
    if [ -z `which openssl` ]; then
        echo "ERROR: Needs openssl client to work."
        exit 2
    fi

    domain="${1}"
    echo "Testing ${domain}…"
    echo # newline

    tmp=$(echo -e "GET / HTTP/1.0\nEOT" \
            | openssl s_client -connect "${domain}:443" 2>&1);

    if [[ "${tmp}" = *"-----BEGIN CERTIFICATE-----"* ]]; then
            certText=$(echo "${tmp}" \
                | openssl x509 -text -certopt "no_header, no_serial, no_version, \
                no_signame, no_validity, no_issuer, no_pubkey, no_sigdump, no_aux");
                echo "Common Name:"
                echo "${certText}" | grep "Subject:" | sed -e "s/^.*CN=//";
                echo # newline
                echo "Subject Alternative Name(s):"
                echo "${certText}" | grep -A 1 "Subject Alternative Name:" \
                        | sed -e "2s/DNS://g" -e "s/ //g" | tr "," "\n" | tail -n +2
            exit 0
    else
            echo "ERROR: Certificate not found.";
            exit 1
    fi
