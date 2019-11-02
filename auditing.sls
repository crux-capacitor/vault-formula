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
{%     set audit_dir = vault.auditing.options[type].file_path.split('/')[:-1]|join('/') %}

# If file auditing was selected, first manage the audit directory with proper ownership and permissions.
"Manage Vault Audit Directory":
  file.directory:
    - name: {{ audit_dir }}
    - user: vault
    - group: vault
    - dir_mode: 755
    - file_mode: 644
    - makedirs: True
    - recurse:
      - user
      - group
      - mode
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
    - onlyif: vault status | grep Sealed | grep false
    - require:
      - sls: formula.vault.install
      - sls: formula.vault.service
