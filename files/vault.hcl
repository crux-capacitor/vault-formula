listener "tcp" {
  address = "127.0.0.1:8200"
  cluster_address = "{{ grains['private_ip'] }}:8201
}

{%- if config.seal.enabled %}
seal "{{ config.seal.type }}" {
{%- for option, value in config.seal.options.items() %}
  {{ option }} = "{{ value }}"
{%- endfor %}
}
{%- endif %}

storage "{{ config.storage.type }}" {
{%- for option, value in config.storage.options.items() %}
  {{ option }} = "{{ value }}"
{%- endfor %}
}

ui = {{ config.ui }}
api_addr = "https://{{ grains['private_ip'] }}:8200"
cluster_addr = "https://{{ grains['private_ip'] }}:8201"
