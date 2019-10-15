{% import_yaml slspath~'/config.yaml' as vault %}
{% set version = vault.install.version %}

include:
  - formula.vault.user

"Extract Vault Archive":
  archive.extracted:
    - name: /root/vault_{{ version }}/
    - source: 
        - https://releases.hashicorp.com/vault/{{ version }}/vault_{{ version }}_linux_amd64.zip
        - salt://{{ slspath }}/installers/vault_{{ version }}_linux_amd64.zip
    - enforce_toplevel: False
    - keep_source: False
    - skip_verify: True
    - if_missing: /root/vault_{{ version }}/vault
    - require:
      - sls: formula.vault.user

"Symlink Vault":
  file.symlink:
    - name: /usr/local/bin/vault
    - target: /root/vault_{{ version }}/vault
    - onchanges:
      - archive: "Extract Vault Archive"
    - require:
        - sls: formula.vault.user