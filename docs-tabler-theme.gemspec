# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name          = "docs-tabler-theme"
  spec.version       = "0.1.0"
  spec.authors       = ["docs-tabler-theme contributors"]
  spec.summary       = "A Tabler-based Jekyll theme with a fixed responsive navbar, dropdown navigation, site search, and a sticky collapsible table-of-contents sidebar."
  spec.homepage      = "https://github.com/lucasmenendez/docs-tabler-theme"
  spec.license       = "AGPL-3.0"
  spec.files         = Dir.glob("_layouts/**/*") + Dir.glob("_includes/**/*") + Dir.glob("assets/**/*") + ["_config.yml", "LICENSE", "README.md"]
  spec.required_ruby_version = ">= 2.6.0"
  spec.add_runtime_dependency "jekyll", ">= 3.9", "< 5.0"
end