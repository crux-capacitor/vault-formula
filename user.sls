{% import_yaml slspath~'/config.yaml' as vault %}
"Manage Vault Group":
  group.present:
    - name: {{ vault.group.name }}

"Manage Vault User":
  user.present:
    - name: {{ vault.user.name }}
    - home: {{ vault.user.home_dir }}
    - createhome: True
    - shell: /bin/false
    - groups:
      - {{ vault.group.name }}
    - require:
      - group: "Manage Vault Group"