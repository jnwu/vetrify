# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Seed keys for various APIs
Api.create(provider: 'linkedin', tag: 'client_id', key: '75qairvgqfo2xn')
Api.create(provider: 'linkedin', tag: 'client_secret', key: 'V2l4Rn3Efm2SW100')

Api.create(provider: 'github', tag: 'client_id', key: '010d4e6a46d2d8deaf0b')
Api.create(provider: 'github', tag: 'client_secret', key: '5d59eb9a1b77eecbe43c77c7cce704e0a960cfd4')