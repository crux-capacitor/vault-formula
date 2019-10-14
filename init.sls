{% import_yaml slspath~'/config.yaml' as vault %}

include:
  - formula.vault.user
  - formula.vault.install
  - formula.vault.config
  - formula.vault.service
  - formula.vault.initialize
  - formula.vault.policies
{%- if vault.auditing.enabled %}
  - formula.vault.auditing
{%- endif %}

extend:
  "Manage Vault Service":
    service:
      - listen:
        - file: "Manage Vault Config"
