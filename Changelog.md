1.0.0
  * Upgrade gem to use transilien_microservice 1.0.0. Now we're on semver, will be easier for fixes.

0.0.9
  * For some unknown reason, specs failed on 2.0.0-p247 w/o module explicit prefix

0.0.8
  * Apply Time boundaries management in Stop#time, like in transilien_microservices

0.0.7
  * bump transilien_microservices v0.0.7

0.0.6
  * skipped version, to match transilien_microservices gem versionning

0.0.5
  * Handle options[:at] and options[:last] as promise by the doc
  * Add Trip#last to be consitant
  * Trip#find auto correct when at is after last
  * TripSpec
