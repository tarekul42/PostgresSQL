CREATE DATABASE conservation_db;

CREATE TABLE rangers (
    ranger_id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    region VARCHAR(50)
);

CREATE TABLE species (
    species_id SERIAL PRIMARY KEY,
    common_name VARCHAR(50) NOT NULL,
    scientific_name VARCHAR(50) NOT NULL,
    discovery_date DATE,
    conservation_status VARCHAR(20)
);

CREATE TABLE sightings (
    sighting_id SERIAL PRIMARY KEY,
    ranger_id INTEGER NOT NULL REFERENCES rangers (ranger_id),
    species_id INTEGER NOT NULL REFERENCES species (species_id),
    sighting_time TIMESTAMP,
    location VARCHAR(50),
    notes TEXT
);

INSERT INTO
    rangers (ranger_id, name, region)
VALUES (
        1,
        'Alice Green',
        'Northern Hills'
    ),
    (2, 'Bob White', 'River Delta'),
    (
        3,
        'Carol King',
        'Mountain Range'
    );

INSERT INTO
    species (
        species_id,
        common_name,
        scientific_name,
        discovery_date,
        conservation_status
    )
VALUES (
        1,
        'Snow Leopard',
        'Panthera uncia',
        '1775-01-01',
        'Endangered'
    ),
    (
        2,
        'Bengal Tiger',
        'Panthera tigris tigris',
        '1758-01-01',
        'Endangered'
    ),
    (
        3,
        'Red Panda',
        'Ailurus fulgens',
        '1825-01-01',
        'Vulnerable'
    ),
    (
        4,
        'Asiatic Elephant',
        'Elephas maximus indicus',
        '1758-01-01',
        'Endangered'
    );

INSERT INTO
    sightings (
        sighting_id,
        species_id,
        ranger_id,
        location,
        sighting_time,
        notes
    )
VALUES (
        1,
        1,
        1,
        'Peak Ridge',
        '2024-05-10 07:45:00',
        'Camera trap image captured'
    ),
    (
        2,
        2,
        2,
        'Bankwood Area',
        '2024-05-12 16:20:00',
        'Juvenile seen'
    ),
    (
        3,
        3,
        3,
        'Bamboo Grove East',
        '2024-05-15 09:10:00',
        'Feeding observed'
    ),
    (
        4,
        1,
        2,
        'Snowfall Pass',
        '2024-05-18 18:30:00',
        NULL
    );

SELECT * FROM rangers;

SELECT * FROM species;

SELECT * FROM sightings;

-- Problem 1
INSERT INTO
    rangers (ranger_id, name, region)
VALUES (
        4,
        'Derek Fox',
        'Coastal Plains'
    );

-- Problem 2
SELECT count(DISTINCT species_id) AS unique_species_count
FROM sightings;

-- Problem 3
SELECT * FROM sightings WHERE location LIKE '%Pass%';

-- Problem 4
SELECT rg.name, count(st.sighting_id)
FROM rangers AS rg
    JOIN sightings AS st ON rg.ranger_id = st.ranger_id
GROUP BY
    rg.name
ORDER BY rg.name ASC;

-- Problem 5
SELECT common_name FROM species AS sc
LEFT JOIN sightings AS st ON sc.species_id = st.species_id
WHERE st.species_id IS NULL;

-- Problem 6
SELECT sc.common_name, st.sighting_time, rg.name FROM sightings AS st
JOIN species AS sc ON st.species_id = sc.species_id
JOIN rangers AS rg ON st.ranger_id = rg.ranger_id
ORDER BY st.sighting_time DESC
LIMIT 2;

-- Problem 7
UPDATE species
SET conservation_status = 'Historic'
WHERE discovery_date < '1800-01-01';

-- Problem 9
DELETE FROM rangers
WHERE ranger_id NOT IN ( SELECT ranger_id FROM sightings);