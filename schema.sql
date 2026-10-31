CREATE TABLE airports (
    airport_id   SERIAL PRIMARY KEY,
    country      VARCHAR(100) NOT NULL,
    city         VARCHAR(100) NOT NULL,
    airport_code VARCHAR(3)   NOT NULL UNIQUE
);

CREATE TABLE passengers (
    passenger_id    SERIAL PRIMARY KEY,
    passport_number VARCHAR(20)  NOT NULL UNIQUE,
    first_name      VARCHAR(100) NOT NULL,
    last_name       VARCHAR(100) NOT NULL,
    email           VARCHAR(255) UNIQUE,
    phone           VARCHAR(20)  NOT NULL UNIQUE
);

CREATE TABLE tariffs (
    tariff_id      SERIAL PRIMARY KEY,
    tariff_name    VARCHAR(50) NOT NULL,
    is_international BOOLEAN NOT NULL DEFAULT FALSE
);

CREATE TABLE flights (
    flight_id            SERIAL PRIMARY KEY,
    flight_number        VARCHAR(10) NOT NULL UNIQUE,
    departure_airport_id INT         NOT NULL,
    arrival_airport_id   INT         NOT NULL,
    departure_time       TIMESTAMP   NOT NULL,
    arrival_time         TIMESTAMP   NOT NULL,
    total_seats          INT         NOT NULL,

    CONSTRAINT fk_dep_airport
        FOREIGN KEY (departure_airport_id)
        REFERENCES airports (airport_id)
        ON DELETE RESTRICT,

    CONSTRAINT fk_arr_airport
        FOREIGN KEY (arrival_airport_id)
        REFERENCES airports (airport_id)
        ON DELETE RESTRICT,

    CONSTRAINT chk_seats_positive
        CHECK (total_seats > 0),

    CONSTRAINT chk_arrival_after_departure
        CHECK (arrival_time > departure_time),

    CONSTRAINT chk_different_airports
        CHECK (departure_airport_id <> arrival_airport_id)
);

CREATE TABLE bookings (
    booking_id   SERIAL PRIMARY KEY,
    passenger_id INT           NOT NULL,
    flight_id    INT           NOT NULL,
    tariff_id    INT           NOT NULL,
    seat_number  VARCHAR(5)    NOT NULL,
    price        NUMERIC(10,2) NOT NULL,
    booking_date TIMESTAMP     NOT NULL DEFAULT NOW(),

    CONSTRAINT fk_passenger
        FOREIGN KEY (passenger_id)
        REFERENCES passengers (passenger_id)
        ON DELETE RESTRICT,

    CONSTRAINT fk_flight
        FOREIGN KEY (flight_id)
        REFERENCES flights (flight_id)
        ON DELETE RESTRICT,

    CONSTRAINT fk_tariff
        FOREIGN KEY (tariff_id)
        REFERENCES tariffs (tariff_id)
        ON DELETE RESTRICT,

    CONSTRAINT chk_price_positive
        CHECK (price > 0),

    CONSTRAINT uq_flight_seat
        UNIQUE (flight_id, seat_number)
);