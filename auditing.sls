{% import_yaml slspath~'/config.yaml' as vault %}
{% set type = vault.auditing.type %}

include:
  - formula.vault.install
  - formula.vault.service

# Create an array of the options that were configured in config.yaml for the chosen audit type.
{%   set options = [] %}
{%   for k,v in vault.auditing.options[type].items() %}
{%     set line = [k,v]|join('=') %}
{%     do options.append(line) %}
{%   endfor %}

{%   if type == "file" %}

# If file auditing was selected, first manage the audit directory with proper ownership and permissions.
"Manage Vault Audit Directory":
  file.directory:
    - name: {{ vault.auditing.options[type].audit_directory }}
    - user: vault
    - group: vault
    - dir_mode: 755
    - file_mode: 600
    - require_in:
      - cmd: "Enable Vault Auditing"
    - require:
      - sls: formula.vault.install

{%   endif %} # end if type == "file"

"Enable Vault Auditing":
  cmd.run:
    - name: vault audit enable {{ type }} {{ options|join(' ') }}
    - env:
      - VAULT_ADDR: http://localhost:8200
    - unless: vault audit list | grep {{ type }}
    - require:
      - sls: formula.vault.install
      - sls: formula.vault.service
