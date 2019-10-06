include:
  - formula.vault.install
  - formula.vault.config

"Manage Vault Service File":
  file.managed:
    - name: /etc/systemd/system/vault.service
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
