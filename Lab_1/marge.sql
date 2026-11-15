ALTER TABLE flights ADD COLUMN status VARCHAR(20) NOT NULL DEFAULT 'scheduled';

ALTER TABLE flights ADD CONSTRAINT chk_flight_status
    CHECK (status IN ('scheduled', 'delayed', 'cancelled'));

ALTER TABLE flights ADD COLUMN updated_at TIMESTAMP NOT NULL DEFAULT NOW();

CREATE TABLE flight_changes (
    change_id     SERIAL PRIMARY KEY,
    flight_id     INT NOT NULL,
    changed_at    TIMESTAMP NOT NULL DEFAULT NOW(),
    changed_field VARCHAR(50) NOT NULL,
    old_value     VARCHAR(100),
    new_value     VARCHAR(100) NOT NULL,
    change_reason VARCHAR(255),

    CONSTRAINT fk_flight_changes_flight
        FOREIGN KEY (flight_id) REFERENCES flights (flight_id)
        ON DELETE CASCADE,

    CONSTRAINT chk_changed_field_not_empty
        CHECK (changed_field <> ''),

    CONSTRAINT chk_value_actually_changed
        CHECK (old_value IS DISTINCT FROM new_value)
);