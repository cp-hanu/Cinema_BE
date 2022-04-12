-- name: CreateNewOrder :one
INSERT INTO "Order"(order_id)
VALUES ($1)
RETURNING *;

-- name: CreateOrderFood :one
INSERT INTO "Order_Food"(order_id, food_id)
VALUES ($1, $2)
RETURNING *;

-- name: CreateOrderDrink :one
INSERT INTO "Order_Drink"(order_id, drink_id)
VALUES ($1, $2)
RETURNING *;

-- name: GetOrderIdByTicketId :one
SELECT O.order_id
FROM "Ticket"
         LEFT JOIN "Order" O on "Ticket".order_id = O.order_id
WHERE ticket_id = $1;
-- name: GetListOrderFood :many
SELECT F.food_id, name, price, image_url
FROM "Order"
         INNER JOIN "Order_Food" O on "Order".order_id = O.order_id
         INNER JOIN "Food" F on F.food_id = O.food_id
WHERE O.order_id = $1;

-- name: GetListOrderDrink :many
SELECT D.drink_id, name, price, image_url
FROM "Order"
         INNER JOIN "Order_Drink" OD on "Order".order_id = OD.order_id
         INNER JOIN "Drink" D on D.drink_id = OD.drink_id
WHERE OD.order_id = $1;

-- name: DeleteOrder :exec
DELETE
FROM "Order"
WHERE order_id = $1;