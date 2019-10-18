{% import_yaml slspath~'/config.yaml' as vault %}
{% set version = vault.install.version %}

include:
  - formula.vault.install

"Manage Vault Config":
  file.managed:
    - name: {{ vault.user.home_dir }}/vault.hcl
    - source: salt://{{ slspath }}/files/vault.hcl
    - makedirs: True
    - user: vault
    - group: vault
    - dir_mode: 755
    - template: jinja
    - context:
        config: {{ vault.config|json }}
    - require:
      - sls: formula.vault.install
