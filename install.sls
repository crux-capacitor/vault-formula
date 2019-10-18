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
    - user: {{ vault.user.name }}
    - group: {{ vault.group.name }}
    - enforce_toplevel: False
    - keep_source: False
    - skip_verify: True
    - if_missing: /root/vault_{{ version }}/vault
    - require:
      - sls: formula.vault.user

"Copy Vault":
  file.copy:
    - name: /usr/local/bin/vault
    - source: /root/vault_{{ version }}/vault
    - user: {{ vault.user.name }}
    - group: {{ vault.group.name }}
    - mode: 0775
    - require:
      - archive: "Extract Vault Archive"
    - require:
        - sls: formula.vault.user