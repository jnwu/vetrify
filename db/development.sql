-- uncomment to reset database
-- DROP TABLE accounts;
-- DROP TABLE keys;

--	accounts
--
--	storage table for LinkedIn user access token
--
--	id:			primary key
-- 	email:		user email, primary key
--	token:		LinkedIn access token
--	register:	register date
-- 	expire:		expire date (60 days after register date)
CREATE TABLE accounts (
    id SERIAL,
    email VARCHAR(255) NOT NULL,
    token VARCHAR(255) NOT NULL,
    register TIMESTAMP NOT NULL,
    expire TIMESTAMP NOT NULL,
    PRIMARY KEY (id, email)
);

--	keys
--
--	private table for all keys used in app
--
--	id:		primary key
--	key:	api token/key, primary key
--	tag:	api token/key descriptions
CREATE TABLE keys (
    id SERIAL,
    api VARCHAR(255) NOT NULL,
    tag VARCHAR(255) NOT NULL,
    key VARCHAR(255) NOT NULL,
    PRIMARY KEY (id, key)
);

-- insert LinkedIn client_id, client_secret, and state
INSERT INTO keys (api, tag, key) VALUES ('linkedin', 'state', 'DCEEFWF45453sdffef424');
INSERT INTO keys (api, tag, key) VALUES ('linkedin', 'client_id', 'tyeecw8cwrir');
INSERT INTO keys (api, tag, key) VALUES ('linkedin', 'client_secret', 'd3jYZGnQ7aZtrNMd');
INSERT INTO keys (api, tag, key) VALUES ('mandrill', 'key', 'bb119a5e38dbb0777ebcad4f6f9309b3-us3');
INSERT INTO keys (api, tag, key) VALUES ('rabbitmq', 'vhost', 'qmzcskom');
INSERT INTO keys (api, tag, key) VALUES ('rabbitmq', 'password', 'NMwqZbAR8jvAF2x0LkTUlP8cuOtN4Sux');

-- disallows certain operations on tables
CREATE RULE keys_delete_protect AS ON DELETE TO keys DO INSTEAD NOTHING;
CREATE RULE keys_insert_protect AS ON INSERT TO keys DO INSTEAD NOTHING;
CREATE RULE keys_update_protect AS ON UPDATE TO keys DO INSTEAD NOTHING;
CREATE RULE accounts_delete_protect AS ON DELETE TO accounts DO INSTEAD NOTHING;