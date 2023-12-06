# config/initializers/default_meta.rb

# Initialise les balises méta par défaut.
DEFAULT_META = YAML.load_file(Rails.root.join("config/meta.yml"))
