create table public.breeds (
  id uuid not null default gen_random_uuid (),
  name text not null,
  constraint breeds_pkey primary key (id)
) TABLESPACE pg_default;

create table public.contacts (
  id uuid not null default gen_random_uuid (),
  salutation text not null,
  first_name text not null,
  last_name text not null,
  email text not null,
  phone_number text not null,
  created_at timestamp with time zone null default timezone ('utc'::text, now()),
  constraint contacts_pkey primary key (id)
) TABLESPACE pg_default;

create table public.contacts (
  id uuid not null default gen_random_uuid (),
  salutation text not null,
  first_name text not null,
  last_name text not null,
  email text not null,
  phone_number text not null,
  created_at timestamp with time zone null default timezone ('utc'::text, now()),
  constraint contacts_pkey primary key (id)
) TABLESPACE pg_default;

create table public.contacts (
  id uuid not null default gen_random_uuid (),
  salutation text not null,
  first_name text not null,
  last_name text not null,
  email text not null,
  phone_number text not null,
  created_at timestamp with time zone null default timezone ('utc'::text, now()),
  constraint contacts_pkey primary key (id)
) TABLESPACE pg_default;

create table public.users (
  id uuid not null default gen_random_uuid (),
  created_at timestamp with time zone not null default now(),
  username text not null,
  password text null,
  "isAdmin" boolean not null default false,
  constraint users_pkey primary key (id),
  constraint unique_username unique (username)
) TABLESPACE pg_default;

ALTER TABLE contacts ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Allow anonymous inserts"
ON contacts
FOR INSERT
TO anon
WITH CHECK (
 true -- or add conditions below
);

CREATE POLICY "Allow anonymous deletes"
ON dogs
FOR DELETE
TO anon
USING (true);