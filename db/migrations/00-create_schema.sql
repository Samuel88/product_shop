DROP TABLE IF EXISTS `product_category`;
DROP TABLE IF EXISTS `reviews`;
DROP TABLE IF EXISTS `products`;
DROP TABLE IF EXISTS `categories`;

CREATE TABLE `products`(
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(100) NOT NULL,
    `description` TEXT NOT NULL,
    `price` DECIMAL(8, 2) NOT NULL,
    `image` VARCHAR(255) NOT NULL,
    `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP
);
CREATE TABLE `reviews`(
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `product_id` BIGINT UNSIGNED,
    `name` VARCHAR(100) NOT NULL,
    `rating` TINYINT UNSIGNED NOT NULL,
    `title` VARCHAR(150) NOT NULL,
    `content` TEXT NOT NULL
);
CREATE TABLE `categories`(
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(100) NOT NULL,
    `description` TEXT NOT NULL
);
CREATE TABLE `product_category`(
    `product_id` BIGINT UNSIGNED NOT NULL,
    `category_id` BIGINT UNSIGNED NOT NULL,
    PRIMARY KEY(`product_id`, `category_id`)
);


ALTER TABLE
    `product_category` ADD CONSTRAINT `product_category_product_id_foreign` FOREIGN KEY(`product_id`) REFERENCES `products`(`id`) ON DELETE CASCADE;
ALTER TABLE
    `product_category` ADD CONSTRAINT `product_category_category_id_foreign` FOREIGN KEY(`category_id`) REFERENCES `categories`(`id`) ON DELETE CASCADE;
ALTER TABLE
    `reviews` ADD CONSTRAINT `reviews_product_id_foreign` FOREIGN KEY(`product_id`) REFERENCES `products`(`id`)
        ON DELETE SET NULL;