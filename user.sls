"Manage Vault Group":
  group.present:
    - name: vault

"Manage Vault User":
  user.present:
    - name: vault
    - home: /etc/vault.d/
    - createhome: True
    - shell: /bin/false
    - groups:
      - vault
    - require:
      - group: "Manage Vault Group"