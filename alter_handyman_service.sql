-- --------------------------------------------------------

--
-- Table structure for table `wallets`
--

CREATE TABLE `wallets` (
  `id` bigint UNSIGNED NOT NULL,
  `title` text COLLATE utf8mb4_unicode_ci,
  `user_id` bigint UNSIGNED DEFAULT NULL,
  `amount` double DEFAULT NULL,
  `status` tinyint DEFAULT '1' COMMENT '1- Active , 0- InActive',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------
--
-- Indexes for table `wallets`
--
ALTER TABLE `wallets`
  ADD PRIMARY KEY (`id`),
  ADD KEY `wallets_user_id_foreign` (`user_id`);

ALTER TABLE `wallets`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

ALTER TABLE `wallets`
  ADD CONSTRAINT `wallets_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (51, '2022_03_30_040831_create_wallets_table', 8);


CREATE TABLE `wallet_histories` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint DEFAULT NULL,
  `datetime` timestamp NULL DEFAULT NULL,
  `activity_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `activity_message` text COLLATE utf8mb4_unicode_ci,
  `activity_data` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Indexes for table `wallet_histories`
--
ALTER TABLE `wallet_histories`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `wallet_histories`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (52, '2022_03_30_043359_create_wallet_histories_table', 8);

CREATE TABLE `sub_categories` (
  `id` bigint UNSIGNED NOT NULL,
  `category_id` bigint UNSIGNED NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `status` tinyint DEFAULT '1' COMMENT '1- Active , 0- InActive',
  `is_featured` tinyint DEFAULT '0',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

ALTER TABLE `sub_categories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sub_categories_category_id_foreign` (`category_id`);

ALTER TABLE `sub_categories`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;
ALTER TABLE `sub_categories`
  ADD CONSTRAINT `sub_categories_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE;
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (53, '2022_03_31_041639_create_sub_categories_table', 8);

CREATE TABLE `service_proofs` (
  `id` bigint UNSIGNED NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `service_id` bigint UNSIGNED DEFAULT NULL,
  `booking_id` bigint UNSIGNED DEFAULT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

ALTER TABLE `service_proofs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `service_proofs_service_id_foreign` (`service_id`),
  ADD KEY `service_proofs_booking_id_foreign` (`booking_id`),
  ADD KEY `service_proofs_user_id_foreign` (`user_id`);

ALTER TABLE `service_proofs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

ALTER TABLE `service_proofs`
  ADD CONSTRAINT `service_proofs_booking_id_foreign` FOREIGN KEY (`booking_id`) REFERENCES `bookings` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `service_proofs_service_id_foreign` FOREIGN KEY (`service_id`) REFERENCES `services` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `service_proofs_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (54, '2022_04_06_100943_create_service_proofs_table', 8);

CREATE TABLE `static_data` (
  `id` bigint UNSIGNED NOT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `label` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` tinyint DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


INSERT INTO `static_data` (`id`, `type`, `label`, `value`, `status`, `created_at`, `updated_at`) VALUES
(1, 'plan_type', 'Unlimited', 'unlimited', 1, '2022-04-21 06:53:03', '2022-04-21 06:53:03'),
(2, 'plan_type', 'Limited', 'limited', 1, '2022-04-21 06:53:03', '2022-04-21 06:53:03'),
(3, 'plan_limit_type', 'Service', 'service', 1, '2022-04-21 06:53:03', '2022-04-21 06:53:03'),
(4, 'plan_limit_type', 'Handyman', 'handyman', 1, '2022-04-21 06:53:03', '2022-04-21 06:53:03'),
(5, 'plan_limit_type', 'Featured Service', 'featured_service', 1, '2022-04-21 06:53:03', '2022-04-21 06:53:03');

ALTER TABLE `static_data`
  ADD PRIMARY KEY (`id`);
  ALTER TABLE `static_data`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (55, '2022_04_21_041519_create_static_data_table', 8);

CREATE TABLE `plan_limits` (
  `id` bigint UNSIGNED NOT NULL,
  `plan_id` bigint UNSIGNED DEFAULT NULL,
  `plan_limitation` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

ALTER TABLE `plan_limits`
  ADD PRIMARY KEY (`id`),
  ADD KEY `plan_limits_plan_id_foreign` (`plan_id`);
ALTER TABLE `plan_limits`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

ALTER TABLE `plan_limits`
  ADD CONSTRAINT `plan_limits_plan_id_foreign` FOREIGN KEY (`plan_id`) REFERENCES `plans` (`id`) ON DELETE CASCADE;

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (56, '2022_04_22_052403_create_plan_limits_table', 8);

ALTER TABLE `services`  ADD `subcategory_id` BIGINT NULL;    
ALTER TABLE `plans`  ADD `duration` text  NULL ;    
ALTER TABLE `plans`  ADD `description` longtext  NULL ;    
ALTER TABLE `plans`  ADD `plan_type` VARCHAR(255)  NULL ;       

ALTER TABLE `provider_subscriptions`  ADD `plan_limitation` text  NULL ;    
ALTER TABLE `provider_subscriptions`  ADD `duration` text  NULL ;    
ALTER TABLE `provider_subscriptions`  ADD `description` longtext  NULL ;    
ALTER TABLE `provider_subscriptions`  ADD `plan_type` VARCHAR(255)  NULL ;   