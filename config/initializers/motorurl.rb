Motorurl.configure do |c|
  c.canonical_name   = 'spidey_sense'           # A unique string
  c.cost_in_thousandths = 0                     # cost_in_thousandths in thousands of a cent
  c.endpoint_url     = 'http://localhost:3002'  # The URL of this sensor
  c.friendly_name    = 'Spidey Sense'           # Name of the sensor
  c.patterns         = Array(/.*/)              # A matching pattern to limit to suitable URLs
  c.sensor_job_class = 'SpideySenseJob'         # The job class to perform analysis
  c.shared_secret    = 'fwcelshoeebav53p'       # Run rake motorurl:generate to create a key
  c.spiderman        = 'http://localhost:3000'  # The URL of Spiderman
  c.version          = '0.0.1'                  # The version of the sensor
end
