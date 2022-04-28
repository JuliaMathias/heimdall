# Heimdall


## Domain modeling

### Schemata

PrivateData

* uuid

* encrypted_text

* symmetric encryption algo (default aes)

* ttl (in seconds)

### Storage

No database; Elixir Processes (Agent)
