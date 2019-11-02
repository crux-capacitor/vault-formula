{% import_yaml slspath~'/config.yaml' as vault %}
{% set version = vault.install.version %}

include:
  - formula.vault.install

{% if vault.config.storage.type == "file" %}

"Manage Vault Storage Directory":
  file.directory:
    - name: {{ vault.config.storage.options.file.path }}
    - user: {{ vault.user.name }}
    - group: {{ vault.group.name }}
    - dir_mode: 755
    - file_mode: 644
    - makedirs: True
    - recurse:
      - user
      - group
      - mode

{% endif %}

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
