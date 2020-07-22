-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- Link to schema: https://app.quickdatabasediagrams.com/#/d/l4N6eB
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.


CREATE TABLE `CONCERT` (
    `id` INT AUTO_INCREMENT NOT NULL ,
    `date` DATE  NOT NULL ,
    `time` TIME  NOT NULL ,
    `id_location` INT  NOT NULL ,
    `id_project` INT  NOT NULL ,
    PRIMARY KEY (
        `id`
    )
);

CREATE TABLE `MUSICIAN` (
    `id` INT AUTO_INCREMENT NOT NULL ,
    `firstname` VARCHAR(60)  NOT NULL ,
    `lastname` VARCHAR(60)  NOT NULL ,
    `id_instrument` INT  NOT NULL ,
    PRIMARY KEY (
        `id`
    )
);

CREATE TABLE `LOCATION` (
    `id` INT AUTO_INCREMENT NOT NULL ,
    `id_city` INT  NOT NULL ,
    `concert_hall` VARCHAR(100)  NOT NULL ,
    PRIMARY KEY (
        `id`
    )
);

CREATE TABLE `CITY` (
    `id` INT AUTO_INCREMENT NOT NULL ,
    `name` VARCHAR(60)  NOT NULL ,
    PRIMARY KEY (
        `id`
    )
);

CREATE TABLE `PROJECT` (
    `id` INT AUTO_INCREMENT NOT NULL ,
    `title` VARCHAR(100)  NOT NULL ,
    PRIMARY KEY (
        `id`
    )
);

CREATE TABLE `INSTRUMENT` (
    `id` INT AUTO_INCREMENT NOT NULL ,
    `instrument` VARCHAR(60)  NOT NULL ,
    PRIMARY KEY (
        `id`
    )
);

ALTER TABLE `CONCERT` ADD CONSTRAINT `fk_CONCERT_id_location` FOREIGN KEY(`id_location`)
REFERENCES `LOCATION` (`id`);

ALTER TABLE `CONCERT` ADD CONSTRAINT `fk_CONCERT_id_project` FOREIGN KEY(`id_project`)
REFERENCES `PROJECT` (`id`);

ALTER TABLE `MUSICIAN` ADD CONSTRAINT `fk_MUSICIAN_id_instrument` FOREIGN KEY(`id_instrument`)
REFERENCES `INSTRUMENT` (`id`);

ALTER TABLE `LOCATION` ADD CONSTRAINT `fk_LOCATION_id_city` FOREIGN KEY(`id_city`)
REFERENCES `CITY` (`id`);

