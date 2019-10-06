{% import_yaml slspath~'/config.yaml' as vault %}

# If auto_unseal is enabled, override whatever settings are in the config.yaml
# for recovery_shares and recovery_threshold to 1 and 1.
{% if vault.initialize.auto_unseal.enabled %}
{%   set rec_shares = '1' %}
{%   set rec_thold = '1' %}
{% else %}
{%   set rec_shares = vault.initialize.recovery_shares %}
{%   set rec_thold = vault.initialize.recovery_threshold %}
{% endif %}

include:
  - formula.vault.install

"Initialize Vault":
  file.directory:
    - name: /root/vault/
  cmd.run:
    - name: vault operator init -recovery-shares={{ rec_shares }} -recovery-threshold={{ rec_thold }} | tee -a /root/vault/initialize.txt
    - env:
      - VAULT_ADDR: http://localhost:8200
    - creates: /root/vault/initialize.txt
    - unless: vault status | grep Initialized | grep true
    - require:
      - file: "Initialize Vault"
      - sls: formula.vault.install