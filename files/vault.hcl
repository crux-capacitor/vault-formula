listener "{{ config.listener.type }}" {
  address = "127.0.0.1:8200"
  cluster_address = "{{ grains['private_ip'] }}:8201"
{%- for option, value in config.listener.options.items() %}
  {{ option }} = "{{ value }}"
{%- endfor %}
}

{%- if config.seal.enabled %}
seal "{{ config.seal.type }}" {
{%- for option, value in config.seal.options[config.seal.type].items() %}
  {{ option }} = "{{ value }}"
{%- endfor %}
}
{%- endif %}

storage "{{ config.storage.type }}" {
{%- for option, value in config.storage.options[config.storage.type].items() %}
  {{ option }} = "{{ value }}"
{%- endfor %}
}

ui = {{ config.ui }}
api_addr = "https://{{ grains['private_ip'] }}:8200"
cluster_addr = "https://{{ grains['private_ip'] }}:8201"
