-- name: CreateNewTier :one
INSERT INTO "Tier"(tier_id, tier_name)
VALUES ($1, $2)
RETURNING *;

-- name: GetAllTier :many
SELECT *
FROM "Tier";

-- name: CreateScheduleTier :one
INSERT INTO "Schedule_Tier"(schedule_id, tier_id, price)
VALUES ($1, $2, $3)
RETURNING *;

-- name: UpdateTierPrice :one
UPDATE "Schedule_Tier"
SET price=$3
WHERE schedule_id = $1
  AND tier_id = $2
RETURNING *;