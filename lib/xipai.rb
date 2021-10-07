# frozen_string_literal: true

Dir.glob(File.expand_path("xipai/**/*.rb", File.dirname(__FILE__))).each do |mod_name|
  require_relative "#{mod_name}"
end

__END__

