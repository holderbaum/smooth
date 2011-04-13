# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{smooth}
  s.version = "1.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Jakob Holderbaum"]
  s.date = %q{2011-04-13}
  s.default_executable = %q{smooth}
  s.description = %q{extends haml with useful helpers, a layout concept and rails-partial like components.}
  s.email = %q{jh@neopoly.de}
  s.executables = ["smooth"]
  s.extra_rdoc_files = [
    "README.md"
  ]
  s.files = [
    ".rvmrc",
    ".yardopts",
    "Gemfile",
    "Gemfile.lock",
    "README.md",
    "Rakefile",
    "VERSION",
    "bin/smooth",
    "lib/smooth.rb",
    "lib/smooth/cli.rb",
    "lib/smooth/config.rb",
    "lib/smooth/helpers.rb",
    "lib/smooth/helpers/about.rb",
    "lib/smooth/helpers/assets.rb",
    "lib/smooth/helpers/code.rb",
    "lib/smooth/helpers/components.rb",
    "lib/smooth/helpers/content_store.rb",
    "lib/smooth/helpers/layout.rb",
    "lib/smooth/helpers/slides.rb",
    "lib/smooth/helpers/style.rb",
    "lib/smooth/renderer.rb",
    "share/assets/img/default-bg.jpg",
    "share/assets/js/jquery-1.5.1.min.js",
    "share/assets/js/jquery.centreinwindow.js",
    "share/assets/js/jquery.tools.min.js",
    "share/assets/style/default.css",
    "share/assets/style/uv/active4d.css",
    "share/assets/style/uv/all_hallows_eve.css",
    "share/assets/style/uv/amy.css",
    "share/assets/style/uv/blackboard.css",
    "share/assets/style/uv/brilliance_black.css",
    "share/assets/style/uv/brilliance_dull.css",
    "share/assets/style/uv/cobalt.css",
    "share/assets/style/uv/dawn.css",
    "share/assets/style/uv/eiffel.css",
    "share/assets/style/uv/espresso_libre.css",
    "share/assets/style/uv/idle.css",
    "share/assets/style/uv/iplastic.css",
    "share/assets/style/uv/lazy.css",
    "share/assets/style/uv/mac_classic.css",
    "share/assets/style/uv/magicwb_amiga.css",
    "share/assets/style/uv/pastels_on_dark.css",
    "share/assets/style/uv/slush_poppies.css",
    "share/assets/style/uv/spacecadet.css",
    "share/assets/style/uv/sunburst.css",
    "share/assets/style/uv/twilight.css",
    "share/assets/style/uv/zenburnesque.css",
    "share/components/section.haml",
    "share/components/slide.haml",
    "share/components/slides.haml",
    "share/components/title.haml",
    "share/layouts/default.haml",
    "smooth.gemspec",
    "test.watchr",
    "test/cli_test.rb",
    "test/config_test.rb",
    "test/fixtures/assets/dir/file1",
    "test/fixtures/assets/dir/subdir/fileX",
    "test/fixtures/cli_test/img/default-bg.jpg",
    "test/fixtures/cli_test/index.html",
    "test/fixtures/cli_test/js/jquery-1.5.1.min.js",
    "test/fixtures/cli_test/js/jquery.centreinwindow.js",
    "test/fixtures/cli_test/js/jquery.tools.min.js",
    "test/fixtures/cli_test/style/default.css",
    "test/fixtures/cli_test/style/uv/blackboard.css",
    "test/fixtures/cli_test/template.haml",
    "test/fixtures/components/path1/comp1.haml",
    "test/fixtures/components/path1/missing.haml",
    "test/fixtures/components/path1/with_block.haml",
    "test/fixtures/components/path1/with_block_and_arg.haml",
    "test/fixtures/components/path1/with_block_and_arg_and_title.haml",
    "test/fixtures/components/path1/with_block_and_title.haml",
    "test/fixtures/components/path2/comp2.haml",
    "test/fixtures/layouts/path1/test1.haml",
    "test/fixtures/layouts/path2/test2.haml",
    "test/fixtures/test_dir/.gitkeep",
    "test/helper.rb",
    "test/helpers_about_test.rb",
    "test/helpers_assets_test.rb",
    "test/helpers_code_test.rb",
    "test/helpers_components_test.rb",
    "test/helpers_content_store_test.rb",
    "test/helpers_layout_test.rb",
    "test/helpers_slides_test.rb",
    "test/helpers_style_test.rb",
    "test/renderer_test.rb"
  ]
  s.homepage = %q{http://techfolio.de}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.6.2}
  s.summary = %q{create nice haml slides (powered by slippy)}
  s.test_files = [
    "test/cli_test.rb",
    "test/config_test.rb",
    "test/helper.rb",
    "test/helpers_about_test.rb",
    "test/helpers_assets_test.rb",
    "test/helpers_code_test.rb",
    "test/helpers_components_test.rb",
    "test/helpers_content_store_test.rb",
    "test/helpers_layout_test.rb",
    "test/helpers_slides_test.rb",
    "test/helpers_style_test.rb",
    "test/renderer_test.rb"
  ]

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<haml>, [">= 0"])
      s.add_runtime_dependency(%q<ultraviolet>, [">= 0"])
      s.add_runtime_dependency(%q<thor>, [">= 0"])
      s.add_development_dependency(%q<jeweler>, [">= 0"])
      s.add_development_dependency(%q<yard>, [">= 0"])
      s.add_development_dependency(%q<RedCloth>, [">= 0"])
      s.add_development_dependency(%q<BlueCloth>, [">= 0"])
    else
      s.add_dependency(%q<haml>, [">= 0"])
      s.add_dependency(%q<ultraviolet>, [">= 0"])
      s.add_dependency(%q<thor>, [">= 0"])
      s.add_dependency(%q<jeweler>, [">= 0"])
      s.add_dependency(%q<yard>, [">= 0"])
      s.add_dependency(%q<RedCloth>, [">= 0"])
      s.add_dependency(%q<BlueCloth>, [">= 0"])
    end
  else
    s.add_dependency(%q<haml>, [">= 0"])
    s.add_dependency(%q<ultraviolet>, [">= 0"])
    s.add_dependency(%q<thor>, [">= 0"])
    s.add_dependency(%q<jeweler>, [">= 0"])
    s.add_dependency(%q<yard>, [">= 0"])
    s.add_dependency(%q<RedCloth>, [">= 0"])
    s.add_dependency(%q<BlueCloth>, [">= 0"])
  end
end

