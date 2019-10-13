{% import_yaml slspath~'/config.yaml' as vault %}
{% set version = vault.install.version %}

include:
  - formula.vault.user

"Extract Vault Archive":
  archive.extracted:
    - name: /root/vault_{{ version }}/
    - source: salt://{{ slspath }}/installers/vault-{{ version }}_linux_amd64.zip
    - makedirs: True
    - keep_source: False
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