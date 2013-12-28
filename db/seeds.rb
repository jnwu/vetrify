# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Seed keys for various APIs
Key.create(api: 'linkedin', tag: 'client_id', key: '75qairvgqfo2xn')
Key.create(api: 'linkedin', tag: 'client_secret', key: 'V2l4Rn3Efm2SW100')

Key.create(api: 'github', tag: 'client_id', key: '010d4e6a46d2d8deaf0b')
Key.create(api: 'github', tag: 'client_secret', key: '5d59eb9a1b77eecbe43c77c7cce704e0a960cfd4')

Key.create(api: 'bitbucket', tag: 'client_key', key: 'TkgNpQN56jB4k8NjSA')
Key.create(api: 'bitbucket', tag: 'client_secret', key: 'qGQ5rEjs6RFxbaBc8XcTEkAjhmHegRje')

Key.create(api: 'stackexchange', tag: 'client_id', key: '2360')
Key.create(api: 'stackexchange', tag: 'client_secret', key: 'RSO5CfbTMPeq3h69WHTerA((')
Key.create(api: 'stackexchange', tag: 'client_key', key: 'WbOvuO5gZPfhNMyq5vAWbQ((')

Key.create(api: 'google_oauth2', tag: 'client_id', key: '1097687311357')
Key.create(api: 'google_oauth2', tag: 'client_secret', key: 'AIzaSyBfRaaCcBu7pSEZw7uLamvocxe8T4aZx2g')

Key.create(api: 'amqp', tag: 'username', key: 'tmdgqatb')
Key.create(api: 'amqp', tag: 'password', key: 'tCD4Lbac_cUzDG1XmEuCrbOepdaM3WNz')

Key.create(api: 'pandastream', tag: 'client_key', key: 'ed586f896c620b57f884')
Key.create(api: 'pandastream', tag: 'client_secret', key: 'bcb6256fb005f355c303')