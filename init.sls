include:
  - formula.vault.user
  - formula.vault.install
  - formula.vault.initialize
  - formula.vault.config
  - formula.vault.service
  - formula.vault.policies

extend:
  "Manage Vault Service":
    service:
      - listen:
        - file: "Manage Vault Config"
