
# DB Migration — Address Table

## Table of Contents
- [[#Migration 1]]
  - [[#Bank BOB]]
  - [[#Bank SIB]]
  - [[#Bank FED]]
  - [[#Bank CSB]]
  - [[#Bank IDIB]]
  - [[#Bank SBM]]
  - [[#Bank IDFC]]
  - [[#Migration Stage]]
  - [[#Post-Migration Stage]]
- [[#Migration 2]]
  - [[#Bank KSF]]
  - [[#Bank INCRED]]
  - [[#Bank PIRAMAL]]

---

# Migration 1

> **Purpose:** Migrate address data from KYC source tables into temporary staging tables per bank, for DMS transfer to the destination DB.

---

## Bank: BOB

> `tenant_id: 1877335677`

---

### KYC Table: ckyc

**Step 1 —** Create staging and output tables

```sql
-- Staging CKYC table with id for batching and processed flag
CREATE UNLOGGED TABLE IF NOT EXISTS stage_bob_ckyc_address_ids (
    id SERIAL PRIMARY KEY,
    ckyc_id BIGINT,
    processed BOOLEAN DEFAULT FALSE
);

-- Output table
CREATE UNLOGGED TABLE IF NOT EXISTS temp_bob_address (
    id BIGSERIAL PRIMARY KEY, -- Primary key for the temp table
    address_id BIGINT,       -- Corresponds to public.address.id
    type VARCHAR,
    line1 VARCHAR,
    line2 VARCHAR,
    line3 VARCHAR,
    landmark VARCHAR,
    pincode VARCHAR,
    city VARCHAR,
    state VARCHAR,
    country VARCHAR,
    latitude character varying(45),
    longitude character varying(45),
    customer_no VARCHAR(50),
    source VARCHAR,
    created_at TIMESTAMP WITHOUT TIME ZONE,
    updated_at TIMESTAMP WITHOUT TIME ZONE
);
```

**Step 2 —** Populate staging table

```sql
INSERT INTO stage_bob_ckyc_address_ids (ckyc_id)
SELECT DISTINCT ck.ckyc_id
FROM public.customer_kyc ck
WHERE ck.tenant_id = 1877335677; -- Insert correct tenant id
```

**Step 3 —** Batch migration DO block

```sql
DO $$
DECLARE
    batch_size INTEGER := 10000;
    min_id INTEGER;
    max_id INTEGER;
    batch_min INTEGER;
    batch_max INTEGER;
    inserted_rows INTEGER;
    batch_row_count INTEGER;
BEGIN
    -- Determine the range of IDs to process
    SELECT MIN(id), MAX(id) INTO min_id, max_id FROM stage_bob_ckyc_address_ids WHERE NOT processed;

    IF min_id IS NULL OR max_id IS NULL THEN
        RAISE NOTICE 'No unprocessed records in stage_bob_ckyc_address_ids.';
        RETURN;
    END IF;

    -- Initialize batch boundaries
    batch_min := min_id;
    batch_max := min_id + batch_size - 1;

    -- Start the batch loop
    WHILE batch_min <= max_id LOOP
        -- Check if the current batch range has unprocessed items
        SELECT COUNT(1) INTO batch_row_count FROM stage_bob_ckyc_address_ids WHERE id BETWEEN batch_min AND batch_max AND NOT processed;

        IF batch_row_count > 0 THEN
            BEGIN
                -- 3. Select the final address rows and join to the customer table for customer_no.
                INSERT INTO temp_bob_address (
                    address_id, type, line1, line2, line3, landmark, pincode, city, state, country,
                    latitude, longitude, customer_no, source, created_at, updated_at
                )
                SELECT
                    a.id AS address_id, a.type, a.line1, a.line2, a.line3, a.landmark, a.pincode, a.city, a.state, a.country,
                    a.latitude, a.longitude, cust.customer_no, a.source, a.created_at, a.updated_at
                FROM (
                    -- 2. Collect all unique, non-null address IDs from the three nullable columns in the current batch.
                    SELECT DISTINCT unnest(array[
                        c.permanent_address_id,
                        c.correspondence_address_id,
                        c.tax_address_id
                    ]) AS address_id
                    FROM stage_bob_ckyc_address_ids s
                    INNER JOIN public.ckyc c ON c.id = s.ckyc_id
                    WHERE s.id BETWEEN batch_min AND batch_max AND s.processed = FALSE
                ) flat_ids
                INNER JOIN public.address a ON a.id = flat_ids.address_id
                INNER JOIN public.customer cust ON a.customer_id = cust.id
                WHERE flat_ids.address_id IS NOT NULL;

                -- Mark batch as processed
                UPDATE stage_bob_ckyc_address_ids SET processed = TRUE WHERE id BETWEEN batch_min AND batch_max AND processed = FALSE;

                -- Log the result of the batch
                GET DIAGNOSTICS inserted_rows = ROW_COUNT;
                RAISE NOTICE 'Batch ids % to % processed: ckyc_ids %, rows inserted %', batch_min, batch_max, batch_row_count, inserted_rows;
            EXCEPTION
                WHEN OTHERS THEN
                    RAISE WARNING 'Batch ids % to % failed: %', batch_min, batch_max, SQLERRM;
                    RAISE NOTICE 'Rolling back this batch. No changes made for batch.';
            END;
        END IF;

        -- Move to the next batch
        batch_min := batch_min + batch_size;
        batch_max := batch_max + batch_size;
    END LOOP;
END $$;
```

---

### KYC Table: digilocker

**Step 1 —** Create staging and output tables

```sql
-- Staging DIGILOCKER table with id for batching and processed flag
CREATE UNLOGGED TABLE IF NOT EXISTS stage_bob_digilocker_address_ids (
    id SERIAL PRIMARY KEY,
    digilocker_id BIGINT,
    processed BOOLEAN DEFAULT FALSE
);

-- Output table for migrated addresses (extended to include 'reason' and 'updated_by' from the source query)
CREATE UNLOGGED TABLE IF NOT EXISTS temp_bob_address (
    id BIGSERIAL PRIMARY KEY, -- Primary key for the temp table
    address_id BIGINT,       -- Corresponds to public.address.id
    type VARCHAR,
    line1 VARCHAR,
    line2 VARCHAR,
    line3 VARCHAR,
    landmark VARCHAR,
    pincode VARCHAR,
    city VARCHAR,
    state VARCHAR,
    country VARCHAR,
    latitude character varying(45),
    longitude character varying(45),
    customer_no VARCHAR(50),
    source VARCHAR,
    created_at TIMESTAMP WITHOUT TIME ZONE,
    updated_at TIMESTAMP WITHOUT TIME ZONE
);
```

**Step 2 —** Populate staging table

```sql
INSERT INTO stage_bob_digilocker_address_ids (digilocker_id)
SELECT DISTINCT ck.digilocker_id
FROM public.customer_kyc ck
WHERE ck.tenant_id = 1877335677; -- Insert correct tenant id
```

**Step 3 —** Batch migration DO block

```sql
DO $$
DECLARE
    batch_size INTEGER := 10000;
    min_id INTEGER;
    max_id INTEGER;
    batch_min INTEGER;
    batch_max INTEGER;
    inserted_rows INTEGER;
    batch_row_count INTEGER;
BEGIN
    -- Determine the range of IDs to process
    SELECT MIN(id), MAX(id) INTO min_id, max_id FROM stage_bob_digilocker_address_ids WHERE NOT processed;

    IF min_id IS NULL OR max_id IS NULL THEN
        RAISE NOTICE 'No unprocessed records in stage_bob_digilocker_address_ids.';
        RETURN;
    END IF;

    -- Initialize batch boundaries
    batch_min := min_id;
    batch_max := min_id + batch_size - 1;

    -- Start the batch loop
    WHILE batch_min <= max_id LOOP
        -- Check if the current batch range has unprocessed items
        SELECT COUNT(1) INTO batch_row_count FROM stage_bob_digilocker_address_ids WHERE id BETWEEN batch_min AND batch_max AND NOT processed;

        IF batch_row_count > 0 THEN
            BEGIN
                -- Select the final address rows and join to the customer table for customer_no.
                INSERT INTO temp_bob_address (
                    address_id, type, line1, line2, line3, landmark, pincode, city, state, country,
                    latitude, longitude, customer_no, source, created_at, updated_at
                )
                SELECT
                    a.id AS address_id, a.type, a.line1, a.line2, a.line3, a.landmark, a.pincode, a.city, a.state, a.country,
                    a.latitude, a.longitude, cust.customer_no, a.source, a.created_at, a.updated_at
                FROM (
                    -- Collect unique, non-null address foreign key values from the target digilocker records in the current batch.
                    SELECT DISTINCT
                        d.address_id AS address_id
                    FROM stage_bob_digilocker_address_ids s
                    INNER JOIN public.digilocker d ON d.id = s.digilocker_id
                    WHERE s.id BETWEEN batch_min AND batch_max AND s.processed = FALSE
                ) flat_ids
                INNER JOIN public.address a ON a.id = flat_ids.address_id
                INNER JOIN public.customer cust ON a.customer_id = cust.id
                WHERE flat_ids.address_id IS NOT NULL;

                -- Mark batch as processed
                UPDATE stage_bob_digilocker_address_ids SET processed = TRUE WHERE id BETWEEN batch_min AND batch_max AND processed = FALSE;

                -- Log the result of the batch
                GET DIAGNOSTICS inserted_rows = ROW_COUNT;
                RAISE NOTICE 'Batch ids % to % processed: digilocker_ids %, rows inserted %', batch_min, batch_max, batch_row_count, inserted_rows;
            EXCEPTION
                WHEN OTHERS THEN
                    RAISE WARNING 'Batch ids % to % failed: %', batch_min, batch_max, SQLERRM;
                    RAISE NOTICE 'Rolling back this batch. No changes made for batch.';
            END;
        END IF;

        -- Move to the next batch
        batch_min := batch_min + batch_size;
        batch_max := batch_max + batch_size;
    END LOOP;
END $$;
```

---

### KYC Table: physical_kyc

**Step 1 —** Create staging and output tables

```sql
-- Staging PHYSICAL_KYC table with id for batching and processed flag
CREATE UNLOGGED TABLE IF NOT EXISTS stage_bob_physical_kyc_address_ids (
    id SERIAL PRIMARY KEY,
    physical_kyc_id BIGINT,
    processed BOOLEAN DEFAULT FALSE
);

-- Output table for migrated addresses (extended to include 'reason' and 'updated_by' from the source query)
CREATE UNLOGGED TABLE IF NOT EXISTS temp_bob_address (
    id BIGSERIAL PRIMARY KEY, -- Primary key for the temp table
    address_id BIGINT,       -- Corresponds to public.address.id
    type VARCHAR,
    line1 VARCHAR,
    line2 VARCHAR,
    line3 VARCHAR,
    landmark VARCHAR,
    pincode VARCHAR,
    city VARCHAR,
    state VARCHAR,
    country VARCHAR,
    latitude character varying(45),
    longitude character varying(45),
    customer_no VARCHAR(50),
    source VARCHAR,
    created_at TIMESTAMP WITHOUT TIME ZONE,
    updated_at TIMESTAMP WITHOUT TIME ZONE
);
```

**Step 2 —** Populate staging table

```sql
INSERT INTO stage_bob_physical_kyc_address_ids (physical_kyc_id)
SELECT DISTINCT ck.physical_kyc_id
FROM public.customer_kyc ck
WHERE ck.tenant_id = 1877335677; -- Insert correct tenant id
```

**Step 3 —** Batch migration DO block

```sql
DO $$
DECLARE
    batch_size INTEGER := 10000;
    min_id INTEGER;
    max_id INTEGER;
    batch_min INTEGER;
    batch_max INTEGER;
    inserted_rows INTEGER;
    batch_row_count INTEGER;
BEGIN
    -- Determine the range of IDs to process
    SELECT MIN(id), MAX(id) INTO min_id, max_id FROM stage_bob_physical_kyc_address_ids WHERE NOT processed;

    IF min_id IS NULL OR max_id IS NULL THEN
        RAISE NOTICE 'No unprocessed records in stage_bob_physical_kyc_address_ids.';
        RETURN;
    END IF;

    -- Initialize batch boundaries
    batch_min := min_id;
    batch_max := min_id + batch_size - 1;

    -- Start the batch loop
    WHILE batch_min <= max_id LOOP
        -- Check if the current batch range has unprocessed items
        SELECT COUNT(1) INTO batch_row_count FROM stage_bob_physical_kyc_address_ids WHERE id BETWEEN batch_min AND batch_max AND NOT processed;

        IF batch_row_count > 0 THEN
            BEGIN
                -- 3. Select the final address rows and join to the customer table for customer_no.
                INSERT INTO temp_bob_address (
                    address_id, type, line1, line2, line3, landmark, pincode, city, state, country,
                    latitude, longitude, customer_no, source, created_at, updated_at
                )
                SELECT
                    a.id AS address_id, a.type, a.line1, a.line2, a.line3, a.landmark, a.pincode, a.city, a.state, a.country,
                    a.latitude, a.longitude, cust.customer_no, a.source, a.created_at, a.updated_at
                FROM (
                    -- 2. Collect all unique, non-null address IDs from the two nullable columns in the current batch.
                    SELECT DISTINCT unnest(array[
                        pk.permanent_address_id,
                        pk.correspondence_address_id
                    ]) AS address_id
                    FROM stage_bob_physical_kyc_address_ids s
                    INNER JOIN public.physical_kyc pk ON pk.id = s.physical_kyc_id
                    WHERE s.id BETWEEN batch_min AND batch_max AND s.processed = FALSE
                ) flat_ids
                INNER JOIN public.address a ON a.id = flat_ids.address_id
                INNER JOIN public.customer cust ON a.customer_id = cust.id
                WHERE flat_ids.address_id IS NOT NULL;

                -- Mark batch as processed
                UPDATE stage_bob_physical_kyc_address_ids SET processed = TRUE WHERE id BETWEEN batch_min AND batch_max AND processed = FALSE;

                -- Log the result of the batch
                GET DIAGNOSTICS inserted_rows = ROW_COUNT;
                RAISE NOTICE 'Batch ids % to % processed: physical_kyc_ids %, rows inserted %', batch_min, batch_max, batch_row_count, inserted_rows;
            EXCEPTION
                WHEN OTHERS THEN
                    RAISE WARNING 'Batch ids % to % failed: %', batch_min, batch_max, SQLERRM;
                    RAISE NOTICE 'Rolling back this batch. No changes made for batch.';
            END;
        END IF;

        -- Move to the next batch
        batch_min := batch_min + batch_size;
        batch_max := batch_max + batch_size;
    END LOOP;
END $$;
```

---

### #todo KYC Table: aadhaar_ekyc_web

**Step 1 —** Create staging and output tables

```sql
-- Staging AADHAAR_EKYC_WEB table with id for batching and processed flag
CREATE UNLOGGED TABLE IF NOT EXISTS stage_bob_aadhaar_ekyc_web_address_ids (
    id SERIAL PRIMARY KEY,
    aadhaar_web_ekyc_id BIGINT,
    processed BOOLEAN DEFAULT FALSE
);
```

**Step 2 —** Populate staging table

```sql
INSERT INTO stage_bob_aadhaar_ekyc_web_address_ids (aadhaar_web_ekyc_id)
SELECT DISTINCT aew.id
FROM public.aadhaar_ekyc_web aew
WHERE aew.tenant_id = 1877335677; -- Insert correct tenant id
```

**Step 3 —** Batch migration DO block

```sql
DO $$
DECLARE
    batch_size INTEGER := 10000;
    min_id INTEGER;
    max_id INTEGER;
    batch_min INTEGER;
    batch_max INTEGER;
    inserted_rows INTEGER;
    batch_row_count INTEGER;
BEGIN
    -- Determine the range of IDs to process
    SELECT MIN(id), MAX(id) INTO min_id, max_id FROM stage_bob_aadhaar_ekyc_web_address_ids WHERE NOT processed;

    IF min_id IS NULL OR max_id IS NULL THEN
        RAISE NOTICE 'No unprocessed records in stage_bob_aadhaar_ekyc_web_address_ids.';
        RETURN;
    END IF;

    -- Initialize batch boundaries
    batch_min := min_id;
    batch_max := min_id + batch_size - 1;

    -- Start the batch loop
    WHILE batch_min <= max_id LOOP
        -- Check if the current batch range has unprocessed items
        SELECT COUNT(1) INTO batch_row_count FROM stage_bob_aadhaar_ekyc_web_address_ids WHERE id BETWEEN batch_min AND batch_max AND NOT processed;

        IF batch_row_count > 0 THEN
            BEGIN
                -- 3. Select the final address rows and join to the customer table for customer_no.
                INSERT INTO temp_bob_address (
                    address_id, type, line1, line2, line3, landmark, pincode, city, state, country,
                    latitude, longitude, customer_no, source, created_at, updated_at
                )
                SELECT
                    a.id AS address_id, a.type, a.line1, a.line2, a.line3, a.landmark, a.pincode, a.city, a.state, a.country,
                    a.latitude, a.longitude, cust.customer_no, a.source, a.created_at, a.updated_at
                FROM (
                    -- 2. Collect unique, non-null address foreign key values from the target aadhaar_ekyc_web records in the current batch.
                    SELECT DISTINCT
                        aew.address AS address_id -- ASSUMPTION: 'address' is the foreign key column to 'public.address'
                    FROM stage_bob_aadhaar_ekyc_web_address_ids s
                    INNER JOIN public.aadhaar_ekyc_web aew ON aew.id = s.aadhaar_web_ekyc_id
                    WHERE s.id BETWEEN batch_min AND batch_max AND s.processed = FALSE
                ) flat_ids
                INNER JOIN public.address a ON a.id = flat_ids.address_id
                INNER JOIN public.customer cust ON a.customer_id = cust.id
                WHERE flat_ids.address_id IS NOT NULL;

                -- Mark batch as processed
                UPDATE stage_bob_aadhaar_ekyc_web_address_ids SET processed = TRUE WHERE id BETWEEN batch_min AND batch_max AND processed = FALSE;

                -- Log the result of the batch
                GET DIAGNOSTICS inserted_rows = ROW_COUNT;
                RAISE NOTICE 'Batch ids % to % processed: aadhaar_web_ekyc_ids %, rows inserted %', batch_min, batch_max, batch_row_count, inserted_rows;
            EXCEPTION
                WHEN OTHERS THEN
                    RAISE WARNING 'Batch ids % to % failed: %', batch_min, batch_max, SQLERRM;
                    RAISE NOTICE 'Rolling back this batch. No changes made for batch.';
            END;
        END IF;

        -- Move to the next batch
        batch_min := batch_min + batch_size;
        batch_max := batch_max + batch_size;
    END LOOP;
END $$;
```

---

### #todo KYC Table: aadhaar_xml_kyc

**Step 1 —** Create staging and output tables

```sql
-- Staging AADHAAR_XML_KYC table with id for batching and processed flag
CREATE UNLOGGED TABLE IF NOT EXISTS stage_bob_aadhaar_xml_kyc_address_ids (
    id SERIAL PRIMARY KEY,
    offline_aadhaar_xml_kyc_id BIGINT,
    processed BOOLEAN DEFAULT FALSE
);
```

**Step 2 —** Populate staging table

```sql
INSERT INTO stage_bob_aadhaar_xml_kyc_address_ids (offline_aadhaar_xml_kyc_id)
SELECT DISTINCT ck.offline_aadhaar_xml_kyc_id
FROM public.customer_kyc ck
WHERE ck.tenant_id = 1877335677; -- Insert correct tenant id
```

**Step 3 —** Batch migration DO block

```sql
DO $$
DECLARE
    batch_size INTEGER := 10000;
    min_id INTEGER;
    max_id INTEGER;
    batch_min INTEGER;
    batch_max INTEGER;
    inserted_rows INTEGER;
    batch_row_count INTEGER;
BEGIN
    -- Determine the range of IDs to process
    SELECT MIN(id), MAX(id) INTO min_id, max_id FROM stage_bob_aadhaar_xml_kyc_address_ids WHERE NOT processed;

    IF min_id IS NULL OR max_id IS NULL THEN
        RAISE NOTICE 'No unprocessed records in stage_bob_aadhaar_xml_kyc_address_ids.';
        RETURN;
    END IF;

    -- Initialize batch boundaries
    batch_min := min_id;
    batch_max := min_id + batch_size - 1;

    -- Start the batch loop
    WHILE batch_min <= max_id LOOP
        -- Check if the current batch range has unprocessed items
        SELECT COUNT(1) INTO batch_row_count FROM stage_bob_aadhaar_xml_kyc_address_ids WHERE id BETWEEN batch_min AND batch_max AND NOT processed;

        IF batch_row_count > 0 THEN
            BEGIN
                -- 3. Select the final address rows and join to the customer table for customer_no.
                INSERT INTO temp_bob_address (
                    address_id, type, line1, line2, line3, landmark, pincode, city, state, country,
                    latitude, longitude, customer_no, source, created_at, updated_at
                )
                SELECT
                    a.id AS address_id, a.type, a.line1, a.line2, a.line3, a.landmark, a.pincode, a.city, a.state, a.country,
                    a.latitude, a.longitude, cust.customer_no, a.source, a.created_at, a.updated_at
                FROM (
                    -- 2. Collect unique, non-null address foreign key values from the target aadhaar_xml_kyc records in the current batch.
                    SELECT DISTINCT
                        axk.address AS address_id -- ASSUMPTION: 'address' is the foreign key column to 'public.address'
                    FROM stage_bob_aadhaar_xml_kyc_address_ids s
                    INNER JOIN public.aadhaar_xml_kyc axk ON axk.id = s.offline_aadhaar_xml_kyc_id
                    WHERE s.id BETWEEN batch_min AND batch_max AND s.processed = FALSE
                ) flat_ids
                INNER JOIN public.address a ON a.id = flat_ids.address_id
                INNER JOIN public.customer cust ON a.customer_id = cust.id
                WHERE flat_ids.address_id IS NOT NULL;

                -- Mark batch as processed
                UPDATE stage_bob_aadhaar_xml_kyc_address_ids SET processed = TRUE WHERE id BETWEEN batch_min AND batch_max AND processed = FALSE;

                -- Log the result of the batch
                GET DIAGNOSTICS inserted_rows = ROW_COUNT;
                RAISE NOTICE 'Batch ids % to % processed: offline_aadhaar_xml_kyc_ids %, rows inserted %', batch_min, batch_max, batch_row_count, inserted_rows;
            EXCEPTION
                WHEN OTHERS THEN
                    RAISE WARNING 'Batch ids % to % failed: %', batch_min, batch_max, SQLERRM;
                    RAISE NOTICE 'Rolling back this batch. No changes made for batch.';
            END;
        END IF;

        -- Move to the next batch
        batch_min := batch_min + batch_size;
        batch_max := batch_max + batch_size;
    END LOOP;
END $$;
```

---

## Bank: SIB

> tenant_id: 4165374739

### KYC Table: aadhaar_ekyc

**Step 1 —** Create staging and output tables

```sql
-- Staging AADHAAR_EKYC table with id for batching and processed flag
CREATE UNLOGGED TABLE IF NOT EXISTS stage_sib_aadhaar_ekyc_address_ids (
    id SERIAL PRIMARY KEY,
    aadhaar_ekyc_id BIGINT,
    processed BOOLEAN DEFAULT FALSE
);

-- Output table
CREATE UNLOGGED TABLE IF NOT EXISTS temp_sib_address (
    id BIGSERIAL PRIMARY KEY, -- Primary key for the temp table
    address_id BIGINT,       -- Corresponds to public.address.id
    type VARCHAR,
    line1 VARCHAR,
    line2 VARCHAR,
    line3 VARCHAR,
    landmark VARCHAR,
    pincode VARCHAR,
    city VARCHAR,
    state VARCHAR,
    country VARCHAR,
    latitude character varying(45),
    longitude character varying(45),
    customer_no VARCHAR(50),
    source VARCHAR,
    created_at TIMESTAMP WITHOUT TIME ZONE,
    updated_at TIMESTAMP WITHOUT TIME ZONE
);
```

**Step 2 —** Populate staging table

```sql
INSERT INTO stage_sib_aadhaar_ekyc_address_ids (aadhaar_ekyc_id)
SELECT DISTINCT ck.aadhaar_ekyc_id
FROM public.customer_kyc ck
WHERE ck.tenant_id = 4165374739; -- Insert correct tenant id
```

**Step 3 —** Batch migration DO block

```sql
DO $$
DECLARE
    batch_size INTEGER := 10000;
    min_id INTEGER;
    max_id INTEGER;
    batch_min INTEGER;
    batch_max INTEGER;
    inserted_rows INTEGER;
    batch_row_count INTEGER;
BEGIN
    -- Determine the range of IDs to process
    SELECT MIN(id), MAX(id) INTO min_id, max_id FROM stage_sib_aadhaar_ekyc_address_ids WHERE NOT processed;

    IF min_id IS NULL OR max_id IS NULL THEN
        RAISE NOTICE 'No unprocessed records in stage_sib_aadhaar_ekyc_address_ids.';
        RETURN;
    END IF;

    -- Initialize batch boundaries
    batch_min := min_id;
    batch_max := min_id + batch_size - 1;

    -- Start the batch loop
    WHILE batch_min <= max_id LOOP
        -- Check if the current batch range has unprocessed items
        SELECT COUNT(1) INTO batch_row_count FROM stage_sib_aadhaar_ekyc_address_ids WHERE id BETWEEN batch_min AND batch_max AND NOT processed;

        IF batch_row_count > 0 THEN
            BEGIN
                -- 3. Select the final address rows and join to the customer table for customer_no.
                INSERT INTO temp_sib_address (
                    address_id, type, line1, line2, line3, landmark, pincode, city, state, country,
                    latitude, longitude, customer_no, source, created_at, updated_at
                )
                SELECT
                    a.id AS address_id, a.type, a.line1, a.line2, a.line3, a.landmark, a.pincode, a.city, a.state, a.country,
                    a.latitude, a.longitude, cust.customer_no, a.source, a.created_at, a.updated_at
                FROM (
                    -- 2. Collect unique, non-null address foreign key values from the target aadhaar_ekyc records in the current batch.
                    SELECT DISTINCT
                        ae.address AS address_id
                    FROM stage_sib_aadhaar_ekyc_address_ids s
                    INNER JOIN public.aadhaar_ekyc ae ON ae.id = s.aadhaar_ekyc_id
                    WHERE s.id BETWEEN batch_min AND batch_max AND s.processed = FALSE
                ) flat_ids
                INNER JOIN public.address a ON a.id = flat_ids.address_id
                INNER JOIN public.customer cust ON a.customer_id = cust.id
                WHERE flat_ids.address_id IS NOT NULL;

                -- Mark batch as processed
                UPDATE stage_sib_aadhaar_ekyc_address_ids SET processed = TRUE WHERE id BETWEEN batch_min AND batch_max AND processed = FALSE;

                -- Log the result of the batch
                GET DIAGNOSTICS inserted_rows = ROW_COUNT;
                RAISE NOTICE 'Batch ids % to % processed: aadhaar_ekyc_ids %, rows inserted %', batch_min, batch_max, batch_row_count, inserted_rows;
            EXCEPTION
                WHEN OTHERS THEN
                    RAISE WARNING 'Batch ids % to % failed: %', batch_min, batch_max, SQLERRM;
                    RAISE NOTICE 'Rolling back this batch. No changes made for batch.';
            END;
        END IF;

        -- Move to the next batch
        batch_min := batch_min + batch_size;
        batch_max := batch_max + batch_size;
    END LOOP;
END $$;
```

---

### KYC Table: aadhaar_ekyc_web

**Step 1 —** Create staging and output tables

```sql
-- Staging AADHAAR_EKYC_WEB table with id for batching and processed flag
CREATE UNLOGGED TABLE IF NOT EXISTS stage_sib_aadhaar_ekyc_web_address_ids (
    id SERIAL PRIMARY KEY,
    aadhaar_web_ekyc_id BIGINT,
    processed BOOLEAN DEFAULT FALSE
);

-- Output table
CREATE UNLOGGED TABLE IF NOT EXISTS temp_sib_address (
    id BIGSERIAL PRIMARY KEY, -- Primary key for the temp table
    address_id BIGINT,       -- Corresponds to public.address.id
    type VARCHAR,
    line1 VARCHAR,
    line2 VARCHAR,
    line3 VARCHAR,
    landmark VARCHAR,
    pincode VARCHAR,
    city VARCHAR,
    state VARCHAR,
    country VARCHAR,
    latitude character varying(45),
    longitude character varying(45),
    customer_no VARCHAR(50),
    source VARCHAR,
    created_at TIMESTAMP WITHOUT TIME ZONE,
    updated_at TIMESTAMP WITHOUT TIME ZONE
);
```

**Step 2 —** Populate staging table

```sql
INSERT INTO stage_sib_aadhaar_ekyc_web_address_ids (aadhaar_web_ekyc_id)
SELECT DISTINCT ck.aadhaar_web_ekyc_id
FROM public.customer_kyc ck
WHERE ck.tenant_id = 4165374739; -- Insert correct tenant id 
```

**Step 3 —** Batch migration DO block

```sql
DO $$
DECLARE
    batch_size INTEGER := 10000;
    min_id INTEGER;
    max_id INTEGER;
    batch_min INTEGER;
    batch_max INTEGER;
    inserted_rows INTEGER;
    batch_row_count INTEGER;
BEGIN
    -- Determine the range of IDs to process
    SELECT MIN(id), MAX(id) INTO min_id, max_id FROM stage_sib_aadhaar_ekyc_web_address_ids WHERE NOT processed;

    IF min_id IS NULL OR max_id IS NULL THEN
        RAISE NOTICE 'No unprocessed records in stage_sib_aadhaar_ekyc_web_address_ids.';
        RETURN;
    END IF;

    -- Initialize batch boundaries
    batch_min := min_id;
    batch_max := min_id + batch_size - 1;

    -- Start the batch loop
    WHILE batch_min <= max_id LOOP
        -- Check if the current batch range has unprocessed items
        SELECT COUNT(1) INTO batch_row_count FROM stage_sib_aadhaar_ekyc_web_address_ids WHERE id BETWEEN batch_min AND batch_max AND NOT processed;

        IF batch_row_count > 0 THEN
            BEGIN
                -- 3. Select the final address rows and join to the customer table for customer_no.
                INSERT INTO temp_sib_address (
                    address_id, type, line1, line2, line3, landmark, pincode, city, state, country,
                    latitude, longitude, customer_no, source, created_at, updated_at
                )
                SELECT
                    a.id AS address_id, a.type, a.line1, a.line2, a.line3, a.landmark, a.pincode, a.city, a.state, a.country,
                    a.latitude, a.longitude, cust.customer_no, a.source, a.created_at, a.updated_at
                FROM (
                    -- 2. Collect unique, non-null address foreign key values from the target aadhaar_ekyc_web records in the current batch.
                    SELECT DISTINCT
                        aew.address AS address_id -- ASSUMPTION: 'address' is the foreign key column to 'public.address'
                    FROM stage_sib_aadhaar_ekyc_web_address_ids s
                    INNER JOIN public.aadhaar_ekyc_web aew ON aew.id = s.aadhaar_web_ekyc_id
                    WHERE s.id BETWEEN batch_min AND batch_max AND s.processed = FALSE
                ) flat_ids
                INNER JOIN public.address a ON a.id = flat_ids.address_id
                INNER JOIN public.customer cust ON a.customer_id = cust.id
                WHERE flat_ids.address_id IS NOT NULL;

                -- Mark batch as processed
                UPDATE stage_sib_aadhaar_ekyc_web_address_ids SET processed = TRUE WHERE id BETWEEN batch_min AND batch_max AND processed = FALSE;

                -- Log the result of the batch
                GET DIAGNOSTICS inserted_rows = ROW_COUNT;
                RAISE NOTICE 'Batch ids % to % processed: aadhaar_web_ekyc_ids %, rows inserted %', batch_min, batch_max, batch_row_count, inserted_rows;
            EXCEPTION
                WHEN OTHERS THEN
                    RAISE WARNING 'Batch ids % to % failed: %', batch_min, batch_max, SQLERRM;
                    RAISE NOTICE 'Rolling back this batch. No changes made for batch.';
            END;
        END IF;

        -- Move to the next batch
        batch_min := batch_min + batch_size;
        batch_max := batch_max + batch_size;
    END LOOP;
END $$;
```

---

### #todo KYC Table: aadhaar_xml_kyc

**Step 1 —** Create staging and output tables

```sql
-- Staging AADHAAR_XML_KYC table with id for batching and processed flag
CREATE UNLOGGED TABLE IF NOT EXISTS stage_sib_aadhaar_xml_kyc_address_ids (
    id SERIAL PRIMARY KEY,
    offline_aadhaar_xml_kyc_id BIGINT,
    processed BOOLEAN DEFAULT FALSE
);
```

**Step 2 —** Populate staging table

```sql
INSERT INTO stage_sib_aadhaar_xml_kyc_address_ids (offline_aadhaar_xml_kyc_id)
SELECT DISTINCT ck.offline_aadhaar_xml_kyc_id
FROM public.customer_kyc ck
WHERE ck.tenant_id = 4165374739; -- Insert correct tenant id
```

**Step 3 —** Batch migration DO block

```sql
DO $$
DECLARE
    batch_size INTEGER := 10000;
    min_id INTEGER;
    max_id INTEGER;
    batch_min INTEGER;
    batch_max INTEGER;
    inserted_rows INTEGER;
    batch_row_count INTEGER;
BEGIN
    -- Determine the range of IDs to process
    SELECT MIN(id), MAX(id) INTO min_id, max_id FROM stage_sib_aadhaar_xml_kyc_address_ids WHERE NOT processed;

    IF min_id IS NULL OR max_id IS NULL THEN
        RAISE NOTICE 'No unprocessed records in stage_sib_aadhaar_xml_kyc_address_ids.';
        RETURN;
    END IF;

    -- Initialize batch boundaries
    batch_min := min_id;
    batch_max := min_id + batch_size - 1;

    -- Start the batch loop
    WHILE batch_min <= max_id LOOP
        -- Check if the current batch range has unprocessed items
        SELECT COUNT(1) INTO batch_row_count FROM stage_sib_aadhaar_xml_kyc_address_ids WHERE id BETWEEN batch_min AND batch_max AND NOT processed;

        IF batch_row_count > 0 THEN
            BEGIN
                -- 3. Select the final address rows and join to the customer table for customer_no.
                INSERT INTO temp_sib_address (
                    address_id, type, line1, line2, line3, landmark, pincode, city, state, country,
                    latitude, longitude, customer_no, source, created_at, updated_at
                )
                SELECT
                    a.id AS address_id, a.type, a.line1, a.line2, a.line3, a.landmark, a.pincode, a.city, a.state, a.country,
                    a.latitude, a.longitude, cust.customer_no, a.source, a.created_at, a.updated_at
                FROM (
                    -- 2. Collect unique, non-null address foreign key values from the target aadhaar_xml_kyc records in the current batch.
                    SELECT DISTINCT
                        axk.address AS address_id -- ASSUMPTION: 'address' is the foreign key column to 'public.address'
                    FROM stage_sib_aadhaar_xml_kyc_address_ids s
                    INNER JOIN public.aadhaar_xml_kyc axk ON axk.id = s.offline_aadhaar_xml_kyc_id
                    WHERE s.id BETWEEN batch_min AND batch_max AND s.processed = FALSE
                ) flat_ids
                INNER JOIN public.address a ON a.id = flat_ids.address_id
                INNER JOIN public.customer cust ON a.customer_id = cust.id
                WHERE flat_ids.address_id IS NOT NULL;

                -- Mark batch as processed
                UPDATE stage_sib_aadhaar_xml_kyc_address_ids SET processed = TRUE WHERE id BETWEEN batch_min AND batch_max AND processed = FALSE;

                -- Log the result of the batch
                GET DIAGNOSTICS inserted_rows = ROW_COUNT;
                RAISE NOTICE 'Batch ids % to % processed: offline_aadhaar_xml_kyc_ids %, rows inserted %', batch_min, batch_max, batch_row_count, inserted_rows;
            EXCEPTION
                WHEN OTHERS THEN
                    RAISE WARNING 'Batch ids % to % failed: %', batch_min, batch_max, SQLERRM;
                    RAISE NOTICE 'Rolling back this batch. No changes made for batch.';
            END;
        END IF;

        -- Move to the next batch
        batch_min := batch_min + batch_size;
        batch_max := batch_max + batch_size;
    END LOOP;
END $$;
```

---

## Bank: FED

> tenant_id: 9916649609

### KYC Table: aadhaar_ekyc_web

**Step 1 —** Create staging and output tables

```sql
-- Staging AADHAAR_EKYC_WEB table with id for batching and processed flag
CREATE UNLOGGED TABLE IF NOT EXISTS stage_fed_aadhaar_ekyc_web_address_ids (
    id SERIAL PRIMARY KEY,
    aadhaar_web_ekyc_id BIGINT,
    processed BOOLEAN DEFAULT FALSE
);

-- Output table
CREATE UNLOGGED TABLE IF NOT EXISTS temp_fed_address (
    id BIGSERIAL PRIMARY KEY, -- Primary key for the temp table
    address_id BIGINT,       -- Corresponds to public.address.id
    type VARCHAR,
    line1 VARCHAR,
    line2 VARCHAR,
    line3 VARCHAR,
    landmark VARCHAR,
    pincode VARCHAR,
    city VARCHAR,
    state VARCHAR,
    country VARCHAR,
    latitude character varying(45),
    longitude character varying(45),
    customer_no VARCHAR(50),
    source VARCHAR,
    created_at TIMESTAMP WITHOUT TIME ZONE,
    updated_at TIMESTAMP WITHOUT TIME ZONE
);
```

**Step 2 —** Populate staging table

```sql
INSERT INTO stage_fed_aadhaar_ekyc_web_address_ids (aadhaar_web_ekyc_id)
SELECT DISTINCT ck.aadhaar_web_ekyc_id
FROM public.customer_kyc ck
WHERE ck.tenant_id = 9916649609; -- Insert correct tenant id 
```

**Step 3 —** Batch migration DO block

```sql
DO $$
DECLARE
    batch_size INTEGER := 10000;
    min_id INTEGER;
    max_id INTEGER;
    batch_min INTEGER;
    batch_max INTEGER;
    inserted_rows INTEGER;
    batch_row_count INTEGER;
BEGIN
    -- Determine the range of IDs to process
    SELECT MIN(id), MAX(id) INTO min_id, max_id FROM stage_fed_aadhaar_ekyc_web_address_ids WHERE NOT processed;

    IF min_id IS NULL OR max_id IS NULL THEN
        RAISE NOTICE 'No unprocessed records in stage_fed_aadhaar_ekyc_web_address_ids.';
        RETURN;
    END IF;

    -- Initialize batch boundaries
    batch_min := min_id;
    batch_max := min_id + batch_size - 1;

    -- Start the batch loop
    WHILE batch_min <= max_id LOOP
        -- Check if the current batch range has unprocessed items
        SELECT COUNT(1) INTO batch_row_count FROM stage_fed_aadhaar_ekyc_web_address_ids WHERE id BETWEEN batch_min AND batch_max AND NOT processed;

        IF batch_row_count > 0 THEN
            BEGIN
                -- 3. Select the final address rows and join to the customer table for customer_no.
                INSERT INTO temp_fed_address (
                    address_id, type, line1, line2, line3, landmark, pincode, city, state, country,
                    latitude, longitude, customer_no, source, created_at, updated_at
                )
                SELECT
                    a.id AS address_id, a.type, a.line1, a.line2, a.line3, a.landmark, a.pincode, a.city, a.state, a.country,
                    a.latitude, a.longitude, cust.customer_no, a.source, a.created_at, a.updated_at
                FROM (
                    -- 2. Collect unique, non-null address foreign key values from the target aadhaar_ekyc_web records in the current batch.
                    SELECT DISTINCT
                        aew.address AS address_id -- ASSUMPTION: 'address' is the foreign key column to 'public.address'
                    FROM stage_fed_aadhaar_ekyc_web_address_ids s
                    INNER JOIN public.aadhaar_ekyc_web aew ON aew.id = s.aadhaar_web_ekyc_id
                    WHERE s.id BETWEEN batch_min AND batch_max AND s.processed = FALSE
                ) flat_ids
                INNER JOIN public.address a ON a.id = flat_ids.address_id
                INNER JOIN public.customer cust ON a.customer_id = cust.id
                WHERE flat_ids.address_id IS NOT NULL;

                -- Mark batch as processed
                UPDATE stage_fed_aadhaar_ekyc_web_address_ids SET processed = TRUE WHERE id BETWEEN batch_min AND batch_max AND processed = FALSE;

                -- Log the result of the batch
                GET DIAGNOSTICS inserted_rows = ROW_COUNT;
                RAISE NOTICE 'Batch ids % to % processed: aadhaar_web_ekyc_ids %, rows inserted %', batch_min, batch_max, batch_row_count, inserted_rows;
            EXCEPTION
                WHEN OTHERS THEN
                    RAISE WARNING 'Batch ids % to % failed: %', batch_min, batch_max, SQLERRM;
                    RAISE NOTICE 'Rolling back this batch. No changes made for batch.';
            END;
        END IF;

        -- Move to the next batch
        batch_min := batch_min + batch_size;
        batch_max := batch_max + batch_size;
    END LOOP;
END $$;
```

---

### KYC Table: ckyc

**Step 1 —** Create staging and output tables

```sql
-- Staging CKYC table with id for batching and processed flag
CREATE UNLOGGED TABLE IF NOT EXISTS stage_fed_ckyc_address_ids (
    id SERIAL PRIMARY KEY,
    ckyc_id BIGINT,
    processed BOOLEAN DEFAULT FALSE
);

-- Output table
CREATE UNLOGGED TABLE IF NOT EXISTS temp_fed_address (
    id BIGSERIAL PRIMARY KEY, -- Primary key for the temp table
    address_id BIGINT,       -- Corresponds to public.address.id
    type VARCHAR,
    line1 VARCHAR,
    line2 VARCHAR,
    line3 VARCHAR,
    landmark VARCHAR,
    pincode VARCHAR,
    city VARCHAR,
    state VARCHAR,
    country VARCHAR,
    latitude character varying(45),
    longitude character varying(45),
    customer_no VARCHAR(50),
    source VARCHAR,
    created_at TIMESTAMP WITHOUT TIME ZONE,
    updated_at TIMESTAMP WITHOUT TIME ZONE
);
```

**Step 2 —** Populate staging table

```sql
INSERT INTO stage_fed_ckyc_address_ids (ckyc_id)
SELECT DISTINCT ck.ckyc_id
FROM public.customer_kyc ck
WHERE ck.tenant_id = 9916649609; -- Insert correct tenant id
```

**Step 3 —** Batch migration DO block

```sql
DO $$
DECLARE
    batch_size INTEGER := 10000;
    min_id INTEGER;
    max_id INTEGER;
    batch_min INTEGER;
    batch_max INTEGER;
    inserted_rows INTEGER;
    batch_row_count INTEGER;
BEGIN
    -- Determine the range of IDs to process
    SELECT MIN(id), MAX(id) INTO min_id, max_id FROM stage_fed_ckyc_address_ids WHERE NOT processed;

    IF min_id IS NULL OR max_id IS NULL THEN
        RAISE NOTICE 'No unprocessed records in stage_fed_ckyc_address_ids.';
        RETURN;
    END IF;

    -- Initialize batch boundaries
    batch_min := min_id;
    batch_max := min_id + batch_size - 1;

    -- Start the batch loop
    WHILE batch_min <= max_id LOOP
        -- Check if the current batch range has unprocessed items
        SELECT COUNT(1) INTO batch_row_count FROM stage_fed_ckyc_address_ids WHERE id BETWEEN batch_min AND batch_max AND NOT processed;

        IF batch_row_count > 0 THEN
            BEGIN
                -- 3. Select the final address rows and join to the customer table for customer_no.
                INSERT INTO temp_fed_address (
                    address_id, type, line1, line2, line3, landmark, pincode, city, state, country,
                    latitude, longitude, customer_no, source, created_at, updated_at
                )
                SELECT
                    a.id AS address_id, a.type, a.line1, a.line2, a.line3, a.landmark, a.pincode, a.city, a.state, a.country,
                    a.latitude, a.longitude, cust.customer_no, a.source, a.created_at, a.updated_at
                FROM (
                    -- 2. Collect all unique, non-null address IDs from the three nullable columns in the current batch.
                    SELECT DISTINCT unnest(array[
                        c.permanent_address_id,
                        c.correspondence_address_id,
                        c.tax_address_id
                    ]) AS address_id
                    FROM stage_fed_ckyc_address_ids s
                    INNER JOIN public.ckyc c ON c.id = s.ckyc_id
                    WHERE s.id BETWEEN batch_min AND batch_max AND s.processed = FALSE
                ) flat_ids
                INNER JOIN public.address a ON a.id = flat_ids.address_id
                INNER JOIN public.customer cust ON a.customer_id = cust.id
                WHERE flat_ids.address_id IS NOT NULL;

                -- Mark batch as processed
                UPDATE stage_fed_ckyc_address_ids SET processed = TRUE WHERE id BETWEEN batch_min AND batch_max AND processed = FALSE;

                -- Log the result of the batch
                GET DIAGNOSTICS inserted_rows = ROW_COUNT;
                RAISE NOTICE 'Batch ids % to % processed: ckyc_ids %, rows inserted %', batch_min, batch_max, batch_row_count, inserted_rows;
            EXCEPTION
                WHEN OTHERS THEN
                    RAISE WARNING 'Batch ids % to % failed: %', batch_min, batch_max, SQLERRM;
                    RAISE NOTICE 'Rolling back this batch. No changes made for batch.';
            END;
        END IF;

        -- Move to the next batch
        batch_min := batch_min + batch_size;
        batch_max := batch_max + batch_size;
    END LOOP;
END $$;
```

---

## Bank: CSB

> tenant_id: 6451955689

### KYC Table: aadhaar_ekyc_web

**Step 1 —** Create staging and output tables

```sql
-- Staging AADHAAR_EKYC_WEB table with id for batching and processed flag
CREATE UNLOGGED TABLE IF NOT EXISTS stage_csb_aadhaar_ekyc_web_address_ids (
    id SERIAL PRIMARY KEY,
    aadhaar_web_ekyc_id BIGINT,
    processed BOOLEAN DEFAULT FALSE
);

-- Output table
CREATE UNLOGGED TABLE IF NOT EXISTS temp_csb_address (
    id BIGSERIAL PRIMARY KEY, -- Primary key for the temp table
    address_id BIGINT,       -- Corresponds to public.address.id
    type VARCHAR,
    line1 VARCHAR,
    line2 VARCHAR,
    line3 VARCHAR,
    landmark VARCHAR,
    pincode VARCHAR,
    city VARCHAR,
    state VARCHAR,
    country VARCHAR,
    latitude character varying(45),
    longitude character varying(45),
    customer_no VARCHAR(50),
    source VARCHAR,
    created_at TIMESTAMP WITHOUT TIME ZONE,
    updated_at TIMESTAMP WITHOUT TIME ZONE
);
```

**Step 2 —** Populate staging table

```sql
INSERT INTO stage_csb_aadhaar_ekyc_web_address_ids (aadhaar_web_ekyc_id)
SELECT DISTINCT ck.aadhaar_web_ekyc_id
FROM public.customer_kyc ck
WHERE ck.tenant_id = 6451955689; -- Insert correct tenant id
```

**Step 3 —** Batch migration DO block

```sql
DO $$
DECLARE
    batch_size INTEGER := 10000;
    min_id INTEGER;
    max_id INTEGER;
    batch_min INTEGER;
    batch_max INTEGER;
    inserted_rows INTEGER;
    batch_row_count INTEGER;
BEGIN
    -- Determine the range of IDs to process
    SELECT MIN(id), MAX(id) INTO min_id, max_id FROM stage_csb_aadhaar_ekyc_web_address_ids WHERE NOT processed;

    IF min_id IS NULL OR max_id IS NULL THEN
        RAISE NOTICE 'No unprocessed records in stage_csb_aadhaar_ekyc_web_address_ids.';
        RETURN;
    END IF;

    -- Initialize batch boundaries
    batch_min := min_id;
    batch_max := min_id + batch_size - 1;

    -- Start the batch loop
    WHILE batch_min <= max_id LOOP
        -- Check if the current batch range has unprocessed items
        SELECT COUNT(1) INTO batch_row_count FROM stage_csb_aadhaar_ekyc_web_address_ids WHERE id BETWEEN batch_min AND batch_max AND NOT processed;

        IF batch_row_count > 0 THEN
            BEGIN
                -- 3. Select the final address rows and join to the customer table for customer_no.
                INSERT INTO temp_csb_address (
                    address_id, type, line1, line2, line3, landmark, pincode, city, state, country,
                    latitude, longitude, customer_no, source, created_at, updated_at
                )
                SELECT
                    a.id AS address_id, a.type, a.line1, a.line2, a.line3, a.landmark, a.pincode, a.city, a.state, a.country,
                    a.latitude, a.longitude, cust.customer_no, a.source, a.created_at, a.updated_at
                FROM (
                    -- 2. Collect unique, non-null address foreign key values from the target aadhaar_ekyc_web records in the current batch.
                    SELECT DISTINCT
                        aew.address AS address_id -- ASSUMPTION: 'address' is the foreign key column to 'public.address'
                    FROM stage_csb_aadhaar_ekyc_web_address_ids s
                    INNER JOIN public.aadhaar_ekyc_web aew ON aew.id = s.aadhaar_web_ekyc_id
                    WHERE s.id BETWEEN batch_min AND batch_max AND s.processed = FALSE
                ) flat_ids
                INNER JOIN public.address a ON a.id = flat_ids.address_id
                INNER JOIN public.customer cust ON a.customer_id = cust.id
                WHERE flat_ids.address_id IS NOT NULL;

                -- Mark batch as processed
                UPDATE stage_csb_aadhaar_ekyc_web_address_ids SET processed = TRUE WHERE id BETWEEN batch_min AND batch_max AND processed = FALSE;

                -- Log the result of the batch
                GET DIAGNOSTICS inserted_rows = ROW_COUNT;
                RAISE NOTICE 'Batch ids % to % processed: aadhaar_web_ekyc_ids %, rows inserted %', batch_min, batch_max, batch_row_count, inserted_rows;
            EXCEPTION
                WHEN OTHERS THEN
                    RAISE WARNING 'Batch ids % to % failed: %', batch_min, batch_max, SQLERRM;
                    RAISE NOTICE 'Rolling back this batch. No changes made for batch.';
            END;
        END IF;

        -- Move to the next batch
        batch_min := batch_min + batch_size;
        batch_max := batch_max + batch_size;
    END LOOP;
END $$;
```

---

### #todo KYC Table: aadhaar_xml_kyc

**Step 1 —** Create staging and output tables

```sql
-- Staging AADHAAR_XML_KYC table with id for batching and processed flag
CREATE UNLOGGED TABLE IF NOT EXISTS stage_csb_aadhaar_xml_kyc_address_ids (
    id SERIAL PRIMARY KEY,
    offline_aadhaar_xml_kyc_id BIGINT,
    processed BOOLEAN DEFAULT FALSE
);
```

**Step 2 —** Populate staging table

```sql
INSERT INTO stage_csb_aadhaar_xml_kyc_address_ids (offline_aadhaar_xml_kyc_id)
SELECT DISTINCT ck.offline_aadhaar_xml_kyc_id
FROM public.customer_kyc ck
WHERE ck.tenant_id = 6451955689; -- Insert correct tenant id
```

**Step 3 —** Batch migration DO block

```sql
DO $$
DECLARE
    batch_size INTEGER := 10000;
    min_id INTEGER;
    max_id INTEGER;
    batch_min INTEGER;
    batch_max INTEGER;
    inserted_rows INTEGER;
    batch_row_count INTEGER;
BEGIN
    -- Determine the range of IDs to process
    SELECT MIN(id), MAX(id) INTO min_id, max_id FROM stage_csb_aadhaar_xml_kyc_address_ids WHERE NOT processed;

    IF min_id IS NULL OR max_id IS NULL THEN
        RAISE NOTICE 'No unprocessed records in stage_csb_aadhaar_xml_kyc_address_ids.';
        RETURN;
    END IF;

    -- Initialize batch boundaries
    batch_min := min_id;
    batch_max := min_id + batch_size - 1;

    -- Start the batch loop
    WHILE batch_min <= max_id LOOP
        -- Check if the current batch range has unprocessed items
        SELECT COUNT(1) INTO batch_row_count FROM stage_csb_aadhaar_xml_kyc_address_ids WHERE id BETWEEN batch_min AND batch_max AND NOT processed;

        IF batch_row_count > 0 THEN
            BEGIN
                -- 3. Select the final address rows and join to the customer table for customer_no.
                INSERT INTO temp_csb_address (
                    address_id, type, line1, line2, line3, landmark, pincode, city, state, country,
                    latitude, longitude, customer_no, source, created_at, updated_at
                )
                SELECT
                    a.id AS address_id, a.type, a.line1, a.line2, a.line3, a.landmark, a.pincode, a.city, a.state, a.country,
                    a.latitude, a.longitude, cust.customer_no, a.source, a.created_at, a.updated_at
                FROM (
                    -- 2. Collect unique, non-null address foreign key values from the target aadhaar_xml_kyc records in the current batch.
                    SELECT DISTINCT
                        axk.address AS address_id -- ASSUMPTION: 'address' is the foreign key column to 'public.address'
                    FROM stage_csb_aadhaar_xml_kyc_address_ids s
                    INNER JOIN public.aadhaar_xml_kyc axk ON axk.id = s.offline_aadhaar_xml_kyc_id
                    WHERE s.id BETWEEN batch_min AND batch_max AND s.processed = FALSE
                ) flat_ids
                INNER JOIN public.address a ON a.id = flat_ids.address_id
                INNER JOIN public.customer cust ON a.customer_id = cust.id
                WHERE flat_ids.address_id IS NOT NULL;

                -- Mark batch as processed
                UPDATE stage_csb_aadhaar_xml_kyc_address_ids SET processed = TRUE WHERE id BETWEEN batch_min AND batch_max AND processed = FALSE;

                -- Log the result of the batch
                GET DIAGNOSTICS inserted_rows = ROW_COUNT;
                RAISE NOTICE 'Batch ids % to % processed: offline_aadhaar_xml_kyc_ids %, rows inserted %', batch_min, batch_max, batch_row_count, inserted_rows;
            EXCEPTION
                WHEN OTHERS THEN
                    RAISE WARNING 'Batch ids % to % failed: %', batch_min, batch_max, SQLERRM;
                    RAISE NOTICE 'Rolling back this batch. No changes made for batch.';
            END;
        END IF;

        -- Move to the next batch
        batch_min := batch_min + batch_size;
        batch_max := batch_max + batch_size;
    END LOOP;
END $$;
```

---

## Bank: IDIB

> tenant_id: 8964592742

### KYC Table: aadhaar_ekyc_web

**Step 1 —** Create staging and output tables

```sql
-- Staging AADHAAR_EKYC_WEB table with id for batching and processed flag
CREATE UNLOGGED TABLE IF NOT EXISTS stage_idib_aadhaar_ekyc_web_address_ids (
    id SERIAL PRIMARY KEY,
    aadhaar_web_ekyc_id BIGINT,
    processed BOOLEAN DEFAULT FALSE
);

-- Output table
CREATE UNLOGGED TABLE IF NOT EXISTS temp_idib_address (
    id BIGSERIAL PRIMARY KEY, -- Primary key for the temp table
    address_id BIGINT,       -- Corresponds to public.address.id
    type VARCHAR,
    line1 VARCHAR,
    line2 VARCHAR,
    line3 VARCHAR,
    landmark VARCHAR,
    pincode VARCHAR,
    city VARCHAR,
    state VARCHAR,
    country VARCHAR,
    latitude character varying(45),
    longitude character varying(45),
    customer_no VARCHAR(50),
    source VARCHAR,
    created_at TIMESTAMP WITHOUT TIME ZONE,
    updated_at TIMESTAMP WITHOUT TIME ZONE
);
```

**Step 2 —** Populate staging table

```sql
INSERT INTO stage_idib_aadhaar_ekyc_web_address_ids (aadhaar_web_ekyc_id)
SELECT DISTINCT ck.aadhaar_web_ekyc_id
FROM public.customer_kyc ck
WHERE ck.tenant_id = 8964592742; -- Insert correct tenant id
```

**Step 3 —** Batch migration DO block

```sql
DO $$
DECLARE
    batch_size INTEGER := 10000;
    min_id INTEGER;
    max_id INTEGER;
    batch_min INTEGER;
    batch_max INTEGER;
    inserted_rows INTEGER;
    batch_row_count INTEGER;
BEGIN
    -- Determine the range of IDs to process
    SELECT MIN(id), MAX(id) INTO min_id, max_id FROM stage_idib_aadhaar_ekyc_web_address_ids WHERE NOT processed;

    IF min_id IS NULL OR max_id IS NULL THEN
        RAISE NOTICE 'No unprocessed records in stage_idib_aadhaar_ekyc_web_address_ids.';
        RETURN;
    END IF;

    -- Initialize batch boundaries
    batch_min := min_id;
    batch_max := min_id + batch_size - 1;

    -- Start the batch loop
    WHILE batch_min <= max_id LOOP
        -- Check if the current batch range has unprocessed items
        SELECT COUNT(1) INTO batch_row_count FROM stage_idib_aadhaar_ekyc_web_address_ids WHERE id BETWEEN batch_min AND batch_max AND NOT processed;

        IF batch_row_count > 0 THEN
            BEGIN
                -- 3. Select the final address rows and join to the customer table for customer_no.
                INSERT INTO temp_idib_address (
                    address_id, type, line1, line2, line3, landmark, pincode, city, state, country,
                    latitude, longitude, customer_no, source, created_at, updated_at
                )
                SELECT
                    a.id AS address_id, a.type, a.line1, a.line2, a.line3, a.landmark, a.pincode, a.city, a.state, a.country,
                    a.latitude, a.longitude, cust.customer_no, a.source, a.created_at, a.updated_at
                FROM (
                    -- 2. Collect unique, non-null address foreign key values from the target aadhaar_ekyc_web records in the current batch.
                    SELECT DISTINCT
                        aew.address AS address_id -- ASSUMPTION: 'address' is the foreign key column to 'public.address'
                    FROM stage_idib_aadhaar_ekyc_web_address_ids s
                    INNER JOIN public.aadhaar_ekyc_web aew ON aew.id = s.aadhaar_web_ekyc_id
                    WHERE s.id BETWEEN batch_min AND batch_max AND s.processed = FALSE
                ) flat_ids
                INNER JOIN public.address a ON a.id = flat_ids.address_id
                INNER JOIN public.customer cust ON a.customer_id = cust.id
                WHERE flat_ids.address_id IS NOT NULL;

                -- Mark batch as processed
                UPDATE stage_idib_aadhaar_ekyc_web_address_ids SET processed = TRUE WHERE id BETWEEN batch_min AND batch_max AND processed = FALSE;

                -- Log the result of the batch
                GET DIAGNOSTICS inserted_rows = ROW_COUNT;
                RAISE NOTICE 'Batch ids % to % processed: aadhaar_web_ekyc_ids %, rows inserted %', batch_min, batch_max, batch_row_count, inserted_rows;
            EXCEPTION
                WHEN OTHERS THEN
                    RAISE WARNING 'Batch ids % to % failed: %', batch_min, batch_max, SQLERRM;
                    RAISE NOTICE 'Rolling back this batch. No changes made for batch.';
            END;
        END IF;

        -- Move to the next batch
        batch_min := batch_min + batch_size;
        batch_max := batch_max + batch_size;
    END LOOP;
END $$;
```

---

### KYC Table: ckyc

**Step 1 —** Create staging and output tables

```sql
-- Staging CKYC table with id for batching and processed flag
CREATE UNLOGGED TABLE IF NOT EXISTS stage_idib_ckyc_address_ids (
    id SERIAL PRIMARY KEY,
    ckyc_id BIGINT,
    processed BOOLEAN DEFAULT FALSE
);

-- Output table
CREATE UNLOGGED TABLE IF NOT EXISTS temp_idib_address (
    id BIGSERIAL PRIMARY KEY, -- Primary key for the temp table
    address_id BIGINT,       -- Corresponds to public.address.id
    type VARCHAR,
    line1 VARCHAR,
    line2 VARCHAR,
    line3 VARCHAR,
    landmark VARCHAR,
    pincode VARCHAR,
    city VARCHAR,
    state VARCHAR,
    country VARCHAR,
    latitude character varying(45),
    longitude character varying(45),
    customer_no VARCHAR(50),
    source VARCHAR,
    created_at TIMESTAMP WITHOUT TIME ZONE,
    updated_at TIMESTAMP WITHOUT TIME ZONE
);
```

**Step 2 —** Populate staging table

```sql
INSERT INTO stage_idib_ckyc_address_ids (ckyc_id)
SELECT DISTINCT ck.ckyc_id
FROM public.customer_kyc ck
WHERE ck.tenant_id = 8964592742; -- Insert correct tenant id
```

**Step 3 —** Batch migration DO block

```sql
DO $$
DECLARE
    batch_size INTEGER := 10000;
    min_id INTEGER;
    max_id INTEGER;
    batch_min INTEGER;
    batch_max INTEGER;
    inserted_rows INTEGER;
    batch_row_count INTEGER;
BEGIN
    -- Determine the range of IDs to process
    SELECT MIN(id), MAX(id) INTO min_id, max_id FROM stage_idib_ckyc_address_ids WHERE NOT processed;

    IF min_id IS NULL OR max_id IS NULL THEN
        RAISE NOTICE 'No unprocessed records in stage_idib_ckyc_address_ids.';
        RETURN;
    END IF;

    -- Initialize batch boundaries
    batch_min := min_id;
    batch_max := min_id + batch_size - 1;

    -- Start the batch loop
    WHILE batch_min <= max_id LOOP
        -- Check if the current batch range has unprocessed items
        SELECT COUNT(1) INTO batch_row_count FROM stage_idib_ckyc_address_ids WHERE id BETWEEN batch_min AND batch_max AND NOT processed;

        IF batch_row_count > 0 THEN
            BEGIN
                -- 3. Select the final address rows and join to the customer table for customer_no.
                INSERT INTO temp_idib_address (
                    address_id, type, line1, line2, line3, landmark, pincode, city, state, country,
                    latitude, longitude, customer_no, source, created_at, updated_at
                )
                SELECT
                    a.id AS address_id, a.type, a.line1, a.line2, a.line3, a.landmark, a.pincode, a.city, a.state, a.country,
                    a.latitude, a.longitude, cust.customer_no, a.source, a.created_at, a.updated_at
                FROM (
                    -- 2. Collect all unique, non-null address IDs from the three nullable columns in the current batch.
                    SELECT DISTINCT unnest(array[
                        c.permanent_address_id,
                        c.correspondence_address_id,
                        c.tax_address_id
                    ]) AS address_id
                    FROM stage_idib_ckyc_address_ids s
                    INNER JOIN public.ckyc c ON c.id = s.ckyc_id
                    WHERE s.id BETWEEN batch_min AND batch_max AND s.processed = FALSE
                ) flat_ids
                INNER JOIN public.address a ON a.id = flat_ids.address_id
                INNER JOIN public.customer cust ON a.customer_id = cust.id
                WHERE flat_ids.address_id IS NOT NULL;

                -- Mark batch as processed
                UPDATE stage_idib_ckyc_address_ids SET processed = TRUE WHERE id BETWEEN batch_min AND batch_max AND processed = FALSE;

                -- Log the result of the batch
                GET DIAGNOSTICS inserted_rows = ROW_COUNT;
                RAISE NOTICE 'Batch ids % to % processed: ckyc_ids %, rows inserted %', batch_min, batch_max, batch_row_count, inserted_rows;
            EXCEPTION
                WHEN OTHERS THEN
                    RAISE WARNING 'Batch ids % to % failed: %', batch_min, batch_max, SQLERRM;
                    RAISE NOTICE 'Rolling back this batch. No changes made for batch.';
            END;
        END IF;

        -- Move to the next batch
        batch_min := batch_min + batch_size;
        batch_max := batch_max + batch_size;
    END LOOP;
END $$;
```

---

### #todo KYC Table: aadhaar_xml_kyc

**Step 1 —** Create staging and output tables

```sql
-- Staging AADHAAR_XML_KYC table with id for batching and processed flag
CREATE UNLOGGED TABLE IF NOT EXISTS stage_idib_aadhaar_xml_kyc_address_ids (
    id SERIAL PRIMARY KEY,
    offline_aadhaar_xml_kyc_id BIGINT,
    processed BOOLEAN DEFAULT FALSE
);
```

**Step 2 —** Populate staging table

```sql
INSERT INTO stage_idib_aadhaar_xml_kyc_address_ids (offline_aadhaar_xml_kyc_id)
SELECT DISTINCT ck.offline_aadhaar_xml_kyc_id
FROM public.customer_kyc ck
WHERE ck.tenant_id = 8964592742; -- Insert correct tenant id
```

**Step 3 —** Batch migration DO block

```sql
DO $$
DECLARE
    batch_size INTEGER := 10000;
    min_id INTEGER;
    max_id INTEGER;
    batch_min INTEGER;
    batch_max INTEGER;
    inserted_rows INTEGER;
    batch_row_count INTEGER;
BEGIN
    -- Determine the range of IDs to process
    SELECT MIN(id), MAX(id) INTO min_id, max_id FROM stage_idib_aadhaar_xml_kyc_address_ids WHERE NOT processed;

    IF min_id IS NULL OR max_id IS NULL THEN
        RAISE NOTICE 'No unprocessed records in stage_idib_aadhaar_xml_kyc_address_ids.';
        RETURN;
    END IF;

    -- Initialize batch boundaries
    batch_min := min_id;
    batch_max := min_id + batch_size - 1;

    -- Start the batch loop
    WHILE batch_min <= max_id LOOP
        -- Check if the current batch range has unprocessed items
        SELECT COUNT(1) INTO batch_row_count FROM stage_idib_aadhaar_xml_kyc_address_ids WHERE id BETWEEN batch_min AND batch_max AND NOT processed;

        IF batch_row_count > 0 THEN
            BEGIN
                -- 3. Select the final address rows and join to the customer table for customer_no.
                INSERT INTO temp_idib_address (
                    address_id, type, line1, line2, line3, landmark, pincode, city, state, country,
                    latitude, longitude, customer_no, source, created_at, updated_at
                )
                SELECT
                    a.id AS address_id, a.type, a.line1, a.line2, a.line3, a.landmark, a.pincode, a.city, a.state, a.country,
                    a.latitude, a.longitude, cust.customer_no, a.source, a.created_at, a.updated_at
                FROM (
                    -- 2. Collect unique, non-null address foreign key values from the target aadhaar_xml_kyc records in the current batch.
                    SELECT DISTINCT
                        axk.address AS address_id -- ASSUMPTION: 'address' is the foreign key column to 'public.address'
                    FROM stage_idib_aadhaar_xml_kyc_address_ids s
                    INNER JOIN public.aadhaar_xml_kyc axk ON axk.id = s.offline_aadhaar_xml_kyc_id
                    WHERE s.id BETWEEN batch_min AND batch_max AND s.processed = FALSE
                ) flat_ids
                INNER JOIN public.address a ON a.id = flat_ids.address_id
                INNER JOIN public.customer cust ON a.customer_id = cust.id
                WHERE flat_ids.address_id IS NOT NULL;

                -- Mark batch as processed
                UPDATE stage_idib_aadhaar_xml_kyc_address_ids SET processed = TRUE WHERE id BETWEEN batch_min AND batch_max AND processed = FALSE;

                -- Log the result of the batch
                GET DIAGNOSTICS inserted_rows = ROW_COUNT;
                RAISE NOTICE 'Batch ids % to % processed: offline_aadhaar_xml_kyc_ids %, rows inserted %', batch_min, batch_max, batch_row_count, inserted_rows;
            EXCEPTION
                WHEN OTHERS THEN
                    RAISE WARNING 'Batch ids % to % failed: %', batch_min, batch_max, SQLERRM;
                    RAISE NOTICE 'Rolling back this batch. No changes made for batch.';
            END;
        END IF;

        -- Move to the next batch
        batch_min := batch_min + batch_size;
        batch_max := batch_max + batch_size;
    END LOOP;
END $$;
```
