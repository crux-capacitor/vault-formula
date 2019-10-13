{% for file in salt.cp.list_master(prefix=slspath~'policies/') %}
{%   if '.sls' not in file %}
{%     set file_name = file %}
{%     set policy_name = file.split('.')[0] %}

"Manage Vault Policy File - {{ policy_name }}":
  file.managed:
    - name: {{ vault.config.policy_dir }}/{{ file_name }}
    - source: salt://{{ slspath }}/policies/{{ file_name }}
    - user: vault
    - group: vault
    - require:
      - sls: formula.vault.user

"Write Vault Policy - {{ policy_name }}":
  cmd.run:
    - name: vault policy write {{ policy_name }} {{ vault.config.policy_dir }}/{{ file_name }}
    - env:
      - VAULT_ADDR: http://localhost:8200
    - onchanges:
      - file: "Manage Vault Policy File - {{ policy_name }}"

{%   endif %}
{% endfor %}