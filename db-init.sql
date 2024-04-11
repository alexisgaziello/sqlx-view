CREATE TABLE car
(
id            uuid       not null primary key,
created_at    timestamp  not null,
updated_at    timestamp  not null,
archived      boolean    not null,
license_plate varchar    not null,
name          varchar
);

CREATE VIEW active_car AS SELECT * FROM car WHERE archived = false;
