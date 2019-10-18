{% import_yaml slspath~'/config.yaml' as vault %}

include:
  - formula.vault.install
  - formula.vault.config

"Manage Vault Service File":
  file.managed:
    - name: /etc/systemd/system/vault.service
    - source: salt://{{ slspath }}/files/vault.service
    - template: jinja
    - context:
        log_level: {{ vault.config.log_level }}
        user: {{ vault.user }}
        group: {{ vault.group }}
    - require:
      - sls: formula.vault.install

"Manage Vault Service":
  service.running:
    - name: vault
    - enable: True
    - require:
      - sls: formula.vault.install
      - sls: formula.vault.config
      - file: "Manage Vault Service File"
    - listen:
      - file: "Manage Vault Service File"
