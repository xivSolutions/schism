CREATE EXTENSION IF NOT EXISTS pgcrypto;

create schema schema_one;
create schema schema_two;

create table users
(
  email text primary key not null,
  last_name varchar(255) null,
  first_name varchar(255) null,
  created_on timestamptz default now() not null,
  search tsvector,
  deleted boolean
);


create table artists
(
  id serial primary key not null,
  name text not null
);


create table albums
(
  id serial primary key not null,
  artist_id int not null,
  title text not null,
  track_count int not null default 0
);


create table schema_one.movies
(
  id serial primary key not null,
  title text not null,
  release_date date null
);

create table schema_one.actors
(
  id serial primary key not null,
  last_name text null,
  first_name text null
);


create or replace function increment(i integer) returns integer as $$
        begin
                return i + 1;
        end;
$$ language plpgsql;


create function multiply(i integer, j integer) returns integer as $$
        begin
                return i + j;
        end;
$$ language plpgsql;

create or replace function schema_one.say_hello(i integer) returns integer as $$
        begin
                return 'hello!';
        end;
$$ language plpgsql;


create function schema_one.say_goodbye(i integer, j integer) returns integer as $$
        begin
                return 'goodbye';
        end;
$$ language plpgsql;


create view album_artists as
  select ar.id, ar.name, al.title, al.track_count
  from artists ar 
  inner join albums al on al.artist_id = ar.id;