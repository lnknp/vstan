use vstan;

-- Этап 4. Вход в приложение 
SELECT u.user_id, CONCAT_WS(' ', u.last_name, u.first_name, u.patronymic) AS full_name, r.name AS role
FROM users u
JOIN roles r ON r.role_id = u.role_id
WHERE u.login = '94d5ous@gmail.com' AND u.password = 'uzWC67';

-- Этап 5. Каталог товаров (2.7-2.11)
SELECT p.product_id, p.article, pn.name, p.unit, p.price, p.discount, p.stock_qty,
       p.description, p.photo,
       c.name AS category, m.name AS manufacturer, s.name AS supplier
FROM products p
JOIN product_names pn ON pn.name_id = p.name_id
JOIN categories c ON c.category_id = p.category_id
JOIN manufacturers m ON m.manufacturer_id = p.manufacturer_id
JOIN suppliers s ON s.supplier_id = p.supplier_id;

-- Этап 6. Поиск, фильтр и сортировка 
SELECT p.product_id, p.article, pn.name, p.price, p.stock_qty, s.name AS supplier
FROM products p
JOIN product_names pn ON pn.name_id = p.name_id
JOIN suppliers s ON s.supplier_id = p.supplier_id
WHERE pn.name LIKE '%Туфли%' AND p.supplier_id = 1
ORDER BY p.stock_qty DESC;

-- Этап 7. Добавление и редактирование 
-- справочники для выпадающих списков в форме
SELECT category_id, name FROM categories;
SELECT manufacturer_id, name FROM manufacturers;
SELECT supplier_id, name FROM suppliers;
SELECT name_id, name FROM product_names;

-- добавление товара
INSERT INTO products
  (article, name_id, unit, price, discount, stock_qty, description, photo,
   category_id, manufacturer_id, supplier_id)
VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);

-- открыть товар для редактирования
SELECT * FROM products WHERE product_id = ?;

-- сохранить изменения
UPDATE products
SET article=?, name_id=?, unit=?, price=?, discount=?, stock_qty=?, description=?, photo=?,
    category_id=?, manufacturer_id=?, supplier_id=?
WHERE product_id = ?;

-- Этап 8. Защита от удаления купленного товара 
SELECT COUNT(*) AS used_in_orders FROM prodorders WHERE product_id = 8;

-- база должна отказать: ошибка 1451 
DELETE FROM products WHERE product_id = 8;
