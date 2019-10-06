{% import_yaml slspath~'/config.yaml' as vault %}

"Vault Status":
  cmd.run:
    - name: vault status
    - env:
      - VAULT_ADDR: http://localhost:8200
