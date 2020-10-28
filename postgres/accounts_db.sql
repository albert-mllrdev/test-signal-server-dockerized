-- Adminer 4.7.7 PostgreSQL dump

\connect "accounts_db";

CREATE TABLE "public"."accounts" (
    "id" bigint DEFAULT GENERATED BY DEFAULT AS IDENTITY NOT NULL,
    "number" character varying(255) NOT NULL,
    "data" json NOT NULL,
    "uuid" uuid,
    CONSTRAINT "accounts_number_key" UNIQUE ("number"),
    CONSTRAINT "accounts_pkey" PRIMARY KEY ("id"),
    CONSTRAINT "uuid_index" UNIQUE ("uuid")
) WITH (oids = false);


CREATE TABLE "public"."databasechangelog" (
    "id" character varying(255) NOT NULL,
    "author" character varying(255) NOT NULL,
    "filename" character varying(255) NOT NULL,
    "dateexecuted" timestamp NOT NULL,
    "orderexecuted" integer NOT NULL,
    "exectype" character varying(10) NOT NULL,
    "md5sum" character varying(35),
    "description" character varying(255),
    "comments" character varying(255),
    "tag" character varying(255),
    "liquibase" character varying(20),
    "contexts" character varying(255),
    "labels" character varying(255),
    "deployment_id" character varying(10)
) WITH (oids = false);


CREATE TABLE "public"."databasechangeloglock" (
    "id" integer NOT NULL,
    "locked" boolean NOT NULL,
    "lockgranted" timestamp,
    "lockedby" character varying(255),
    CONSTRAINT "databasechangeloglock_pkey" PRIMARY KEY ("id")
) WITH (oids = false);


CREATE TABLE "public"."keys" (
    "id" bigint DEFAULT GENERATED BY DEFAULT AS IDENTITY NOT NULL,
    "number" character varying(255) NOT NULL,
    "key_id" bigint NOT NULL,
    "public_key" text NOT NULL,
    "last_resort" smallint DEFAULT '0',
    "device_id" bigint DEFAULT '1' NOT NULL,
    CONSTRAINT "keys_pkey" PRIMARY KEY ("id")
) WITH (oids = false);

CREATE INDEX "keys_number_index" ON "public"."keys" USING btree ("number");


CREATE TABLE "public"."messages" (
    "id" bigint DEFAULT GENERATED BY DEFAULT AS IDENTITY NOT NULL,
    "account_id" bigint NOT NULL,
    "device_id" bigint NOT NULL,
    "encrypted_message" text NOT NULL,
    CONSTRAINT "messages_pkey" PRIMARY KEY ("id")
) WITH (oids = false);

CREATE INDEX "messages_account_and_device" ON "public"."messages" USING btree ("account_id", "device_id");


CREATE TABLE "public"."pending_accounts" (
    "id" bigint DEFAULT GENERATED BY DEFAULT AS IDENTITY NOT NULL,
    "number" character varying(255) NOT NULL,
    "verification_code" character varying(255),
    "timestamp" bigint DEFAULT '(date_part(''epoch''::text, now()) * (1000))' NOT NULL,
    "push_code" text,
    CONSTRAINT "pending_accounts_number_key" UNIQUE ("number"),
    CONSTRAINT "pending_accounts_pkey" PRIMARY KEY ("id")
) WITH (oids = false);


CREATE TABLE "public"."pending_devices" (
    "id" bigint DEFAULT GENERATED BY DEFAULT AS IDENTITY NOT NULL,
    "number" text NOT NULL,
    "verification_code" text NOT NULL,
    "timestamp" bigint DEFAULT '(date_part(''epoch''::text, now()) * (1000))' NOT NULL,
    CONSTRAINT "pending_devices_number_key" UNIQUE ("number"),
    CONSTRAINT "pending_devices_pkey" PRIMARY KEY ("id")
) WITH (oids = false);


CREATE TABLE "public"."profiles" (
    "id" bigint DEFAULT GENERATED BY DEFAULT AS IDENTITY NOT NULL,
    "uuid" uuid NOT NULL,
    "version" text NOT NULL,
    "name" text NOT NULL,
    "avatar" text,
    "commitment" bytea NOT NULL,
    CONSTRAINT "profiles_pkey" PRIMARY KEY ("id"),
    CONSTRAINT "uuid_and_version" UNIQUE ("uuid", "version")
) WITH (oids = false);

CREATE INDEX "profiles_uuid" ON "public"."profiles" USING btree ("uuid");


CREATE TABLE "public"."remote_config" (
    "id" bigint DEFAULT GENERATED BY DEFAULT AS IDENTITY NOT NULL,
    "name" text NOT NULL,
    "percentage" integer NOT NULL,
    "uuids" uuid[] NOT NULL,
    CONSTRAINT "remote_config_name_key" UNIQUE ("name"),
    CONSTRAINT "remote_config_pkey" PRIMARY KEY ("id")
) WITH (oids = false);


CREATE TABLE "public"."reserved_usernames" (
    "id" bigint DEFAULT GENERATED BY DEFAULT AS IDENTITY NOT NULL,
    "username" text NOT NULL,
    "uuid" uuid NOT NULL,
    CONSTRAINT "reserved_usernames_pkey" PRIMARY KEY ("id"),
    CONSTRAINT "reserved_usernames_username_key" UNIQUE ("username")
) WITH (oids = false);


CREATE TABLE "public"."usernames" (
    "id" bigint DEFAULT GENERATED BY DEFAULT AS IDENTITY NOT NULL,
    "uuid" uuid NOT NULL,
    "username" text NOT NULL,
    CONSTRAINT "usernames_pkey" PRIMARY KEY ("id"),
    CONSTRAINT "usernames_username_key" UNIQUE ("username"),
    CONSTRAINT "usernames_uuid_key" UNIQUE ("uuid")
) WITH (oids = false);


-- 2020-10-27 02:27:49.080902+00
