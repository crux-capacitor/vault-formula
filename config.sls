{% import_yaml slspath~'/config.yaml' as vault %}
{% set version = vault.install.version %}

include:
  - formula.vault.install

"Manage Vault Config File":
  file.managed:
    - name: /etc/vault.d/vault.hcl
    - source: salt://{{ slspath }}/files/vault.hcl
    - makedirs: True
    - user: vault
    - group: vault
    - dir_mode: 755
    - template: jinja
    - context:
        config: {{ vault.config }}
    - require:
      - sls: formula.vault.install
