-- name: CreateNewMovie :one
INSERT INTO "Movie"(movie_id, movie_name, image_url, runtime, genre, status)
VALUES ($1, $2, $3, $4, $5, $6)
RETURNING *;

-- name: GetMovieById :one
SELECT *
FROM "Movie"
WHERE movie_id = $1;

-- name: GetAllMovieAvailable :many
SELECT *
FROM "Movie"
WHERE status = 'RUNNING';

-- name: GetMovieSelection :many
SELECT DISTINCT M.movie_name, M.movie_id, runtime, genre, status, image_url
FROM "Movie" M
         JOIN "Schedule" S on M.movie_id = S.movie_id
WHERE now() < S.time_end;

-- name: UpdateMovie :one
UPDATE "Movie"
SET movie_name=$2,
    runtime=$3,
    genre=$3,
    status=$4,
    image_url=$5
WHERE movie_id = $1
RETURNING *;

-- name: DeleteMovie :exec
DELETE
FROM "Movie"
WHERE movie_id = $1;