def read_fixture(fixture, source = 'spec/fixtures/files')
  directory = File.join Rails.root, source
  contents  = IO.read File.join(directory, fixture)
end
