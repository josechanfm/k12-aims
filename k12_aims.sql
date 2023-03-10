-- phpMyAdmin SQL Dump
-- version 4.9.5deb2
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Feb 10, 2023 at 05:41 PM
-- Server version: 10.3.37-MariaDB-0ubuntu0.20.04.1
-- PHP Version: 8.1.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `k12_aims`
--

-- --------------------------------------------------------

--
-- Table structure for table `addresses`
--

CREATE TABLE `addresses` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `addressable_id` bigint(20) NOT NULL,
  `addressable_type` varchar(255) NOT NULL,
  `zone` varchar(255) NOT NULL,
  `road_name` varchar(255) NOT NULL,
  `building` varchar(255) NOT NULL,
  `overnight` varchar(255) NOT NULL,
  `overnight_address` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `banks`
--

CREATE TABLE `banks` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `bankable_id` bigint(20) NOT NULL,
  `bankable_type` varchar(255) NOT NULL,
  `bank_name` varchar(255) DEFAULT NULL,
  `account_name` varchar(255) DEFAULT NULL,
  `account_number` varchar(255) DEFAULT NULL,
  `currency` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `behaviours`
--

CREATE TABLE `behaviours` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `klass_student_id` bigint(20) NOT NULL,
  `term_id` bigint(20) NOT NULL,
  `genre` varchar(255) NOT NULL,
  `qty` int(11) NOT NULL,
  `date` date NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `remark` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `behaviours`
--

INSERT INTO `behaviours` (`id`, `klass_student_id`, `term_id`, `genre`, `qty`, `date`, `description`, `remark`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 'ABSENT', 1, '2023-02-09', '54', '454', '2023-02-10 01:36:22', '2023-02-10 01:36:22');

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `configs`
--

CREATE TABLE `configs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `key` varchar(255) NOT NULL,
  `value` text NOT NULL,
  `remark` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `configs`
--

INSERT INTO `configs` (`id`, `key`, `value`, `remark`, `created_at`, `updated_at`) VALUES
(1, 'grade_categories', '[{\"value\":\"K\",\"label\":\"K\"},{\"value\":\"P\",\"label\":\"P\"},{\"value\":\"S\",\"label\":\"S\"}]', NULL, NULL, NULL),
(2, 'student_state', '{\"ACT\": \"Active\",\"RES\": \"Resigned\"}', NULL, NULL, NULL),
(3, 'score_template', '{\"TERMS\":[{\"term_id\":\"1\",\"value\":\"term1\",\"label\":\"?????????\"},{\"term_id\":\"2\",\"value\":\"term2\",\"label\":\"?????????\"}],\"COMMENT\":[{\"term_id\":\"1\",\"value\":\"comment\",\"label\":\"??????\"}]}', NULL, NULL, NULL),
(4, 'year_creation', '{ \"kgrade\":3, \"kklass\":3, \"kgradeDefault\":0, \"kklassDefault\":0, \"pgrade\":6, \"pklass\":5, \"pgradeDefault\":6, \"pklassDefault\":4, \"sgrade\":6, \"sklass\":5, \"sgradeDefault\":6, \"sklassDefault\":4 }', NULL, NULL, NULL),
(5, 'klass_letters', '[{\"value\":\"A\",\"label\":\"A\"},{\"value\":\"B\",\"label\":\"B\"},{\"value\":\"C\",\"label\":\"C\"},{\"value\":\"D\",\"label\":\"D\"},{\"value\":\"E\",\"label\":\"E\"},{\"value\":\"F\",\"label\":\"F\"}]', NULL, NULL, NULL),
(6, 'score_columns', '[{\"REG\":\"?????????\"},{\"TST\":\"?????????\"},{\"CLS\":\"????????????\"},{\"EXM\":\"?????????\"}]', NULL, NULL, NULL),
(7, 'subject_types', '[{\"value\":\"SUB\",\"label\":\"??????\"},{\"value\":\"ATT\",\"label\":\"?????????????????????\"},{\"value\":\"RPAL\",\"label\":\"????????????\"},{\"value\":\"LES\",\"label\":\"????????????\"},{\"value\":\"OVA\",\"label\":\"????????????\"}]', NULL, NULL, NULL),
(8, 'study_streams', '[{\"value\":\"ALL\",\"label\":\"??????\"},{\"value\":\"ART\",\"label\":\"??????\"},{\"value\":\"SCI\",\"label\":\"??????\"},{\"value\":\"AAS\",\"label\":\"?????????\"}]', NULL, NULL, NULL),
(9, 'year_terms', '[{\"value\":1,\"label\":\"?????????\"},{\"value\":2,\"label\":\"?????????\"}]', NULL, NULL, NULL),
(10, 'habit_columns', '[\r\n{\"name\":\"health_1\",\"label\":\"????????????????????????\",\"short\":\"??????\"},\r\n{\"name\":\"health_2\",\"label\":\"????????????\",\"short\":\"??????\"},\r\n{\"name\":\"health_3\",\"label\":\"???????????????????????????\",\"short\":\"??????\"},\r\n{\"name\":\"health_4\",\"label\":\"??????????????????????????????\",\"short\":\"??????\"},\r\n{\"name\":\"health_5\",\"label\":\"??????????????????????????????\",\"short\":\"??????\"},\r\n{\"name\":\"behaviour_1\",\"label\":\"??????????????????\",\"short\":\"??????\"},\r\n{\"name\":\"behaviour_2\",\"label\":\"????????????\",\"short\":\"??????\"},\r\n{\"name\":\"behaviour_3\",\"label\":\"????????????????????????\",\"short\":\"??????\"},\r\n{\"name\":\"behaviour_4\",\"label\":\"????????????????????????????????????\",\"short\":\"??????\"},\r\n{\"name\":\"behaviour_5\",\"label\":\"??????????????????????????????\",\"short\":\"??????\"},\r\n{\"name\":\"behaviour_6\",\"label\":\"????????????\",\"short\":\"??????\"},\r\n{\"name\":\"social_1\",\"label\":\"??????\",\"short\":\"??????\"},\r\n{\"name\":\"social_2\",\"label\":\"????????????,????????????\",\"short\":\"??????\"},\r\n{\"name\":\"social_3\",\"label\":\"????????????\",\"short\":\"??????\"},\r\n{\"name\":\"social_4\",\"label\":\"???????????????????????????\",\"short\":\"??????\"},\r\n{\"name\":\"social_5\",\"label\":\"?????????????????????\",\"short\":\"??????\"}\r\n]', NULL, NULL, NULL),
(11, 'behaviour_genres', '[\r\n{\"value\":\"LATE\",\"label\":\"??????\"},\r\n{\"value\":\"ABSENT\",\"label\":\"??????\"},\r\n{\"value\":\"DEMERIT\",\"label\":\"??????\"},\r\n{\"value\":\"FAULT_BIG\",\"label\":\"??????\"},\r\n{\"value\":\"FAULT_SMALL\",\"label\":\"??????\"},\r\n{\"value\":\"CREDIT_BIG\",\"label\":\"??????\"},\r\n{\"value\":\"CREDIT_SMALL\",\"label\":\"??????\"},\r\n{\"value\":\"MERIT\",\"label\":\"??????\"}\r\n]\r\n', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `courses`
--

CREATE TABLE `courses` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `klass_id` bigint(20) NOT NULL,
  `code` varchar(255) NOT NULL,
  `title_zh` varchar(255) NOT NULL,
  `title_en` varchar(255) DEFAULT NULL,
  `type` varchar(6) DEFAULT NULL,
  `stream` varchar(6) DEFAULT NULL,
  `elective` varchar(6) DEFAULT NULL,
  `score_column` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `study_id` bigint(20) DEFAULT NULL,
  `score_column_template` varchar(255) DEFAULT NULL,
  `active` tinyint(4) NOT NULL,
  `socre_scheme` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `courses`
--

INSERT INTO `courses` (`id`, `klass_id`, `code`, `title_zh`, `title_en`, `type`, `stream`, `elective`, `score_column`, `description`, `study_id`, `score_column_template`, `active`, `socre_scheme`, `created_at`, `updated_at`) VALUES
(1, 1, 'CHN', '??????', 'Chinese', NULL, 'ART', '0', NULL, NULL, 1, 'TERMS', 1, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(2, 1, 'ENG', '??????', 'English', NULL, 'ART', '0', NULL, NULL, 2, 'TERMS', 1, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(3, 1, 'MAT', '??????', 'Mathematic', NULL, 'SCI', '0', NULL, NULL, 3, 'TERMS', 1, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(4, 1, 'PHY', '??????', 'Physics', NULL, 'SCI', '1', NULL, NULL, 4, 'TERMS', 1, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(5, 1, 'GEN', '??????', 'General', NULL, 'ART', '1', NULL, NULL, 5, 'TERMS', 1, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(6, 2, 'CHN', '??????', 'Chinese', NULL, 'ART', '0', NULL, NULL, 1, 'TERMS', 1, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(7, 2, 'ENG', '??????', 'English', NULL, 'ART', '0', NULL, NULL, 2, 'TERMS', 1, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(8, 2, 'MAT', '??????', 'Mathematic', NULL, 'SCI', '0', NULL, NULL, 3, 'TERMS', 1, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(9, 2, 'PHY', '??????', 'Physics', NULL, 'SCI', '1', NULL, NULL, 4, 'TERMS', 1, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(10, 2, 'GEN', '??????', 'General', NULL, 'ART', '1', NULL, NULL, 5, 'TERMS', 1, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(11, 63, 'CHN', '??????', 'Chinese', '', 'ART', '0', NULL, NULL, 1, 'TERMS', 1, NULL, '2023-02-05 17:01:21', '2023-02-05 17:01:21'),
(12, 63, 'ENG', '??????', 'English', '', 'ART', '0', NULL, NULL, 2, 'TERMS', 1, NULL, '2023-02-05 17:01:21', '2023-02-05 17:01:21'),
(13, 63, 'MAT', '??????', 'Mathematic', '', 'SCI', '0', NULL, NULL, 3, 'TERMS', 1, NULL, '2023-02-05 17:01:21', '2023-02-05 17:01:21'),
(14, 63, 'PHY', '??????', 'Physics', '', 'SCI', '1', NULL, NULL, 4, 'TERMS', 1, NULL, '2023-02-05 17:01:21', '2023-02-05 17:01:21'),
(15, 63, 'GEN', '??????', 'General', '', 'ART', '1', NULL, NULL, 5, 'TERMS', 1, NULL, '2023-02-05 17:01:21', '2023-02-05 17:01:21'),
(16, 64, 'CHN', '??????', 'Chinese', '', 'ART', '0', NULL, NULL, 1, 'TERMS', 1, NULL, '2023-02-05 17:03:12', '2023-02-05 17:03:12'),
(17, 64, 'ENG', '??????', 'English', '', 'ART', '0', NULL, NULL, 2, 'TERMS', 1, NULL, '2023-02-05 17:03:12', '2023-02-05 17:03:12'),
(18, 64, 'MAT', '??????', 'Mathematic', '', 'SCI', '0', NULL, NULL, 3, 'TERMS', 1, NULL, '2023-02-05 17:03:12', '2023-02-05 17:03:12'),
(19, 64, 'PHY', '??????', 'Physics', '', 'SCI', '1', NULL, NULL, 4, 'TERMS', 1, NULL, '2023-02-05 17:03:12', '2023-02-05 17:03:12'),
(20, 64, 'GEN', '??????', 'General', '', 'ART', '1', NULL, NULL, 5, 'TERMS', 1, NULL, '2023-02-05 17:03:12', '2023-02-05 17:03:12'),
(21, 65, 'REL', '??????', 'Relegion', 'SUB', 'AAS', 'COP', NULL, NULL, 1, 'TERMS', 1, NULL, '2023-02-06 20:51:45', '2023-02-06 20:51:45'),
(22, 65, 'PHY', '??????', 'Physic', 'SUB', 'LIB', 'COP', NULL, NULL, 2, 'TERMS', 1, NULL, '2023-02-06 20:51:45', '2023-02-06 20:51:45'),
(23, 65, 'CLT', '??????', 'Chinese Literature', 'SUB', 'LIB', 'COP', NULL, NULL, 3, 'TERMS', 1, NULL, '2023-02-06 20:51:45', '2023-02-06 20:51:45'),
(24, 65, 'STY', '??????', 'Stry', 'SUB', 'LIB', 'COP', NULL, NULL, 4, 'TERMS', 1, NULL, '2023-02-06 20:51:45', '2023-02-06 20:51:45'),
(25, 65, 'CWR', '??????', 'Chinse_writting', 'SUB', 'LIB', 'COP', NULL, NULL, 5, 'TERMS', 1, NULL, '2023-02-06 20:51:45', '2023-02-06 20:51:45'),
(26, 65, 'ELT', '??????', 'English Literature', 'SUB', 'LIB', 'COP', NULL, NULL, 6, 'TERMS', 1, NULL, '2023-02-06 20:51:45', '2023-02-06 20:51:45'),
(27, 65, 'EWR', '??????', 'English Writing', 'SUB', 'LIB', 'COP', NULL, NULL, 7, 'TERMS', 1, NULL, '2023-02-06 20:51:45', '2023-02-06 20:51:45'),
(28, 65, 'OCS', '??????', 'Ordinary Common Sense', 'SUB', 'LIB', 'COP', NULL, NULL, 8, 'TERMS', 1, NULL, '2023-02-06 20:51:45', '2023-02-06 20:51:45'),
(29, 65, 'NUM', '??????', 'Numeracy', 'SUB', 'LIB', 'COP', NULL, NULL, 9, 'TERMS', 1, NULL, '2023-02-06 20:51:45', '2023-02-06 20:51:45'),
(30, 65, 'COM', '??????', 'Computer', 'SUB', 'LIB', 'COP', NULL, NULL, 10, 'TERMS', 1, NULL, '2023-02-06 20:51:45', '2023-02-06 20:51:45'),
(31, 65, 'PLA', '??????', 'Playgroup', 'SUB', 'LIB', 'COP', NULL, NULL, 11, 'TERMS', 1, NULL, '2023-02-06 20:51:45', '2023-02-06 20:51:45'),
(32, 65, 'ART', '??????', 'Art Craft', 'SUB', 'LIB', 'COP', NULL, NULL, 12, 'TERMS', 1, NULL, '2023-02-06 20:51:45', '2023-02-06 20:51:45'),
(33, 65, 'health_1', '????????????????????????', NULL, 'ATT', NULL, NULL, NULL, NULL, 13, 'TERMS', 1, NULL, '2023-02-06 20:51:45', '2023-02-06 20:51:45'),
(34, 65, 'health_2', '????????????', NULL, 'ATT', NULL, NULL, NULL, NULL, 14, 'TERMS', 1, NULL, '2023-02-06 20:51:45', '2023-02-06 20:51:45'),
(35, 65, 'health_3', '???????????????????????????', NULL, 'ATT', NULL, NULL, NULL, NULL, 15, 'TERMS', 1, NULL, '2023-02-06 20:51:45', '2023-02-06 20:51:45'),
(36, 65, 'health_4', '??????????????????????????????', NULL, 'ATT', NULL, NULL, NULL, NULL, 16, 'TERMS', 1, NULL, '2023-02-06 20:51:45', '2023-02-06 20:51:45'),
(37, 65, 'health_5', '??????????????????????????????', NULL, 'ATT', NULL, NULL, NULL, NULL, 17, 'TERMS', 1, NULL, '2023-02-06 20:51:45', '2023-02-06 20:51:45'),
(38, 65, 'behaviour_1', '??????????????????', NULL, 'ATT', NULL, NULL, NULL, NULL, 18, 'TERMS', 1, NULL, '2023-02-06 20:51:45', '2023-02-06 20:51:45'),
(39, 65, 'behaviour_2', '????????????', NULL, 'ATT', NULL, NULL, NULL, NULL, 19, 'TERMS', 1, NULL, '2023-02-06 20:51:45', '2023-02-06 20:51:45'),
(40, 65, 'behaviour_3', '????????????????????????', NULL, 'ATT', NULL, NULL, NULL, NULL, 20, 'TERMS', 1, NULL, '2023-02-06 20:51:45', '2023-02-06 20:51:45'),
(41, 65, 'behaviour_4', '????????????????????????????????????', NULL, 'ATT', NULL, NULL, NULL, NULL, 21, 'TERMS', 1, NULL, '2023-02-06 20:51:45', '2023-02-06 20:51:45'),
(42, 65, 'behaviour_5', '??????????????????????????????', NULL, 'ATT', NULL, NULL, NULL, NULL, 22, 'TERMS', 1, NULL, '2023-02-06 20:51:45', '2023-02-06 20:51:45'),
(43, 65, 'behaviour_6', '????????????', NULL, 'ATT', NULL, NULL, NULL, NULL, 23, 'TERMS', 1, NULL, '2023-02-06 20:51:45', '2023-02-06 20:51:45'),
(44, 65, 'social_1', '??????', NULL, 'ATT', NULL, NULL, NULL, NULL, 24, 'TERMS', 1, NULL, '2023-02-06 20:51:45', '2023-02-06 20:51:45'),
(45, 65, 'social_2', '????????????,????????????', NULL, 'ATT', NULL, NULL, NULL, NULL, 25, 'TERMS', 1, NULL, '2023-02-06 20:51:45', '2023-02-06 20:51:45'),
(46, 65, 'social_3', '????????????', NULL, 'ATT', NULL, NULL, NULL, NULL, 26, 'TERMS', 1, NULL, '2023-02-06 20:51:45', '2023-02-06 20:51:45'),
(47, 65, 'social_4', '???????????????????????????', NULL, 'ATT', NULL, NULL, NULL, NULL, 27, 'TERMS', 1, NULL, '2023-02-06 20:51:45', '2023-02-06 20:51:45'),
(48, 65, 'social_5', '?????????????????????', NULL, 'ATT', NULL, NULL, NULL, NULL, 28, 'TERMS', 1, NULL, '2023-02-06 20:51:45', '2023-02-06 20:51:45'),
(49, 65, 'total_score', '??????', NULL, 'SUM', NULL, NULL, NULL, NULL, 29, 'TERMS', 1, NULL, '2023-02-06 20:51:45', '2023-02-06 20:51:45'),
(50, 65, 'average_score', '?????????', NULL, 'SUM', NULL, NULL, NULL, NULL, 30, 'TERMS', 1, NULL, '2023-02-06 20:51:45', '2023-02-06 20:51:45'),
(51, 65, 'class_size', '????????????', NULL, 'SUM', NULL, NULL, NULL, NULL, 31, 'TERMS', 1, NULL, '2023-02-06 20:51:45', '2023-02-06 20:51:45'),
(52, 65, 'ranking', '????????????', NULL, 'SUM', NULL, NULL, NULL, NULL, 32, 'TERMS', 1, NULL, '2023-02-06 20:51:45', '2023-02-06 20:51:45'),
(53, 65, 'late', '????????????', NULL, 'SUM', NULL, NULL, NULL, NULL, 33, 'TERMS', 1, NULL, '2023-02-06 20:51:45', '2023-02-06 20:51:45'),
(54, 65, 'absent', '????????????', NULL, 'SUM', NULL, NULL, NULL, NULL, 34, 'TERMS', 1, NULL, '2023-02-06 20:51:45', '2023-02-06 20:51:45'),
(55, 65, 'comment', '??????', NULL, 'SUM', NULL, NULL, NULL, NULL, 35, 'TERMS', 1, NULL, '2023-02-06 20:51:45', '2023-02-06 20:51:45'),
(56, 65, 'reward_punishment', '????????????', NULL, 'GEN', NULL, NULL, NULL, NULL, 36, 'TERMS', 1, NULL, '2023-02-06 20:51:45', '2023-02-06 20:51:45'),
(57, 65, 'leisure_name', '??????????????????', NULL, 'GEN', NULL, NULL, NULL, NULL, 37, 'TERMS', 1, NULL, '2023-02-06 20:51:45', '2023-02-06 20:51:45'),
(58, 65, 'leisure_performance', '??????????????????', NULL, 'GEN', NULL, NULL, NULL, NULL, 38, 'TERMS', 1, NULL, '2023-02-06 20:51:45', '2023-02-06 20:51:45'),
(59, 65, 'remark', '??????', NULL, 'GEN', NULL, NULL, NULL, NULL, 39, 'COMMENT', 1, NULL, '2023-02-06 20:51:45', '2023-02-06 20:51:45'),
(60, 65, 'appraisal', '????????????', NULL, 'GEN', NULL, NULL, NULL, NULL, 40, 'COMMENT', 1, NULL, '2023-02-06 20:51:45', '2023-02-06 20:51:45'),
(341, 74, 'REL', '??????', 'Relegion', 'SUB', 'LIB', '1', NULL, NULL, 1, 'TERMS', 1, NULL, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(342, 74, 'PHY', '??????', 'Physic', 'SUB', 'LIB', '1', NULL, NULL, 1, 'TERMS', 1, NULL, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(343, 74, 'CLT', '??????', 'Chinese Literature', 'SUB', 'LIB', '1', NULL, NULL, 1, 'TERMS', 1, NULL, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(344, 74, 'STY', '??????', 'Stry', 'SUB', 'LIB', '1', NULL, NULL, 1, 'TERMS', 1, NULL, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(345, 74, 'CWR', '??????', 'Chinse_writting', 'SUB', 'LIB', '1', NULL, NULL, 1, 'TERMS', 1, NULL, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(346, 74, 'ELT', '??????', 'English Literature', 'SUB', 'LIB', '1', NULL, NULL, 1, 'TERMS', 1, NULL, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(347, 74, 'EWR', '??????', 'English Writing', 'SUB', 'LIB', '1', NULL, NULL, 1, 'TERMS', 1, NULL, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(348, 74, 'OCS', '??????', 'Ordinary Common Sense', 'SUB', 'LIB', '1', NULL, NULL, 1, 'TERMS', 1, NULL, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(349, 74, 'NUM', '??????', 'Numeracy', 'SUB', 'LIB', '1', NULL, NULL, 1, 'TERMS', 1, NULL, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(350, 74, 'COM', '??????', 'Computer', 'SUB', 'LIB', '1', NULL, NULL, 1, 'TERMS', 1, NULL, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(351, 74, 'PLA', '??????', 'Playgroup', 'SUB', 'LIB', '1', NULL, NULL, 1, 'TERMS', 1, NULL, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(352, 74, 'ART', '??????', 'Art Craft', 'SUB', 'LIB', '1', NULL, NULL, 1, 'TERMS', 1, NULL, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(353, 74, 'health_1', '????????????????????????', NULL, 'ATT', 'LIB', '1', NULL, NULL, 1, 'TERMS', 1, NULL, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(354, 74, 'health_2', '????????????', NULL, 'ATT', 'LIB', '1', NULL, NULL, 1, 'TERMS', 1, NULL, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(355, 74, 'health_3', '???????????????????????????', NULL, 'ATT', 'LIB', '1', NULL, NULL, 1, 'TERMS', 1, NULL, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(356, 74, 'health_4', '??????????????????????????????', NULL, 'ATT', 'LIB', '1', NULL, NULL, 1, 'TERMS', 1, NULL, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(357, 74, 'health_5', '??????????????????????????????', NULL, 'ATT', 'LIB', '1', NULL, NULL, 1, 'TERMS', 1, NULL, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(358, 74, 'behaviour_1', '??????????????????', NULL, 'ATT', 'LIB', '1', NULL, NULL, 1, 'TERMS', 1, NULL, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(359, 74, 'behaviour_2', '????????????', NULL, 'ATT', 'LIB', '1', NULL, NULL, 1, 'TERMS', 1, NULL, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(360, 74, 'behaviour_3', '????????????????????????', NULL, 'ATT', 'LIB', '1', NULL, NULL, 1, 'TERMS', 1, NULL, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(361, 74, 'behaviour_4', '????????????????????????????????????', NULL, 'ATT', 'LIB', '1', NULL, NULL, 1, 'TERMS', 1, NULL, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(362, 74, 'behaviour_5', '??????????????????????????????', NULL, 'ATT', 'LIB', '1', NULL, NULL, 1, 'TERMS', 1, NULL, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(363, 74, 'behaviour_6', '????????????', NULL, 'ATT', 'LIB', '1', NULL, NULL, 1, 'TERMS', 1, NULL, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(364, 74, 'social_1', '??????', NULL, 'ATT', 'LIB', '1', NULL, NULL, 1, 'TERMS', 1, NULL, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(365, 74, 'social_2', '????????????,????????????', NULL, 'ATT', 'LIB', '1', NULL, NULL, 1, 'TERMS', 1, NULL, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(366, 74, 'social_3', '????????????', NULL, 'ATT', 'LIB', '1', NULL, NULL, 1, 'TERMS', 1, NULL, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(367, 74, 'social_4', '???????????????????????????', NULL, 'ATT', 'LIB', '1', NULL, NULL, 1, 'TERMS', 1, NULL, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(368, 74, 'social_5', '?????????????????????', NULL, 'ATT', 'LIB', '1', NULL, NULL, 1, 'TERMS', 1, NULL, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(369, 74, 'total_score', '??????', NULL, 'SUM', 'LIB', '1', NULL, NULL, 1, 'TERMS', 1, NULL, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(370, 74, 'average_score', '?????????', NULL, 'SUM', 'LIB', '1', NULL, NULL, 1, 'TERMS', 1, NULL, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(371, 74, 'class_size', '????????????', NULL, 'SUM', 'LIB', '1', NULL, NULL, 1, 'TERMS', 1, NULL, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(372, 74, 'ranking', '????????????', NULL, 'SUM', 'LIB', '1', NULL, NULL, 1, 'TERMS', 1, NULL, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(373, 74, 'late', '????????????', NULL, 'SUM', 'LIB', '1', NULL, NULL, 1, 'TERMS', 1, NULL, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(374, 74, 'absent', '????????????', NULL, 'SUM', 'LIB', '1', NULL, NULL, 1, 'TERMS', 1, NULL, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(375, 74, 'comment', '??????', NULL, 'GEN', 'LIB', '1', NULL, NULL, 1, 'TERMS', 1, NULL, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(376, 74, 'reward_punishment', '????????????', NULL, 'GEN', 'LIB', '1', NULL, NULL, 1, 'TERMS', 1, NULL, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(377, 74, 'leisure_name', '??????????????????', NULL, 'GEN', 'LIB', '1', NULL, NULL, 1, 'TERMS', 1, NULL, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(378, 74, 'leisure_performance', '??????????????????', NULL, 'GEN', 'LIB', '1', NULL, NULL, 1, 'TERMS', 1, NULL, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(379, 74, 'remark', '??????', NULL, 'GEN', 'LIB', '1', NULL, NULL, 1, 'COMMENT', 1, NULL, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(380, 74, 'appraisal', '????????????', NULL, 'GEN', 'LIB', '1', NULL, NULL, 1, 'COMMENT', 1, NULL, '2023-02-07 19:01:07', '2023-02-07 19:01:07');

-- --------------------------------------------------------

--
-- Table structure for table `course_scores`
--

CREATE TABLE `course_scores` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `term_id` bigint(20) NOT NULL,
  `course_id` bigint(20) NOT NULL,
  `sequence` int(11) DEFAULT NULL,
  `field_name` varchar(255) NOT NULL,
  `field_label` varchar(255) NOT NULL,
  `type` varchar(255) DEFAULT NULL,
  `scheme` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `for_transcript` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `course_scores`
--

INSERT INTO `course_scores` (`id`, `term_id`, `course_id`, `sequence`, `field_name`, `field_label`, `type`, `scheme`, `description`, `for_transcript`, `created_at`, `updated_at`) VALUES
(1, 1, 1, NULL, 'term1', '?????????', NULL, NULL, NULL, 0, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(2, 2, 1, NULL, 'term2', '?????????', NULL, NULL, NULL, 0, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(3, 1, 2, NULL, 'term1', '?????????', NULL, NULL, NULL, 0, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(4, 2, 2, NULL, 'term2', '?????????', NULL, NULL, NULL, 0, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(5, 1, 3, NULL, 'term1', '?????????', NULL, NULL, NULL, 0, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(6, 2, 3, NULL, 'term2', '?????????', NULL, NULL, NULL, 0, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(7, 1, 4, NULL, 'term1', '?????????', NULL, NULL, NULL, 0, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(8, 2, 4, NULL, 'term2', '?????????', NULL, NULL, NULL, 0, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(9, 1, 5, NULL, 'term1', '?????????', NULL, NULL, NULL, 0, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(10, 2, 5, NULL, 'term2', '?????????', NULL, NULL, NULL, 0, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(11, 1, 6, NULL, 'term1', '?????????', NULL, NULL, NULL, 0, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(12, 2, 6, NULL, 'term2', '?????????', NULL, NULL, NULL, 0, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(13, 1, 7, NULL, 'term1', '?????????', NULL, NULL, NULL, 0, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(14, 2, 7, NULL, 'term2', '?????????', NULL, NULL, NULL, 0, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(15, 1, 8, NULL, 'term1', '?????????', NULL, NULL, NULL, 0, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(16, 2, 8, NULL, 'term2', '?????????', NULL, NULL, NULL, 0, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(17, 1, 9, NULL, 'term1', '?????????', NULL, NULL, NULL, 0, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(18, 2, 9, NULL, 'term2', '?????????', NULL, NULL, NULL, 0, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(19, 1, 10, NULL, 'term1', '?????????', NULL, NULL, NULL, 0, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(20, 2, 10, NULL, 'term2', '?????????', NULL, NULL, NULL, 0, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(21, 1, 1, 1, '', 'Test1', NULL, NULL, NULL, 0, NULL, NULL),
(22, 1, 1, 2, '', 'Exam', NULL, NULL, NULL, 0, NULL, NULL),
(23, 2, 1, 3, '', 'Test2', NULL, NULL, NULL, 0, NULL, NULL),
(24, 2, 1, 4, '', 'Exam', NULL, NULL, NULL, 0, NULL, NULL),
(255, 1, 341, NULL, 'term1', '?????????', NULL, NULL, NULL, 0, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(256, 2, 341, NULL, 'term2', '?????????', NULL, NULL, NULL, 0, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(257, 1, 342, NULL, 'term1', '?????????', NULL, NULL, NULL, 0, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(258, 2, 342, NULL, 'term2', '?????????', NULL, NULL, NULL, 0, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(259, 1, 343, NULL, 'term1', '?????????', NULL, NULL, NULL, 0, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(260, 2, 343, NULL, 'term2', '?????????', NULL, NULL, NULL, 0, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(261, 1, 344, NULL, 'term1', '?????????', NULL, NULL, NULL, 0, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(262, 2, 344, NULL, 'term2', '?????????', NULL, NULL, NULL, 0, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(263, 1, 345, NULL, 'term1', '?????????', NULL, NULL, NULL, 0, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(264, 2, 345, NULL, 'term2', '?????????', NULL, NULL, NULL, 0, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(265, 1, 346, NULL, 'term1', '?????????', NULL, NULL, NULL, 0, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(266, 2, 346, NULL, 'term2', '?????????', NULL, NULL, NULL, 0, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(267, 1, 347, NULL, 'term1', '?????????', NULL, NULL, NULL, 0, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(268, 2, 347, NULL, 'term2', '?????????', NULL, NULL, NULL, 0, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(269, 1, 348, NULL, 'term1', '?????????', NULL, NULL, NULL, 0, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(270, 2, 348, NULL, 'term2', '?????????', NULL, NULL, NULL, 0, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(271, 1, 349, NULL, 'term1', '?????????', NULL, NULL, NULL, 0, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(272, 2, 349, NULL, 'term2', '?????????', NULL, NULL, NULL, 0, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(273, 1, 350, NULL, 'term1', '?????????', NULL, NULL, NULL, 0, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(274, 2, 350, NULL, 'term2', '?????????', NULL, NULL, NULL, 0, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(275, 1, 351, NULL, 'term1', '?????????', NULL, NULL, NULL, 0, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(276, 2, 351, NULL, 'term2', '?????????', NULL, NULL, NULL, 0, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(277, 1, 352, NULL, 'term1', '?????????', NULL, NULL, NULL, 0, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(278, 2, 352, NULL, 'term2', '?????????', NULL, NULL, NULL, 0, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(279, 1, 353, NULL, 'term1', '?????????', NULL, NULL, NULL, 0, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(280, 2, 353, NULL, 'term2', '?????????', NULL, NULL, NULL, 0, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(281, 1, 354, NULL, 'term1', '?????????', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(282, 2, 354, NULL, 'term2', '?????????', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(283, 1, 355, NULL, 'term1', '?????????', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(284, 2, 355, NULL, 'term2', '?????????', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(285, 1, 356, NULL, 'term1', '?????????', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(286, 2, 356, NULL, 'term2', '?????????', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(287, 1, 357, NULL, 'term1', '?????????', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(288, 2, 357, NULL, 'term2', '?????????', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(289, 1, 358, NULL, 'term1', '?????????', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(290, 2, 358, NULL, 'term2', '?????????', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(291, 1, 359, NULL, 'term1', '?????????', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(292, 2, 359, NULL, 'term2', '?????????', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(293, 1, 360, NULL, 'term1', '?????????', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(294, 2, 360, NULL, 'term2', '?????????', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(295, 1, 361, NULL, 'term1', '?????????', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(296, 2, 361, NULL, 'term2', '?????????', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(297, 1, 362, NULL, 'term1', '?????????', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(298, 2, 362, NULL, 'term2', '?????????', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(299, 1, 363, NULL, 'term1', '?????????', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(300, 2, 363, NULL, 'term2', '?????????', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(301, 1, 364, NULL, 'term1', '?????????', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(302, 2, 364, NULL, 'term2', '?????????', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(303, 1, 365, NULL, 'term1', '?????????', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(304, 2, 365, NULL, 'term2', '?????????', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(305, 1, 366, NULL, 'term1', '?????????', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(306, 2, 366, NULL, 'term2', '?????????', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(307, 1, 367, NULL, 'term1', '?????????', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(308, 2, 367, NULL, 'term2', '?????????', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(309, 1, 368, NULL, 'term1', '?????????', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(310, 2, 368, NULL, 'term2', '?????????', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(311, 1, 369, NULL, 'term1', '?????????', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(312, 2, 369, NULL, 'term2', '?????????', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(313, 1, 370, NULL, 'term1', '?????????', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(314, 2, 370, NULL, 'term2', '?????????', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(315, 1, 371, NULL, 'term1', '?????????', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(316, 2, 371, NULL, 'term2', '?????????', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(317, 1, 372, NULL, 'term1', '?????????', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(318, 2, 372, NULL, 'term2', '?????????', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(319, 1, 373, NULL, 'term1', '?????????', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(320, 2, 373, NULL, 'term2', '?????????', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(321, 1, 374, NULL, 'term1', '?????????', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(322, 2, 374, NULL, 'term2', '?????????', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(323, 1, 375, NULL, 'term1', '?????????', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(324, 2, 375, NULL, 'term2', '?????????', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(325, 1, 376, NULL, 'term1', '?????????', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(326, 2, 376, NULL, 'term2', '?????????', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(327, 1, 377, NULL, 'term1', '?????????', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(328, 2, 377, NULL, 'term2', '?????????', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(329, 1, 378, NULL, 'term1', '?????????', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(330, 2, 378, NULL, 'term2', '?????????', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(331, 1, 379, NULL, 'comment', '??????', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(332, 1, 380, NULL, 'comment', '??????', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08');

-- --------------------------------------------------------

--
-- Table structure for table `course_teachers`
--

CREATE TABLE `course_teachers` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `course_id` bigint(20) NOT NULL,
  `teacher_id` bigint(20) NOT NULL,
  `is_head` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `disciplines`
--

CREATE TABLE `disciplines` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `subject_id` bigint(20) NOT NULL,
  `klass_id` bigint(20) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `gardians`
--

CREATE TABLE `gardians` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name_zh` varchar(255) NOT NULL,
  `name_fn` varchar(255) NOT NULL,
  `gender` char(1) NOT NULL,
  `dob` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `grades`
--

CREATE TABLE `grades` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `year_id` bigint(20) NOT NULL,
  `rank` int(11) NOT NULL,
  `initial` char(2) NOT NULL,
  `level` int(11) NOT NULL,
  `tag` varchar(5) DEFAULT NULL,
  `byname` varchar(5) DEFAULT NULL,
  `title_zh` varchar(255) DEFAULT NULL,
  `title_en` varchar(255) DEFAULT NULL,
  `klass_num` int(11) NOT NULL DEFAULT 0,
  `description` text DEFAULT NULL,
  `version` int(11) DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `grades`
--

INSERT INTO `grades` (`id`, `year_id`, `rank`, `initial`, `level`, `tag`, `byname`, `title_zh`, `title_en`, `klass_num`, `description`, `version`, `active`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 'P', 1, 'P1', NULL, NULL, NULL, 0, NULL, 1, 1, NULL, NULL),
(2, 1, 2, 'P', 2, 'P2', NULL, NULL, NULL, 0, NULL, 1, 1, NULL, NULL),
(3, 1, 3, 'P', 3, 'P3', NULL, NULL, NULL, 0, NULL, 1, 1, NULL, NULL),
(4, 1, 4, 'P', 4, 'P4', NULL, NULL, NULL, 0, NULL, 1, 1, NULL, NULL),
(5, 1, 5, 'P', 5, 'P5', NULL, NULL, NULL, 0, NULL, 1, 1, NULL, NULL),
(6, 1, 6, 'P', 6, 'P6', NULL, NULL, NULL, 0, NULL, 1, 1, NULL, NULL),
(7, 1, 7, 'S', 1, 'S1', NULL, NULL, NULL, 0, NULL, 1, 1, NULL, NULL),
(8, 1, 8, 'S', 2, 'S2', NULL, NULL, NULL, 0, NULL, 1, 1, NULL, NULL),
(9, 1, 9, 'S', 3, 'S3', NULL, NULL, NULL, 0, NULL, 1, 1, NULL, NULL),
(10, 1, 10, 'S', 4, 'S4', NULL, NULL, NULL, 0, NULL, 1, 1, NULL, NULL),
(11, 1, 11, 'S', 5, 'S5', NULL, NULL, NULL, 0, NULL, 1, 1, NULL, NULL),
(12, 1, 12, 'S', 6, 'S6', NULL, NULL, NULL, 0, NULL, 1, 1, NULL, NULL),
(13, 2, 1, 'P', 1, 'P1', NULL, NULL, NULL, 0, NULL, 1, 1, NULL, NULL),
(14, 2, 2, 'P', 2, 'P2', NULL, NULL, NULL, 0, NULL, 1, 1, NULL, NULL),
(15, 2, 3, 'P', 3, 'P3', NULL, NULL, NULL, 0, NULL, 1, 1, NULL, NULL),
(16, 2, 4, 'P', 4, 'P4', NULL, NULL, NULL, 0, NULL, 1, 1, NULL, NULL),
(17, 2, 5, 'P', 5, 'P5', NULL, NULL, NULL, 0, NULL, 1, 1, NULL, NULL),
(18, 2, 6, 'P', 6, 'P6', NULL, NULL, NULL, 0, NULL, 1, 1, NULL, NULL),
(19, 2, 7, 'S', 1, 'S1', NULL, NULL, NULL, 0, NULL, 1, 1, NULL, NULL),
(20, 2, 8, 'S', 2, 'S2', NULL, NULL, NULL, 0, NULL, 1, 1, NULL, NULL),
(21, 2, 9, 'S', 3, 'S3', NULL, NULL, NULL, 0, NULL, 1, 1, NULL, NULL),
(22, 2, 10, 'S', 4, 'S4', NULL, NULL, NULL, 0, NULL, 1, 1, NULL, NULL),
(23, 2, 11, 'S', 5, 'S5', NULL, NULL, NULL, 0, NULL, 1, 1, NULL, NULL),
(24, 2, 12, 'S', 6, 'S6', NULL, NULL, NULL, 0, NULL, 1, 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `guardians`
--

CREATE TABLE `guardians` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `student_id` bigint(20) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `relation` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `organization` varchar(255) DEFAULT NULL,
  `organization_phone` varchar(255) DEFAULT NULL,
  `job` varchar(255) DEFAULT NULL,
  `stay_together` varchar(255) DEFAULT NULL,
  `zone` varchar(255) DEFAULT NULL,
  `road_name` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `post_code` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `habits`
--

CREATE TABLE `habits` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `klass_student_id` bigint(20) NOT NULL,
  `term_id` bigint(20) NOT NULL,
  `health_1` char(1) DEFAULT NULL,
  `health_2` char(1) DEFAULT NULL,
  `health_3` char(1) DEFAULT NULL,
  `health_4` char(1) DEFAULT NULL,
  `health_5` char(1) DEFAULT NULL,
  `behaviour_1` char(1) DEFAULT NULL,
  `behaviour_2` char(1) DEFAULT NULL,
  `behaviour_3` char(1) DEFAULT NULL,
  `behaviour_4` char(1) DEFAULT NULL,
  `behaviour_5` char(1) DEFAULT NULL,
  `behaviour_6` char(1) DEFAULT NULL,
  `social_1` char(1) DEFAULT NULL,
  `social_2` char(1) DEFAULT NULL,
  `social_3` char(1) DEFAULT NULL,
  `social_4` char(1) DEFAULT NULL,
  `social_5` char(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `habits`
--

INSERT INTO `habits` (`id`, `klass_student_id`, `term_id`, `health_1`, `health_2`, `health_3`, `health_4`, `health_5`, `behaviour_1`, `behaviour_2`, `behaviour_3`, `behaviour_4`, `behaviour_5`, `behaviour_6`, `social_1`, `social_2`, `social_3`, `social_4`, `social_5`, `created_at`, `updated_at`) VALUES
(1, 1, 1, '1', '1', '2', '4', '5', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-09 01:17:34', '2023-02-09 01:52:59'),
(2, 22, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-09 01:17:34', '2023-02-09 01:17:34'),
(3, 3, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-09 01:17:34', '2023-02-09 01:52:59'),
(4, 4, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-09 01:17:34', '2023-02-09 01:52:59'),
(5, 5, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-09 01:17:34', '2023-02-09 01:52:59'),
(6, 2, 1, NULL, NULL, '4', '5', '6', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-09 01:44:37', '2023-02-09 01:52:59');

-- --------------------------------------------------------

--
-- Table structure for table `healthcares`
--

CREATE TABLE `healthcares` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `student_id` bigint(20) NOT NULL,
  `hospital` varchar(255) NOT NULL,
  `health_state` varchar(255) NOT NULL,
  `vaccinated` date NOT NULL,
  `last_vaccine` int(11) NOT NULL,
  `vaccine count` varchar(255) NOT NULL,
  `covid_19` int(11) NOT NULL,
  `illness` varchar(255) NOT NULL,
  `trauma` varchar(255) NOT NULL,
  `trauma_treatment` varchar(255) NOT NULL,
  `food_allergy` varchar(255) NOT NULL,
  `medicine_allergy` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `identity_documents`
--

CREATE TABLE `identity_documents` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `identity_documentable_id` bigint(20) NOT NULL,
  `identity_documentable_type` varchar(255) NOT NULL,
  `residentship` varchar(255) DEFAULT NULL,
  `issue_place` varchar(255) DEFAULT NULL,
  `issue_date` varchar(255) DEFAULT NULL,
  `expiry_date` varchar(255) DEFAULT NULL,
  `number` varchar(255) DEFAULT NULL,
  `home_return` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `klasses`
--

CREATE TABLE `klasses` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `grade_id` bigint(20) NOT NULL,
  `letter` char(5) DEFAULT NULL,
  `tag` char(5) DEFAULT NULL,
  `byname` varchar(255) DEFAULT NULL,
  `stream` varchar(5) NOT NULL,
  `room` varchar(255) DEFAULT NULL,
  `study_id` bigint(20) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `klasses`
--

INSERT INTO `klasses` (`id`, `grade_id`, `letter`, `tag`, `byname`, `stream`, `room`, `study_id`, `created_at`, `updated_at`) VALUES
(1, 1, 'A', 'P1A', NULL, 'AAS', NULL, 1, NULL, '2023-02-05 22:48:04'),
(2, 1, 'B', 'P1B', NULL, 'SCI', NULL, 1, NULL, '2023-02-05 22:48:37'),
(3, 1, 'C', 'P1C', NULL, '', NULL, 1, NULL, NULL),
(4, 1, 'D', 'P1D', NULL, '', NULL, 1, NULL, NULL),
(5, 1, 'E', 'P1E', NULL, '', NULL, 1, NULL, NULL),
(6, 2, 'A', 'P2A', NULL, '', NULL, 1, NULL, NULL),
(7, 2, 'B', 'P2B', NULL, '', NULL, 1, NULL, NULL),
(8, 2, 'C', 'P2C', NULL, '', NULL, 1, NULL, NULL),
(9, 2, 'D', 'P2D', NULL, '', NULL, 1, NULL, NULL),
(10, 2, 'E', 'P2E', NULL, '', NULL, 1, NULL, NULL),
(11, 3, 'A', 'P3A', NULL, '', NULL, 1, NULL, NULL),
(12, 3, 'B', 'P3B', NULL, '', NULL, 1, NULL, NULL),
(13, 3, 'C', 'P3C', NULL, '', NULL, 1, NULL, NULL),
(14, 3, 'D', 'P3D', NULL, '', NULL, 1, NULL, NULL),
(15, 3, 'E', 'P3E', NULL, '', NULL, 1, NULL, NULL),
(16, 4, 'A', 'P4A', NULL, '', NULL, 1, NULL, NULL),
(17, 4, 'B', 'P4B', NULL, '', NULL, 1, NULL, NULL),
(18, 4, 'C', 'P4C', NULL, '', NULL, 1, NULL, NULL),
(19, 4, 'D', 'P4D', NULL, '', NULL, 1, NULL, NULL),
(20, 4, 'E', 'P4E', NULL, '', NULL, 1, NULL, NULL),
(21, 5, 'A', 'P5A', NULL, '', NULL, 1, NULL, NULL),
(22, 5, 'B', 'P5B', NULL, '', NULL, 1, NULL, NULL),
(23, 5, 'C', 'P5C', NULL, '', NULL, 1, NULL, NULL),
(24, 5, 'D', 'P5D', NULL, '', NULL, 1, NULL, NULL),
(25, 5, 'E', 'P5E', NULL, '', NULL, 1, NULL, NULL),
(26, 6, 'A', 'P6A', NULL, '', NULL, 1, NULL, NULL),
(27, 6, 'B', 'P6B', NULL, '', NULL, 1, NULL, NULL),
(28, 6, 'C', 'P6C', NULL, '', NULL, 1, NULL, NULL),
(29, 6, 'D', 'P6D', NULL, '', NULL, 1, NULL, NULL),
(30, 6, 'E', 'P6E', NULL, '', NULL, 1, NULL, NULL),
(31, 7, 'A', 'S1A', NULL, '', NULL, 2, NULL, NULL),
(32, 7, 'B', 'S1B', NULL, '', NULL, 2, NULL, NULL),
(33, 7, 'C', 'S1C', NULL, '', NULL, 2, NULL, NULL),
(34, 7, 'D', 'S1D', NULL, '', NULL, 2, NULL, NULL),
(35, 7, 'E', 'S1E', NULL, '', NULL, 2, NULL, NULL),
(36, 8, 'A', 'S2A', NULL, '', NULL, 2, NULL, NULL),
(37, 8, 'B', 'S2B', NULL, '', NULL, 2, NULL, NULL),
(38, 8, 'C', 'S2C', NULL, '', NULL, 2, NULL, NULL),
(39, 8, 'D', 'S2D', NULL, '', NULL, 2, NULL, NULL),
(40, 8, 'E', 'S2E', NULL, '', NULL, 2, NULL, NULL),
(41, 9, 'A', 'S3A', NULL, '', NULL, 2, NULL, NULL),
(42, 9, 'B', 'S3B', NULL, '', NULL, 2, NULL, NULL),
(43, 9, 'C', 'S3C', NULL, '', NULL, 2, NULL, NULL),
(44, 9, 'D', 'S3D', NULL, '', NULL, 2, NULL, NULL),
(45, 9, 'E', 'S3E', NULL, '', NULL, 2, NULL, NULL),
(46, 10, 'A', 'S4A', NULL, '', NULL, 2, NULL, NULL),
(47, 10, 'B', 'S4B', NULL, '', NULL, 2, NULL, NULL),
(48, 10, 'C', 'S4C', NULL, '', NULL, 2, NULL, NULL),
(49, 10, 'D', 'S4D', NULL, '', NULL, 2, NULL, NULL),
(50, 10, 'E', 'S4E', NULL, '', NULL, 2, NULL, NULL),
(51, 11, 'A', 'S5A', NULL, '', NULL, 2, NULL, NULL),
(52, 11, 'B', 'S5B', NULL, '', NULL, 2, NULL, NULL),
(53, 11, 'C', 'S5C', NULL, '', NULL, 2, NULL, NULL),
(54, 11, 'D', 'S5D', NULL, '', NULL, 2, NULL, NULL),
(55, 11, 'E', 'S5E', NULL, '', NULL, 2, NULL, NULL),
(56, 12, 'A', 'S6A', NULL, 'AAS', NULL, 2, NULL, '2023-02-06 20:05:19'),
(57, 12, 'B', 'S6B', NULL, 'AAS', NULL, 2, NULL, '2023-02-06 20:04:06'),
(58, 12, 'C', 'S6C', NULL, '', NULL, 2, NULL, NULL),
(59, 12, 'D', 'S6D', NULL, '', NULL, 2, NULL, NULL),
(60, 12, 'E', 'S6E', NULL, '', NULL, 2, NULL, NULL),
(64, 1, 'F', 'P1F', NULL, '', '123', 2, '2023-02-05 17:03:12', '2023-02-05 17:03:12'),
(65, 2, 'F', 'P2F', NULL, 'AAS', NULL, 1, '2023-02-06 20:51:45', '2023-02-06 20:51:45'),
(74, 3, 'F', 'P3F', NULL, 'ALL', NULL, 1, '2023-02-07 19:01:07', '2023-02-07 19:01:07');

-- --------------------------------------------------------

--
-- Table structure for table `klass_students`
--

CREATE TABLE `klass_students` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `klass_id` bigint(20) NOT NULL,
  `student_id` bigint(20) NOT NULL,
  `student_number` int(11) NOT NULL DEFAULT 0,
  `state` char(3) NOT NULL DEFAULT 'ACT',
  `stream` char(3) NOT NULL DEFAULT 'ART',
  `promote` bigint(20) NOT NULL DEFAULT 0,
  `promote_to` bigint(20) NOT NULL DEFAULT 0,
  `score_scheme` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `klass_students`
--

INSERT INTO `klass_students` (`id`, `klass_id`, `student_id`, `student_number`, `state`, `stream`, `promote`, `promote_to`, `score_scheme`, `created_at`, `updated_at`) VALUES
(1, 74, 1, 1, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(2, 74, 2, 2, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(3, 74, 3, 3, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(4, 74, 4, 4, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(5, 74, 5, 5, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(6, 1, 6, 6, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(7, 1, 7, 7, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(8, 1, 8, 8, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(9, 1, 9, 9, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(10, 1, 10, 10, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(11, 1, 11, 11, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(12, 1, 12, 12, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(13, 1, 13, 13, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(14, 1, 14, 14, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(15, 1, 15, 15, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(16, 1, 16, 16, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(17, 1, 17, 17, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(18, 1, 18, 18, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(19, 1, 19, 19, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(20, 1, 20, 20, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(21, 1, 21, 21, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(22, 2, 22, 1, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(23, 2, 23, 2, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(24, 2, 24, 3, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(25, 2, 25, 4, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(26, 2, 26, 5, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(27, 2, 27, 6, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(28, 2, 28, 7, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(29, 2, 29, 8, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(30, 2, 30, 9, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(31, 2, 31, 10, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(32, 2, 32, 11, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(33, 2, 33, 12, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(34, 2, 34, 13, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(35, 2, 35, 14, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(36, 2, 36, 15, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(37, 2, 37, 16, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(38, 2, 38, 17, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(39, 2, 39, 18, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(40, 2, 40, 19, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(41, 2, 41, 20, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(42, 2, 42, 21, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(43, 3, 43, 1, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(44, 3, 44, 2, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(45, 3, 45, 3, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(46, 3, 46, 4, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(47, 3, 47, 5, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(48, 3, 48, 6, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(49, 3, 49, 7, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(50, 3, 50, 8, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(51, 3, 51, 9, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(52, 3, 52, 10, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(53, 3, 53, 11, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(54, 3, 54, 12, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(55, 3, 55, 13, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(56, 3, 56, 14, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(57, 3, 57, 15, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(58, 3, 58, 16, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(59, 3, 59, 17, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(60, 3, 60, 18, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(61, 3, 61, 19, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(62, 3, 62, 20, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(63, 3, 63, 21, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(64, 4, 64, 1, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(65, 4, 65, 2, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(66, 4, 66, 3, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(67, 4, 67, 4, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(68, 4, 68, 5, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(69, 4, 69, 6, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(70, 4, 70, 7, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(71, 4, 71, 8, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(72, 4, 72, 9, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(73, 4, 73, 10, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(74, 4, 74, 11, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(75, 4, 75, 12, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(76, 4, 76, 13, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(77, 4, 77, 14, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(78, 4, 78, 15, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(79, 4, 79, 16, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(80, 4, 80, 17, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(81, 4, 81, 18, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(82, 4, 82, 19, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(83, 4, 83, 20, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(84, 4, 84, 21, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(85, 5, 85, 1, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(86, 5, 86, 2, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(87, 5, 87, 3, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(88, 5, 88, 4, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(89, 5, 89, 5, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(90, 5, 90, 6, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(91, 5, 91, 7, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(92, 5, 92, 8, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(93, 5, 93, 9, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(94, 5, 94, 10, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(95, 5, 95, 11, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(96, 5, 96, 12, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(97, 5, 97, 13, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(98, 5, 98, 14, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(99, 5, 99, 15, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(100, 5, 100, 16, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(101, 5, 101, 17, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(102, 5, 102, 18, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(103, 5, 103, 19, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(104, 5, 104, 20, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(105, 5, 105, 21, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(106, 6, 106, 1, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(107, 6, 107, 2, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(108, 6, 108, 3, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(109, 6, 109, 4, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(110, 6, 110, 5, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(111, 6, 111, 6, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(112, 6, 112, 7, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(113, 6, 113, 8, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(114, 6, 114, 9, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(115, 6, 115, 10, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(116, 6, 116, 11, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(117, 6, 117, 12, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(118, 6, 118, 13, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(119, 6, 119, 14, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(120, 6, 120, 15, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(121, 6, 121, 16, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(122, 6, 122, 17, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(123, 6, 123, 18, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(124, 6, 124, 19, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(125, 6, 125, 20, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(126, 6, 126, 21, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(127, 7, 127, 1, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(128, 7, 128, 2, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(129, 7, 129, 3, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(130, 7, 130, 4, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(131, 7, 131, 5, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(132, 7, 132, 6, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(133, 7, 133, 7, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(134, 7, 134, 8, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(135, 7, 135, 9, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(136, 7, 136, 10, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(137, 7, 137, 11, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(138, 7, 138, 12, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(139, 7, 139, 13, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(140, 7, 140, 14, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(141, 7, 141, 15, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(142, 7, 142, 16, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(143, 7, 143, 17, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(144, 7, 144, 18, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(145, 7, 145, 19, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(146, 7, 146, 20, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(147, 7, 147, 21, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(148, 8, 148, 1, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(149, 8, 149, 2, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(150, 8, 150, 3, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(151, 8, 151, 4, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(152, 8, 152, 5, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(153, 8, 153, 6, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(154, 8, 154, 7, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(155, 8, 155, 8, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(156, 8, 156, 9, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(157, 8, 157, 10, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(158, 8, 158, 11, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(159, 8, 159, 12, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(160, 8, 160, 13, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(161, 8, 161, 14, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(162, 8, 162, 15, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(163, 8, 163, 16, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(164, 8, 164, 17, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(165, 8, 165, 18, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(166, 8, 166, 19, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(167, 8, 167, 20, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(168, 8, 168, 21, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(169, 9, 169, 1, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(170, 9, 170, 2, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(171, 9, 171, 3, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(172, 9, 172, 4, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(173, 9, 173, 5, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(174, 9, 174, 6, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(175, 9, 175, 7, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(176, 9, 176, 8, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(177, 9, 177, 9, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(178, 9, 178, 10, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(179, 9, 179, 11, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(180, 9, 180, 12, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(181, 9, 181, 13, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(182, 9, 182, 14, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(183, 9, 183, 15, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(184, 9, 184, 16, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(185, 9, 185, 17, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(186, 9, 186, 18, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(187, 9, 187, 19, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(188, 9, 188, 20, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(189, 9, 189, 21, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(190, 10, 190, 1, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(191, 10, 191, 2, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(192, 10, 192, 3, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(193, 10, 193, 4, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(194, 10, 194, 5, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(195, 10, 195, 6, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(196, 10, 196, 7, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(197, 10, 197, 8, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(198, 10, 198, 9, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(199, 10, 199, 10, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(200, 10, 200, 11, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(201, 10, 201, 12, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(202, 10, 202, 13, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(203, 10, 203, 14, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(204, 10, 204, 15, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(205, 10, 205, 16, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(206, 10, 206, 17, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(207, 10, 207, 18, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(208, 10, 208, 19, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(209, 10, 209, 20, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(210, 10, 210, 21, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(211, 11, 211, 1, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(212, 11, 212, 2, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(213, 11, 213, 3, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(214, 11, 214, 4, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(215, 11, 215, 5, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(216, 11, 216, 6, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(217, 11, 217, 7, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(218, 11, 218, 8, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(219, 11, 219, 9, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(220, 11, 220, 10, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(221, 11, 221, 11, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(222, 11, 222, 12, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(223, 11, 223, 13, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(224, 11, 224, 14, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(225, 11, 225, 15, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(226, 11, 226, 16, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(227, 11, 227, 17, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(228, 11, 228, 18, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(229, 11, 229, 19, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(230, 11, 230, 20, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(231, 11, 231, 21, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(232, 12, 232, 1, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(233, 12, 233, 2, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(234, 12, 234, 3, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(235, 12, 235, 4, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(236, 12, 236, 5, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(237, 12, 237, 6, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(238, 12, 238, 7, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(239, 12, 239, 8, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(240, 12, 240, 9, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(241, 12, 241, 10, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(242, 12, 242, 11, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(243, 12, 243, 12, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(244, 12, 244, 13, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(245, 12, 245, 14, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(246, 12, 246, 15, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(247, 12, 247, 16, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(248, 12, 248, 17, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(249, 12, 249, 18, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(250, 12, 250, 19, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(251, 12, 251, 20, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(252, 12, 252, 21, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(253, 13, 253, 1, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(254, 13, 254, 2, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(255, 13, 255, 3, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(256, 13, 256, 4, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(257, 13, 257, 5, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(258, 13, 258, 6, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(259, 13, 259, 7, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(260, 13, 260, 8, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(261, 13, 261, 9, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(262, 13, 262, 10, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(263, 13, 263, 11, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(264, 13, 264, 12, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(265, 13, 265, 13, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(266, 13, 266, 14, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(267, 13, 267, 15, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(268, 13, 268, 16, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(269, 13, 269, 17, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(270, 13, 270, 18, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(271, 13, 271, 19, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(272, 13, 272, 20, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(273, 13, 273, 21, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(274, 14, 274, 1, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(275, 14, 275, 2, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(276, 14, 276, 3, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(277, 14, 277, 4, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(278, 14, 278, 5, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(279, 14, 279, 6, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(280, 14, 280, 7, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(281, 14, 281, 8, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(282, 14, 282, 9, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(283, 14, 283, 10, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(284, 14, 284, 11, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(285, 14, 285, 12, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(286, 14, 286, 13, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(287, 14, 287, 14, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(288, 14, 288, 15, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(289, 14, 289, 16, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(290, 14, 290, 17, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(291, 14, 291, 18, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(292, 14, 292, 19, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(293, 14, 293, 20, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(294, 14, 294, 21, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(295, 15, 295, 1, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(296, 15, 296, 2, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(297, 15, 297, 3, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(298, 15, 298, 4, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(299, 15, 299, 5, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(300, 15, 300, 6, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(301, 15, 301, 7, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(302, 15, 302, 8, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(303, 15, 303, 9, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(304, 15, 304, 10, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(305, 15, 305, 11, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(306, 15, 306, 12, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(307, 15, 307, 13, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(308, 15, 308, 14, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(309, 15, 309, 15, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(310, 15, 310, 16, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(311, 15, 311, 17, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(312, 15, 312, 18, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(313, 15, 313, 19, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(314, 15, 314, 20, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(315, 15, 315, 21, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(316, 16, 316, 1, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(317, 16, 317, 2, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(318, 16, 318, 3, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(319, 16, 319, 4, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(320, 16, 320, 5, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(321, 16, 321, 6, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(322, 16, 322, 7, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(323, 16, 323, 8, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(324, 16, 324, 9, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(325, 16, 325, 10, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(326, 16, 326, 11, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(327, 16, 327, 12, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(328, 16, 328, 13, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(329, 16, 329, 14, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(330, 16, 330, 15, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(331, 16, 331, 16, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(332, 16, 332, 17, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(333, 16, 333, 18, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(334, 16, 334, 19, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(335, 16, 335, 20, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(336, 16, 336, 21, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(337, 17, 337, 1, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(338, 17, 338, 2, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(339, 17, 339, 3, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(340, 17, 340, 4, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(341, 17, 341, 5, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(342, 17, 342, 6, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(343, 17, 343, 7, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(344, 17, 344, 8, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(345, 17, 345, 9, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(346, 17, 346, 10, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(347, 17, 347, 11, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(348, 17, 348, 12, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(349, 17, 349, 13, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(350, 17, 350, 14, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(351, 17, 351, 15, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(352, 17, 352, 16, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(353, 17, 353, 17, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(354, 17, 354, 18, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(355, 17, 355, 19, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(356, 17, 356, 20, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(357, 17, 357, 21, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(358, 18, 358, 1, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(359, 18, 359, 2, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(360, 18, 360, 3, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(361, 18, 361, 4, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(362, 18, 362, 5, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(363, 18, 363, 6, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(364, 18, 364, 7, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(365, 18, 365, 8, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(366, 18, 366, 9, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(367, 18, 367, 10, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(368, 18, 368, 11, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(369, 18, 369, 12, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(370, 18, 370, 13, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(371, 18, 371, 14, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(372, 18, 372, 15, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(373, 18, 373, 16, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(374, 18, 374, 17, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(375, 18, 375, 18, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(376, 18, 376, 19, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(377, 18, 377, 20, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(378, 18, 378, 21, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(379, 19, 379, 1, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(380, 19, 380, 2, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(381, 19, 381, 3, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(382, 19, 382, 4, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(383, 19, 383, 5, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(384, 19, 384, 6, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(385, 19, 385, 7, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(386, 19, 386, 8, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(387, 19, 387, 9, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(388, 19, 388, 10, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(389, 19, 389, 11, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(390, 19, 390, 12, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(391, 19, 391, 13, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(392, 19, 392, 14, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(393, 19, 393, 15, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(394, 19, 394, 16, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(395, 19, 395, 17, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(396, 19, 396, 18, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(397, 19, 397, 19, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(398, 19, 398, 20, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(399, 19, 399, 21, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(400, 20, 400, 1, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(401, 20, 401, 2, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(402, 20, 402, 3, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(403, 20, 403, 4, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(404, 20, 404, 5, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(405, 20, 405, 6, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(406, 20, 406, 7, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(407, 20, 407, 8, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(408, 20, 408, 9, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(409, 20, 409, 10, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(410, 20, 410, 11, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(411, 20, 411, 12, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(412, 20, 412, 13, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(413, 20, 413, 14, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(414, 20, 414, 15, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(415, 20, 415, 16, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(416, 20, 416, 17, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(417, 20, 417, 18, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(418, 20, 418, 19, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(419, 20, 419, 20, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(420, 20, 420, 21, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(421, 21, 421, 1, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(422, 21, 422, 2, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(423, 21, 423, 3, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(424, 21, 424, 4, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(425, 21, 425, 5, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(426, 21, 426, 6, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(427, 21, 427, 7, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(428, 21, 428, 8, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(429, 21, 429, 9, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(430, 21, 430, 10, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(431, 21, 431, 11, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(432, 21, 432, 12, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(433, 21, 433, 13, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(434, 21, 434, 14, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(435, 21, 435, 15, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(436, 21, 436, 16, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(437, 21, 437, 17, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(438, 21, 438, 18, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(439, 21, 439, 19, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(440, 21, 440, 20, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(441, 21, 441, 21, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(442, 22, 442, 1, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(443, 22, 443, 2, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(444, 22, 444, 3, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(445, 22, 445, 4, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(446, 22, 446, 5, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(447, 22, 447, 6, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(448, 22, 448, 7, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(449, 22, 449, 8, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(450, 22, 450, 9, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(451, 22, 451, 10, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(452, 22, 452, 11, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(453, 22, 453, 12, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(454, 22, 454, 13, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(455, 22, 455, 14, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(456, 22, 456, 15, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(457, 22, 457, 16, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(458, 22, 458, 17, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(459, 22, 459, 18, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(460, 22, 460, 19, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(461, 22, 461, 20, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(462, 22, 462, 21, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(463, 23, 463, 1, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(464, 23, 464, 2, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(465, 23, 465, 3, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(466, 23, 466, 4, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(467, 23, 467, 5, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(468, 23, 468, 6, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(469, 23, 469, 7, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(470, 23, 470, 8, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(471, 23, 471, 9, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(472, 23, 472, 10, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(473, 23, 473, 11, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(474, 23, 474, 12, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(475, 23, 475, 13, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(476, 23, 476, 14, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(477, 23, 477, 15, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(478, 23, 478, 16, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(479, 23, 479, 17, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(480, 23, 480, 18, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(481, 23, 481, 19, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(482, 23, 482, 20, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(483, 23, 483, 21, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(484, 24, 484, 1, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(485, 24, 485, 2, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(486, 24, 486, 3, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(487, 24, 487, 4, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(488, 24, 488, 5, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(489, 24, 489, 6, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(490, 24, 490, 7, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(491, 24, 491, 8, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(492, 24, 492, 9, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(493, 24, 493, 10, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(494, 24, 494, 11, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(495, 24, 495, 12, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(496, 24, 496, 13, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(497, 24, 497, 14, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(498, 24, 498, 15, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(499, 24, 499, 16, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(500, 24, 500, 17, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(501, 24, 501, 18, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(502, 24, 502, 19, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(503, 24, 503, 20, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(504, 24, 504, 21, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(505, 25, 505, 1, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(506, 25, 506, 2, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(507, 25, 507, 3, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(508, 25, 508, 4, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(509, 25, 509, 5, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(510, 25, 510, 6, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(511, 25, 511, 7, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(512, 25, 512, 8, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(513, 25, 513, 9, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(514, 25, 514, 10, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(515, 25, 515, 11, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(516, 25, 516, 12, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(517, 25, 517, 13, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(518, 25, 518, 14, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(519, 25, 519, 15, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(520, 25, 520, 16, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(521, 25, 521, 17, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(522, 25, 522, 18, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(523, 25, 523, 19, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(524, 25, 524, 20, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(525, 25, 525, 21, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(526, 26, 526, 1, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(527, 26, 527, 2, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(528, 26, 528, 3, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(529, 26, 529, 4, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(530, 26, 530, 5, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(531, 26, 531, 6, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(532, 26, 532, 7, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(533, 26, 533, 8, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(534, 26, 534, 9, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(535, 26, 535, 10, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(536, 26, 536, 11, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(537, 26, 537, 12, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(538, 26, 538, 13, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(539, 26, 539, 14, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(540, 26, 540, 15, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(541, 26, 541, 16, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(542, 26, 542, 17, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(543, 26, 543, 18, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(544, 26, 544, 19, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(545, 26, 545, 20, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(546, 26, 546, 21, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(547, 27, 547, 1, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(548, 27, 548, 2, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(549, 27, 549, 3, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(550, 27, 550, 4, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(551, 27, 551, 5, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(552, 27, 552, 6, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(553, 27, 553, 7, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(554, 27, 554, 8, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(555, 27, 555, 9, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(556, 27, 556, 10, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(557, 27, 557, 11, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(558, 27, 558, 12, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(559, 27, 559, 13, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(560, 27, 560, 14, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(561, 27, 561, 15, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(562, 27, 562, 16, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(563, 27, 563, 17, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(564, 27, 564, 18, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(565, 27, 565, 19, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(566, 27, 566, 20, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(567, 27, 567, 21, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(568, 28, 568, 1, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(569, 28, 569, 2, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(570, 28, 570, 3, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(571, 28, 571, 4, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(572, 28, 572, 5, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(573, 28, 573, 6, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(574, 28, 574, 7, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(575, 28, 575, 8, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(576, 28, 576, 9, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(577, 28, 577, 10, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(578, 28, 578, 11, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(579, 28, 579, 12, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(580, 28, 580, 13, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(581, 28, 581, 14, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(582, 28, 582, 15, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(583, 28, 583, 16, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(584, 28, 584, 17, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(585, 28, 585, 18, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(586, 28, 586, 19, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(587, 28, 587, 20, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(588, 28, 588, 21, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(589, 29, 589, 1, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(590, 29, 590, 2, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(591, 29, 591, 3, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(592, 29, 592, 4, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(593, 29, 593, 5, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(594, 29, 594, 6, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(595, 29, 595, 7, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(596, 29, 596, 8, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(597, 29, 597, 9, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(598, 29, 598, 10, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(599, 29, 599, 11, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(600, 29, 600, 12, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(601, 29, 601, 13, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(602, 29, 602, 14, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(603, 29, 603, 15, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(604, 29, 604, 16, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(605, 29, 605, 17, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(606, 29, 606, 18, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(607, 29, 607, 19, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(608, 29, 608, 20, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(609, 29, 609, 21, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(610, 30, 610, 1, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(611, 30, 611, 2, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(612, 30, 612, 3, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(613, 30, 613, 4, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(614, 30, 614, 5, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(615, 30, 615, 6, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(616, 30, 616, 7, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(617, 30, 617, 8, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(618, 30, 618, 9, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(619, 30, 619, 10, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(620, 30, 620, 11, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(621, 30, 621, 12, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(622, 30, 622, 13, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(623, 30, 623, 14, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(624, 30, 624, 15, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(625, 30, 625, 16, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(626, 30, 626, 17, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(627, 30, 627, 18, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(628, 30, 628, 19, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(629, 30, 629, 20, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(630, 30, 630, 21, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(631, 31, 631, 1, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(632, 31, 632, 2, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(633, 31, 633, 3, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(634, 31, 634, 4, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(635, 31, 635, 5, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(636, 31, 636, 6, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(637, 31, 637, 7, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(638, 31, 638, 8, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(639, 31, 639, 9, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(640, 31, 640, 10, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(641, 31, 641, 11, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(642, 31, 642, 12, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(643, 31, 643, 13, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(644, 31, 644, 14, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(645, 31, 645, 15, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(646, 31, 646, 16, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(647, 31, 647, 17, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(648, 31, 648, 18, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(649, 31, 649, 19, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(650, 31, 650, 20, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(651, 31, 651, 21, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(652, 32, 652, 1, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(653, 32, 653, 2, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(654, 32, 654, 3, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(655, 32, 655, 4, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(656, 32, 656, 5, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(657, 32, 657, 6, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(658, 32, 658, 7, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(659, 32, 659, 8, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(660, 32, 660, 9, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(661, 32, 661, 10, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(662, 32, 662, 11, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(663, 32, 663, 12, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(664, 32, 664, 13, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(665, 32, 665, 14, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(666, 32, 666, 15, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(667, 32, 667, 16, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(668, 32, 668, 17, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(669, 32, 669, 18, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(670, 32, 670, 19, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(671, 32, 671, 20, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(672, 32, 672, 21, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(673, 33, 673, 1, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(674, 33, 674, 2, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(675, 33, 675, 3, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(676, 33, 676, 4, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(677, 33, 677, 5, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(678, 33, 678, 6, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(679, 33, 679, 7, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(680, 33, 680, 8, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(681, 33, 681, 9, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(682, 33, 682, 10, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(683, 33, 683, 11, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(684, 33, 684, 12, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(685, 33, 685, 13, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(686, 33, 686, 14, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(687, 33, 687, 15, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(688, 33, 688, 16, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(689, 33, 689, 17, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(690, 33, 690, 18, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(691, 33, 691, 19, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(692, 33, 692, 20, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(693, 33, 693, 21, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(694, 34, 694, 1, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(695, 34, 695, 2, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(696, 34, 696, 3, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(697, 34, 697, 4, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(698, 34, 698, 5, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(699, 34, 699, 6, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(700, 34, 700, 7, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(701, 34, 701, 8, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(702, 34, 702, 9, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(703, 34, 703, 10, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(704, 34, 704, 11, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(705, 34, 705, 12, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(706, 34, 706, 13, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(707, 34, 707, 14, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(708, 34, 708, 15, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(709, 34, 709, 16, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(710, 34, 710, 17, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(711, 34, 711, 18, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(712, 34, 712, 19, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(713, 34, 713, 20, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(714, 34, 714, 21, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(715, 35, 715, 1, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(716, 35, 716, 2, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(717, 35, 717, 3, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(718, 35, 718, 4, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(719, 35, 719, 5, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(720, 35, 720, 6, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(721, 35, 721, 7, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(722, 35, 722, 8, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(723, 35, 723, 9, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(724, 35, 724, 10, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(725, 35, 725, 11, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(726, 35, 726, 12, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(727, 35, 727, 13, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(728, 35, 728, 14, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(729, 35, 729, 15, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(730, 35, 730, 16, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(731, 35, 731, 17, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(732, 35, 732, 18, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(733, 35, 733, 19, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(734, 35, 734, 20, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(735, 35, 735, 21, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(736, 36, 736, 1, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(737, 36, 737, 2, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(738, 36, 738, 3, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(739, 36, 739, 4, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(740, 36, 740, 5, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(741, 36, 741, 6, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(742, 36, 742, 7, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(743, 36, 743, 8, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(744, 36, 744, 9, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(745, 36, 745, 10, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(746, 36, 746, 11, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(747, 36, 747, 12, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(748, 36, 748, 13, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(749, 36, 749, 14, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(750, 36, 750, 15, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(751, 36, 751, 16, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(752, 36, 752, 17, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(753, 36, 753, 18, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(754, 36, 754, 19, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(755, 36, 755, 20, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(756, 36, 756, 21, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(757, 37, 757, 1, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(758, 37, 758, 2, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(759, 37, 759, 3, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(760, 37, 760, 4, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(761, 37, 761, 5, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(762, 37, 762, 6, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(763, 37, 763, 7, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(764, 37, 764, 8, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(765, 37, 765, 9, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(766, 37, 766, 10, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(767, 37, 767, 11, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(768, 37, 768, 12, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(769, 37, 769, 13, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(770, 37, 770, 14, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(771, 37, 771, 15, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(772, 37, 772, 16, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(773, 37, 773, 17, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(774, 37, 774, 18, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(775, 37, 775, 19, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(776, 37, 776, 20, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(777, 37, 777, 21, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(778, 38, 778, 1, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(779, 38, 779, 2, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(780, 38, 780, 3, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(781, 38, 781, 4, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(782, 38, 782, 5, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(783, 38, 783, 6, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(784, 38, 784, 7, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(785, 38, 785, 8, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(786, 38, 786, 9, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(787, 38, 787, 10, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(788, 38, 788, 11, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(789, 38, 789, 12, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(790, 38, 790, 13, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(791, 38, 791, 14, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(792, 38, 792, 15, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(793, 38, 793, 16, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(794, 38, 794, 17, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(795, 38, 795, 18, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(796, 38, 796, 19, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(797, 38, 797, 20, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(798, 38, 798, 21, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(799, 39, 799, 1, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(800, 39, 800, 2, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(801, 39, 801, 3, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(802, 39, 802, 4, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(803, 39, 803, 5, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(804, 39, 804, 6, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(805, 39, 805, 7, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(806, 39, 806, 8, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(807, 39, 807, 9, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(808, 39, 808, 10, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(809, 39, 809, 11, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(810, 39, 810, 12, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(811, 39, 811, 13, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(812, 39, 812, 14, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(813, 39, 813, 15, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(814, 39, 814, 16, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(815, 39, 815, 17, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(816, 39, 816, 18, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(817, 39, 817, 19, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(818, 39, 818, 20, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(819, 39, 819, 21, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(820, 40, 820, 1, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(821, 40, 821, 2, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(822, 40, 822, 3, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(823, 40, 823, 4, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(824, 40, 824, 5, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(825, 40, 825, 6, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(826, 40, 826, 7, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(827, 40, 827, 8, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(828, 40, 828, 9, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(829, 40, 829, 10, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(830, 40, 830, 11, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(831, 40, 831, 12, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(832, 40, 832, 13, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(833, 40, 833, 14, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(834, 40, 834, 15, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(835, 40, 835, 16, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(836, 40, 836, 17, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(837, 40, 837, 18, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(838, 40, 838, 19, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(839, 40, 839, 20, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(840, 40, 840, 21, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(841, 41, 841, 1, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(842, 41, 842, 2, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(843, 41, 843, 3, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(844, 41, 844, 4, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(845, 41, 845, 5, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(846, 41, 846, 6, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(847, 41, 847, 7, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(848, 41, 848, 8, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(849, 41, 849, 9, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(850, 41, 850, 10, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(851, 41, 851, 11, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(852, 41, 852, 12, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(853, 41, 853, 13, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(854, 41, 854, 14, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(855, 41, 855, 15, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(856, 41, 856, 16, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(857, 41, 857, 17, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(858, 41, 858, 18, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(859, 41, 859, 19, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(860, 41, 860, 20, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(861, 41, 861, 21, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(862, 42, 862, 1, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(863, 42, 863, 2, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(864, 42, 864, 3, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(865, 42, 865, 4, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(866, 42, 866, 5, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(867, 42, 867, 6, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(868, 42, 868, 7, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(869, 42, 869, 8, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(870, 42, 870, 9, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(871, 42, 871, 10, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(872, 42, 872, 11, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(873, 42, 873, 12, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(874, 42, 874, 13, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(875, 42, 875, 14, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(876, 42, 876, 15, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(877, 42, 877, 16, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(878, 42, 878, 17, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(879, 42, 879, 18, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(880, 42, 880, 19, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(881, 42, 881, 20, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(882, 42, 882, 21, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(883, 43, 883, 1, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(884, 43, 884, 2, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(885, 43, 885, 3, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(886, 43, 886, 4, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(887, 43, 887, 5, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(888, 43, 888, 6, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(889, 43, 889, 7, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(890, 43, 890, 8, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(891, 43, 891, 9, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(892, 43, 892, 10, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(893, 43, 893, 11, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(894, 43, 894, 12, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(895, 43, 895, 13, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(896, 43, 896, 14, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(897, 43, 897, 15, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(898, 43, 898, 16, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(899, 43, 899, 17, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(900, 43, 900, 18, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(901, 43, 901, 19, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(902, 43, 902, 20, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(903, 43, 903, 21, 'ACT', 'ART', 0, 0, NULL, NULL, NULL);
INSERT INTO `klass_students` (`id`, `klass_id`, `student_id`, `student_number`, `state`, `stream`, `promote`, `promote_to`, `score_scheme`, `created_at`, `updated_at`) VALUES
(904, 44, 904, 1, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(905, 44, 905, 2, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(906, 44, 906, 3, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(907, 44, 907, 4, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(908, 44, 908, 5, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(909, 44, 909, 6, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(910, 44, 910, 7, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(911, 44, 911, 8, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(912, 44, 912, 9, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(913, 44, 913, 10, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(914, 44, 914, 11, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(915, 44, 915, 12, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(916, 44, 916, 13, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(917, 44, 917, 14, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(918, 44, 918, 15, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(919, 44, 919, 16, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(920, 44, 920, 17, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(921, 44, 921, 18, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(922, 44, 922, 19, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(923, 44, 923, 20, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(924, 44, 924, 21, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(925, 45, 925, 1, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(926, 45, 926, 2, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(927, 45, 927, 3, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(928, 45, 928, 4, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(929, 45, 929, 5, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(930, 45, 930, 6, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(931, 45, 931, 7, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(932, 45, 932, 8, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(933, 45, 933, 9, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(934, 45, 934, 10, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(935, 45, 935, 11, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(936, 45, 936, 12, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(937, 45, 937, 13, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(938, 45, 938, 14, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(939, 45, 939, 15, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(940, 45, 940, 16, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(941, 45, 941, 17, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(942, 45, 942, 18, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(943, 45, 943, 19, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(944, 45, 944, 20, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(945, 45, 945, 21, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(946, 46, 946, 1, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(947, 46, 947, 2, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(948, 46, 948, 3, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(949, 46, 949, 4, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(950, 46, 950, 5, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(951, 46, 951, 6, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(952, 46, 952, 7, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(953, 46, 953, 8, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(954, 46, 954, 9, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(955, 46, 955, 10, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(956, 46, 956, 11, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(957, 46, 957, 12, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(958, 46, 958, 13, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(959, 46, 959, 14, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(960, 46, 960, 15, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(961, 46, 961, 16, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(962, 46, 962, 17, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(963, 46, 963, 18, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(964, 46, 964, 19, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(965, 46, 965, 20, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(966, 46, 966, 21, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(967, 47, 967, 1, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(968, 47, 968, 2, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(969, 47, 969, 3, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(970, 47, 970, 4, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(971, 47, 971, 5, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(972, 47, 972, 6, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(973, 47, 973, 7, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(974, 47, 974, 8, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(975, 47, 975, 9, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(976, 47, 976, 10, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(977, 47, 977, 11, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(978, 47, 978, 12, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(979, 47, 979, 13, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(980, 47, 980, 14, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(981, 47, 981, 15, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(982, 47, 982, 16, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(983, 47, 983, 17, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(984, 47, 984, 18, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(985, 47, 985, 19, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(986, 47, 986, 20, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(987, 47, 987, 21, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(988, 48, 988, 1, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(989, 48, 989, 2, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(990, 48, 990, 3, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(991, 48, 991, 4, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(992, 48, 992, 5, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(993, 48, 993, 6, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(994, 48, 994, 7, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(995, 48, 995, 8, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(996, 48, 996, 9, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(997, 48, 997, 10, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(998, 48, 998, 11, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(999, 48, 999, 12, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1000, 48, 1000, 13, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1001, 48, 1001, 14, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1002, 48, 1002, 15, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1003, 48, 1003, 16, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1004, 48, 1004, 17, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1005, 48, 1005, 18, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1006, 48, 1006, 19, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1007, 48, 1007, 20, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1008, 48, 1008, 21, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1009, 49, 1009, 1, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1010, 49, 1010, 2, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1011, 49, 1011, 3, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1012, 49, 1012, 4, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1013, 49, 1013, 5, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1014, 49, 1014, 6, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1015, 49, 1015, 7, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1016, 49, 1016, 8, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1017, 49, 1017, 9, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1018, 49, 1018, 10, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1019, 49, 1019, 11, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1020, 49, 1020, 12, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1021, 49, 1021, 13, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1022, 49, 1022, 14, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1023, 49, 1023, 15, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1024, 49, 1024, 16, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1025, 49, 1025, 17, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1026, 49, 1026, 18, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1027, 49, 1027, 19, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1028, 49, 1028, 20, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1029, 49, 1029, 21, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1030, 50, 1030, 1, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1031, 50, 1031, 2, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1032, 50, 1032, 3, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1033, 50, 1033, 4, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1034, 50, 1034, 5, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1035, 50, 1035, 6, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1036, 50, 1036, 7, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1037, 50, 1037, 8, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1038, 50, 1038, 9, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1039, 50, 1039, 10, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1040, 50, 1040, 11, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1041, 50, 1041, 12, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1042, 50, 1042, 13, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1043, 50, 1043, 14, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1044, 50, 1044, 15, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1045, 50, 1045, 16, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1046, 50, 1046, 17, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1047, 50, 1047, 18, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1048, 50, 1048, 19, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1049, 50, 1049, 20, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1050, 50, 1050, 21, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1051, 51, 1051, 1, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1052, 51, 1052, 2, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1053, 51, 1053, 3, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1054, 51, 1054, 4, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1055, 51, 1055, 5, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1056, 51, 1056, 6, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1057, 51, 1057, 7, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1058, 51, 1058, 8, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1059, 51, 1059, 9, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1060, 51, 1060, 10, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1061, 51, 1061, 11, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1062, 51, 1062, 12, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1063, 51, 1063, 13, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1064, 51, 1064, 14, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1065, 51, 1065, 15, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1066, 51, 1066, 16, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1067, 51, 1067, 17, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1068, 51, 1068, 18, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1069, 51, 1069, 19, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1070, 51, 1070, 20, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1071, 51, 1071, 21, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1072, 52, 1072, 1, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1073, 52, 1073, 2, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1074, 52, 1074, 3, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1075, 52, 1075, 4, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1076, 52, 1076, 5, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1077, 52, 1077, 6, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1078, 52, 1078, 7, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1079, 52, 1079, 8, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1080, 52, 1080, 9, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1081, 52, 1081, 10, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1082, 52, 1082, 11, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1083, 52, 1083, 12, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1084, 52, 1084, 13, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1085, 52, 1085, 14, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1086, 52, 1086, 15, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1087, 52, 1087, 16, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1088, 52, 1088, 17, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1089, 52, 1089, 18, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1090, 52, 1090, 19, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1091, 52, 1091, 20, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1092, 52, 1092, 21, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1093, 53, 1093, 1, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1094, 53, 1094, 2, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1095, 53, 1095, 3, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1096, 53, 1096, 4, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1097, 53, 1097, 5, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1098, 53, 1098, 6, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1099, 53, 1099, 7, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1100, 53, 1100, 8, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1101, 53, 1101, 9, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1102, 53, 1102, 10, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1103, 53, 1103, 11, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1104, 53, 1104, 12, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1105, 53, 1105, 13, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1106, 53, 1106, 14, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1107, 53, 1107, 15, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1108, 53, 1108, 16, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1109, 53, 1109, 17, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1110, 53, 1110, 18, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1111, 53, 1111, 19, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1112, 53, 1112, 20, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1113, 53, 1113, 21, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1114, 54, 1114, 1, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1115, 54, 1115, 2, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1116, 54, 1116, 3, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1117, 54, 1117, 4, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1118, 54, 1118, 5, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1119, 54, 1119, 6, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1120, 54, 1120, 7, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1121, 54, 1121, 8, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1122, 54, 1122, 9, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1123, 54, 1123, 10, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1124, 54, 1124, 11, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1125, 54, 1125, 12, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1126, 54, 1126, 13, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1127, 54, 1127, 14, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1128, 54, 1128, 15, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1129, 54, 1129, 16, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1130, 54, 1130, 17, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1131, 54, 1131, 18, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1132, 54, 1132, 19, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1133, 54, 1133, 20, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1134, 54, 1134, 21, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1135, 55, 1135, 1, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1136, 55, 1136, 2, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1137, 55, 1137, 3, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1138, 55, 1138, 4, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1139, 55, 1139, 5, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1140, 55, 1140, 6, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1141, 55, 1141, 7, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1142, 55, 1142, 8, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1143, 55, 1143, 9, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1144, 55, 1144, 10, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1145, 55, 1145, 11, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1146, 55, 1146, 12, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1147, 55, 1147, 13, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1148, 55, 1148, 14, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1149, 55, 1149, 15, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1150, 55, 1150, 16, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1151, 55, 1151, 17, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1152, 55, 1152, 18, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1153, 55, 1153, 19, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1154, 55, 1154, 20, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1155, 55, 1155, 21, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1156, 56, 1156, 1, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1157, 56, 1157, 2, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1158, 56, 1158, 3, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1159, 56, 1159, 4, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1160, 56, 1160, 5, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1161, 56, 1161, 6, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1162, 56, 1162, 7, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1163, 56, 1163, 8, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1164, 56, 1164, 9, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1165, 56, 1165, 10, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1166, 56, 1166, 11, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1167, 56, 1167, 12, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1168, 56, 1168, 13, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1169, 56, 1169, 14, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1170, 56, 1170, 15, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1171, 56, 1171, 16, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1172, 56, 1172, 17, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1173, 56, 1173, 18, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1174, 56, 1174, 19, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1175, 56, 1175, 20, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1176, 56, 1176, 21, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1177, 57, 1177, 1, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1178, 57, 1178, 2, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1179, 57, 1179, 3, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1180, 57, 1180, 4, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1181, 57, 1181, 5, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1182, 57, 1182, 6, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1183, 57, 1183, 7, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1184, 57, 1184, 8, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1185, 57, 1185, 9, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1186, 57, 1186, 10, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1187, 57, 1187, 11, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1188, 57, 1188, 12, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1189, 57, 1189, 13, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1190, 57, 1190, 14, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1191, 57, 1191, 15, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1192, 57, 1192, 16, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1193, 57, 1193, 17, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1194, 57, 1194, 18, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1195, 57, 1195, 19, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1196, 57, 1196, 20, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1197, 57, 1197, 21, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1198, 58, 1198, 1, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1199, 58, 1199, 2, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1200, 58, 1200, 3, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1201, 58, 1201, 4, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1202, 58, 1202, 5, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1203, 58, 1203, 6, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1204, 58, 1204, 7, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1205, 58, 1205, 8, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1206, 58, 1206, 9, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1207, 58, 1207, 10, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1208, 58, 1208, 11, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1209, 58, 1209, 12, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1210, 58, 1210, 13, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1211, 58, 1211, 14, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1212, 58, 1212, 15, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1213, 58, 1213, 16, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1214, 58, 1214, 17, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1215, 58, 1215, 18, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1216, 58, 1216, 19, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1217, 58, 1217, 20, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1218, 58, 1218, 21, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1219, 59, 1219, 1, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1220, 59, 1220, 2, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1221, 59, 1221, 3, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1222, 59, 1222, 4, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1223, 59, 1223, 5, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1224, 59, 1224, 6, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1225, 59, 1225, 7, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1226, 59, 1226, 8, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1227, 59, 1227, 9, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1228, 59, 1228, 10, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1229, 59, 1229, 11, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1230, 59, 1230, 12, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1231, 59, 1231, 13, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1232, 59, 1232, 14, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1233, 59, 1233, 15, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1234, 59, 1234, 16, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1235, 59, 1235, 17, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1236, 59, 1236, 18, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1237, 59, 1237, 19, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1238, 59, 1238, 20, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1239, 59, 1239, 21, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1240, 60, 1240, 1, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1241, 60, 1241, 2, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1242, 60, 1242, 3, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1243, 60, 1243, 4, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1244, 60, 1244, 5, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1245, 60, 1245, 6, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1246, 60, 1246, 7, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1247, 60, 1247, 8, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1248, 60, 1248, 9, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1249, 60, 1249, 10, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1250, 60, 1250, 11, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1251, 60, 1251, 12, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1252, 60, 1252, 13, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1253, 60, 1253, 14, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1254, 60, 1254, 15, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1255, 60, 1255, 16, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1256, 60, 1256, 17, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1257, 60, 1257, 18, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1258, 60, 1258, 19, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1259, 60, 1259, 20, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1260, 60, 1260, 21, 'ACT', 'ART', 0, 0, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `locations`
--

CREATE TABLE `locations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_resets_table', 1),
(3, '2014_10_12_200000_add_two_factor_columns_to_users_table', 1),
(4, '2019_08_19_000000_create_failed_jobs_table', 1),
(5, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(6, '2020_05_21_100000_create_teams_table', 1),
(7, '2020_05_21_200000_create_team_user_table', 1),
(8, '2020_05_21_300000_create_team_invitations_table', 1),
(9, '2022_10_25_012240_create_sessions_table', 1),
(10, '2022_10_25_101518_create_suppliers_table', 1),
(11, '2022_10_25_101531_create_categories_table', 1),
(12, '2022_10_25_101544_create_locations_table', 1),
(13, '2022_11_24_064103_create_years_table', 1),
(14, '2022_11_25_025230_create_subjects_table', 1),
(15, '2022_11_25_025324_create_courses_table', 1),
(16, '2022_11_25_025738_create_klasses_table', 1),
(17, '2022_11_25_031010_create_staff_table', 1),
(18, '2022_11_25_031020_create_students_table', 1),
(19, '2022_11_25_031818_create_gardians_table', 1),
(20, '2022_11_25_031922_create_student_gardians_table', 1),
(21, '2022_11_28_044957_create_disciplines_table', 1),
(22, '2022_11_29_035409_create_configs_table', 1),
(23, '2022_11_30_090054_create_scores_table', 1),
(24, '2022_12_01_075920_create_grades_table', 1),
(25, '2022_12_02_011550_create_klass_students_table', 1),
(26, '2022_12_09_071744_create_teachers_table', 1),
(27, '2022_12_12_141100_create_course_scores_table', 1),
(28, '2023_01_07_152244_create_transcripts_table', 1),
(29, '2023_01_07_162945_create_transcript_templates_table', 1),
(30, '2023_01_09_033255_create_score_columns_table', 1),
(31, '2023_01_11_023007_create_course_teachers_table', 1),
(32, '2023_01_11_064535_create_permission_tables', 1),
(33, '2023_01_14_024917_create_addresses_table', 1),
(34, '2023_01_14_133306_create_identity_documents_table', 1),
(35, '2023_01_14_141228_create_banks_table', 1),
(36, '2023_01_14_142338_create_student_details_table', 1),
(37, '2023_01_14_150126_create_parentals_table', 1),
(38, '2023_01_14_151709_create_guardians_table', 1),
(39, '2023_01_14_161817_create_healthcares_table', 1),
(40, '2023_01_18_083745_create_subject_templates_table', 1),
(41, '2023_02_03_013106_create_score_templates_table', 1),
(42, '2023_02_06_084919_create_studies_table', 2),
(43, '2023_02_06_084931_create_study_subjects_table', 2),
(44, '2023_01_09_033255_create_course_scores_table', 3),
(45, '2023_02_09_014246_create_habits_table', 4),
(46, '2023_02_09_014659_create_outcomes_table', 5),
(47, '2023_02_10_033535_create_behaviours_table', 6);

-- --------------------------------------------------------

--
-- Table structure for table `model_has_permissions`
--

CREATE TABLE `model_has_permissions` (
  `permission_id` bigint(20) UNSIGNED NOT NULL,
  `model_type` varchar(255) NOT NULL,
  `model_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `model_has_roles`
--

CREATE TABLE `model_has_roles` (
  `role_id` bigint(20) UNSIGNED NOT NULL,
  `model_type` varchar(255) NOT NULL,
  `model_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `model_has_roles`
--

INSERT INTO `model_has_roles` (`role_id`, `model_type`, `model_id`) VALUES
(1, 'App\\Models\\User', 1),
(2, 'App\\Models\\User', 2);

-- --------------------------------------------------------

--
-- Table structure for table `outcomes`
--

CREATE TABLE `outcomes` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `klass_student_id` bigint(20) NOT NULL,
  `terim_id` bigint(20) NOT NULL,
  `late` int(11) NOT NULL,
  `absent` int(11) NOT NULL,
  `reward` varchar(255) NOT NULL,
  `leisure_name` varchar(255) NOT NULL,
  `leisure_perform` varchar(255) NOT NULL,
  `comment` varchar(255) NOT NULL,
  `appraisal` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `parentals`
--

CREATE TABLE `parentals` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `student_id` bigint(20) NOT NULL,
  `father_name` varchar(255) DEFAULT NULL,
  `father_phone` varchar(255) DEFAULT NULL,
  `father_organization` varchar(255) DEFAULT NULL,
  `father_job` varchar(255) DEFAULT NULL,
  `father_address` varchar(255) DEFAULT NULL,
  `mother_name` varchar(255) DEFAULT NULL,
  `mother_phone` varchar(255) DEFAULT NULL,
  `mother_organization` varchar(255) DEFAULT NULL,
  `mother_job` varchar(255) DEFAULT NULL,
  `mother_address` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `permissions`
--

CREATE TABLE `permissions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `guard_name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `guard_name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES
(1, 'master', 'web', '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(2, 'admin', 'web', '2023-02-03 01:27:29', '2023-02-03 01:27:29');

-- --------------------------------------------------------

--
-- Table structure for table `role_has_permissions`
--

CREATE TABLE `role_has_permissions` (
  `permission_id` bigint(20) UNSIGNED NOT NULL,
  `role_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `scores`
--

CREATE TABLE `scores` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `klass_student_id` bigint(20) NOT NULL,
  `course_score_id` bigint(20) NOT NULL,
  `point` varchar(255) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `scores`
--

INSERT INTO `scores` (`id`, `klass_student_id`, `course_score_id`, `point`, `remark`, `created_at`, `updated_at`) VALUES
(1, 3, 1, '100', NULL, NULL, '2023-02-03 01:34:23'),
(2, 5, 1, '80', NULL, NULL, '2023-02-03 01:34:23'),
(3, 3, 2, '90', NULL, NULL, '2023-02-03 01:34:23'),
(4, 1, 21, '1', NULL, '2023-02-03 01:28:45', '2023-02-03 01:34:23'),
(256, 1, 22, '2', NULL, '2023-02-03 01:30:42', '2023-02-03 01:34:23'),
(392, 1, 23, '3', NULL, '2023-02-03 01:34:23', '2023-02-03 01:34:23');

-- --------------------------------------------------------

--
-- Table structure for table `score_columns2`
--

CREATE TABLE `score_columns2` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `term_id` bigint(20) NOT NULL,
  `course_id` bigint(20) NOT NULL,
  `sequence` int(11) DEFAULT NULL,
  `field_name` varchar(255) NOT NULL,
  `field_label` varchar(255) NOT NULL,
  `type` varchar(255) DEFAULT NULL,
  `scheme` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `for_transcript` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `score_columns2`
--

INSERT INTO `score_columns2` (`id`, `term_id`, `course_id`, `sequence`, `field_name`, `field_label`, `type`, `scheme`, `description`, `for_transcript`, `created_at`, `updated_at`) VALUES
(1, 1, 1, NULL, 'term1', '?????????', NULL, NULL, NULL, 0, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(2, 2, 1, NULL, 'term2', '?????????', NULL, NULL, NULL, 0, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(3, 1, 2, NULL, 'term1', '?????????', NULL, NULL, NULL, 0, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(4, 2, 2, NULL, 'term2', '?????????', NULL, NULL, NULL, 0, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(5, 1, 3, NULL, 'term1', '?????????', NULL, NULL, NULL, 0, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(6, 2, 3, NULL, 'term2', '?????????', NULL, NULL, NULL, 0, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(7, 1, 4, NULL, 'term1', '?????????', NULL, NULL, NULL, 0, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(8, 2, 4, NULL, 'term2', '?????????', NULL, NULL, NULL, 0, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(9, 1, 5, NULL, 'term1', '?????????', NULL, NULL, NULL, 0, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(10, 2, 5, NULL, 'term2', '?????????', NULL, NULL, NULL, 0, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(11, 1, 6, NULL, 'term1', '?????????', NULL, NULL, NULL, 0, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(12, 2, 6, NULL, 'term2', '?????????', NULL, NULL, NULL, 0, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(13, 1, 7, NULL, 'term1', '?????????', NULL, NULL, NULL, 0, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(14, 2, 7, NULL, 'term2', '?????????', NULL, NULL, NULL, 0, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(15, 1, 8, NULL, 'term1', '?????????', NULL, NULL, NULL, 0, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(16, 2, 8, NULL, 'term2', '?????????', NULL, NULL, NULL, 0, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(17, 1, 9, NULL, 'term1', '?????????', NULL, NULL, NULL, 0, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(18, 2, 9, NULL, 'term2', '?????????', NULL, NULL, NULL, 0, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(19, 1, 10, NULL, 'term1', '?????????', NULL, NULL, NULL, 0, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(20, 2, 10, NULL, 'term2', '?????????', NULL, NULL, NULL, 0, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(21, 1, 1, 1, '', 'Test1', NULL, NULL, NULL, 0, NULL, NULL),
(22, 1, 1, 2, '', 'Exam', NULL, NULL, NULL, 0, NULL, NULL),
(23, 2, 1, 3, '', 'Test2', NULL, NULL, NULL, 0, NULL, NULL),
(24, 2, 1, 4, '', 'Exam', NULL, NULL, NULL, 0, NULL, NULL),
(255, 1, 341, NULL, 'term1', '?????????', NULL, NULL, NULL, 0, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(256, 2, 341, NULL, 'term2', '?????????', NULL, NULL, NULL, 0, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(257, 1, 342, NULL, 'term1', '?????????', NULL, NULL, NULL, 0, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(258, 2, 342, NULL, 'term2', '?????????', NULL, NULL, NULL, 0, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(259, 1, 343, NULL, 'term1', '?????????', NULL, NULL, NULL, 0, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(260, 2, 343, NULL, 'term2', '?????????', NULL, NULL, NULL, 0, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(261, 1, 344, NULL, 'term1', '?????????', NULL, NULL, NULL, 0, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(262, 2, 344, NULL, 'term2', '?????????', NULL, NULL, NULL, 0, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(263, 1, 345, NULL, 'term1', '?????????', NULL, NULL, NULL, 0, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(264, 2, 345, NULL, 'term2', '?????????', NULL, NULL, NULL, 0, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(265, 1, 346, NULL, 'term1', '?????????', NULL, NULL, NULL, 0, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(266, 2, 346, NULL, 'term2', '?????????', NULL, NULL, NULL, 0, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(267, 1, 347, NULL, 'term1', '?????????', NULL, NULL, NULL, 0, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(268, 2, 347, NULL, 'term2', '?????????', NULL, NULL, NULL, 0, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(269, 1, 348, NULL, 'term1', '?????????', NULL, NULL, NULL, 0, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(270, 2, 348, NULL, 'term2', '?????????', NULL, NULL, NULL, 0, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(271, 1, 349, NULL, 'term1', '?????????', NULL, NULL, NULL, 0, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(272, 2, 349, NULL, 'term2', '?????????', NULL, NULL, NULL, 0, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(273, 1, 350, NULL, 'term1', '?????????', NULL, NULL, NULL, 0, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(274, 2, 350, NULL, 'term2', '?????????', NULL, NULL, NULL, 0, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(275, 1, 351, NULL, 'term1', '?????????', NULL, NULL, NULL, 0, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(276, 2, 351, NULL, 'term2', '?????????', NULL, NULL, NULL, 0, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(277, 1, 352, NULL, 'term1', '?????????', NULL, NULL, NULL, 0, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(278, 2, 352, NULL, 'term2', '?????????', NULL, NULL, NULL, 0, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(279, 1, 353, NULL, 'term1', '?????????', NULL, NULL, NULL, 0, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(280, 2, 353, NULL, 'term2', '?????????', NULL, NULL, NULL, 0, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(281, 1, 354, NULL, 'term1', '?????????', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(282, 2, 354, NULL, 'term2', '?????????', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(283, 1, 355, NULL, 'term1', '?????????', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(284, 2, 355, NULL, 'term2', '?????????', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(285, 1, 356, NULL, 'term1', '?????????', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(286, 2, 356, NULL, 'term2', '?????????', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(287, 1, 357, NULL, 'term1', '?????????', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(288, 2, 357, NULL, 'term2', '?????????', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(289, 1, 358, NULL, 'term1', '?????????', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(290, 2, 358, NULL, 'term2', '?????????', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(291, 1, 359, NULL, 'term1', '?????????', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(292, 2, 359, NULL, 'term2', '?????????', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(293, 1, 360, NULL, 'term1', '?????????', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(294, 2, 360, NULL, 'term2', '?????????', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(295, 1, 361, NULL, 'term1', '?????????', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(296, 2, 361, NULL, 'term2', '?????????', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(297, 1, 362, NULL, 'term1', '?????????', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(298, 2, 362, NULL, 'term2', '?????????', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(299, 1, 363, NULL, 'term1', '?????????', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(300, 2, 363, NULL, 'term2', '?????????', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(301, 1, 364, NULL, 'term1', '?????????', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(302, 2, 364, NULL, 'term2', '?????????', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(303, 1, 365, NULL, 'term1', '?????????', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(304, 2, 365, NULL, 'term2', '?????????', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(305, 1, 366, NULL, 'term1', '?????????', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(306, 2, 366, NULL, 'term2', '?????????', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(307, 1, 367, NULL, 'term1', '?????????', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(308, 2, 367, NULL, 'term2', '?????????', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(309, 1, 368, NULL, 'term1', '?????????', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(310, 2, 368, NULL, 'term2', '?????????', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(311, 1, 369, NULL, 'term1', '?????????', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(312, 2, 369, NULL, 'term2', '?????????', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(313, 1, 370, NULL, 'term1', '?????????', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(314, 2, 370, NULL, 'term2', '?????????', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(315, 1, 371, NULL, 'term1', '?????????', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(316, 2, 371, NULL, 'term2', '?????????', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(317, 1, 372, NULL, 'term1', '?????????', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(318, 2, 372, NULL, 'term2', '?????????', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(319, 1, 373, NULL, 'term1', '?????????', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(320, 2, 373, NULL, 'term2', '?????????', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(321, 1, 374, NULL, 'term1', '?????????', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(322, 2, 374, NULL, 'term2', '?????????', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(323, 1, 375, NULL, 'term1', '?????????', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(324, 2, 375, NULL, 'term2', '?????????', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(325, 1, 376, NULL, 'term1', '?????????', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(326, 2, 376, NULL, 'term2', '?????????', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(327, 1, 377, NULL, 'term1', '?????????', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(328, 2, 377, NULL, 'term2', '?????????', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(329, 1, 378, NULL, 'term1', '?????????', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(330, 2, 378, NULL, 'term2', '?????????', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(331, 1, 379, NULL, 'comment', '??????', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(332, 1, 380, NULL, 'comment', '??????', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08');

-- --------------------------------------------------------

--
-- Table structure for table `score_templates`
--

CREATE TABLE `score_templates` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `batch` varchar(255) DEFAULT NULL,
  `type` varchar(6) NOT NULL,
  `term_id` bigint(20) NOT NULL,
  `field_name` varchar(255) NOT NULL,
  `field_label` varchar(255) NOT NULL,
  `sequence` int(11) DEFAULT NULL,
  `scheme` varchar(255) DEFAULT NULL,
  `for_transcript` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `score_templates`
--

INSERT INTO `score_templates` (`id`, `batch`, `type`, `term_id`, `field_name`, `field_label`, `sequence`, `scheme`, `for_transcript`, `created_at`, `updated_at`) VALUES
(1, 'TERMS', 'SUB', 1, '', '?????????', 1, NULL, 1, NULL, NULL),
(2, 'TERMS', 'SUB', 2, '', '?????????', 2, NULL, 1, NULL, NULL),
(3, 'COMMENT', 'ATT', 0, '', '??????', 1, NULL, 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` longtext NOT NULL,
  `last_activity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('zn1YMqjxyGSn5TsMm3LNiGjmbyb4xBBKQa6eHtuE', 2, '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/102.0.0.0 Safari/537.36', 'YTo1OntzOjY6Il90b2tlbiI7czo0MDoiTk80THkyQXM0ODZWc3pKMWJzZ1lxV3kyVUJMdTN2RFBwbGhpcUwzViI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDY6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9tYW5hZ2UvYmVoYXZpb3Vycz9rc2lkPTEiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX1zOjUwOiJsb2dpbl93ZWJfNTliYTM2YWRkYzJiMmY5NDAxNTgwZjAxNGM3ZjU4ZWE0ZTMwOTg5ZCI7aToyO3M6MjE6InBhc3N3b3JkX2hhc2hfc2FuY3R1bSI7czo2MDoiJDJ5JDEwJFRhblBJNXZ6aEQ1MjUxWnpva2g4dy5vR0FzVlM2S1FuSmN2cXJNaG1sZTJieHpmQlBuUWJxIjt9', 1676021997);

-- --------------------------------------------------------

--
-- Table structure for table `staff`
--

CREATE TABLE `staff` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `code` varchar(255) DEFAULT NULL,
  `name_zh` varchar(255) NOT NULL,
  `name_fn` varchar(255) DEFAULT NULL,
  `gender` char(255) NOT NULL,
  `dob` date DEFAULT NULL,
  `mobile` varchar(255) DEFAULT NULL,
  `sector` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `staff`
--

INSERT INTO `staff` (`id`, `code`, `name_zh`, `name_fn`, `gender`, `dob`, `mobile`, `sector`, `created_at`, `updated_at`) VALUES
(1, NULL, '?????????', NULL, 'M', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(2, NULL, '??????', NULL, 'M', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(3, NULL, '?????????', NULL, 'M', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(4, NULL, '?????????', NULL, 'M', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(5, NULL, '??????', NULL, 'M', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(6, NULL, '??????', NULL, 'M', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(7, NULL, '??????', NULL, 'M', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(8, NULL, '??????', NULL, 'M', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(9, NULL, '??????', NULL, 'M', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(10, NULL, '?????????', NULL, 'M', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(11, NULL, '?????????', NULL, 'F', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(12, NULL, '?????????', NULL, 'F', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(13, NULL, '??????', NULL, 'M', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(14, NULL, '?????????', NULL, 'F', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(15, NULL, '?????????', NULL, 'F', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(16, NULL, '????????????', NULL, 'M', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(17, NULL, '?????????', NULL, 'M', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(18, NULL, '??????', NULL, 'M', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(19, NULL, '??????', NULL, 'M', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(20, NULL, '?????????', NULL, 'F', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(21, NULL, '??????', NULL, 'F', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(22, NULL, '?????????', NULL, 'M', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(23, NULL, '?????????', NULL, 'F', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(24, NULL, '??????', NULL, 'F', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(25, NULL, '??????', NULL, 'F', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(26, NULL, '????????????', NULL, 'F', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(27, NULL, '?????????', NULL, 'F', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(28, NULL, '??????', NULL, 'M', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(29, NULL, '?????????', NULL, 'M', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(30, NULL, '?????????', NULL, 'M', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(31, NULL, '?????????', NULL, 'M', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(32, NULL, '??????', NULL, 'F', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(33, NULL, '?????????', NULL, 'M', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(34, NULL, '?????????', NULL, 'F', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(35, NULL, '??????', NULL, 'M', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(36, NULL, '????????????', NULL, 'F', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(37, NULL, '?????????', NULL, 'F', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(38, NULL, '?????????', NULL, 'F', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(39, NULL, '????????????', NULL, 'F', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(40, NULL, '??????', NULL, 'M', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(41, NULL, '?????????', NULL, 'M', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(42, NULL, '??????', NULL, 'M', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(43, NULL, '??????', NULL, 'F', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(44, NULL, '??????', NULL, 'M', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(45, NULL, '????????????', NULL, 'M', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(46, NULL, '????????????', NULL, 'M', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(47, NULL, '?????????', NULL, 'F', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(48, NULL, '?????????', NULL, 'F', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(49, NULL, '??????', NULL, 'M', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(50, NULL, '??????', NULL, 'M', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(51, NULL, '?????????', NULL, 'M', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(52, NULL, '?????????', NULL, 'M', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(53, NULL, '?????????', NULL, 'M', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(54, NULL, '?????????', NULL, 'F', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(55, NULL, '?????????', NULL, 'M', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(56, NULL, '?????????', NULL, 'M', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(57, NULL, '?????????', NULL, 'F', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(58, NULL, '????????????', NULL, 'F', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(59, NULL, '?????????', NULL, 'M', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(60, NULL, '?????????', NULL, 'F', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(61, NULL, '??????', NULL, 'F', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(62, NULL, '?????????', NULL, 'M', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(63, NULL, '?????????', NULL, 'F', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(64, NULL, '??????', NULL, 'F', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(65, NULL, '?????????', NULL, 'M', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(66, NULL, '??????', NULL, 'M', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(67, NULL, '??????', NULL, 'F', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(68, NULL, '??????', NULL, 'M', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(69, NULL, '??????', NULL, 'M', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(70, NULL, '????????????', NULL, 'M', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(71, NULL, '?????????', NULL, 'F', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(72, NULL, '??????', NULL, 'M', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(73, NULL, '??????', NULL, 'F', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(74, NULL, '?????????', NULL, 'F', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(75, NULL, '??????', NULL, 'M', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(76, NULL, '?????????', NULL, 'M', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(77, NULL, '?????????', NULL, 'M', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(78, NULL, '??????', NULL, 'F', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(79, NULL, '??????', NULL, 'M', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(80, NULL, '?????????', NULL, 'M', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(81, NULL, '?????????', NULL, 'F', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(82, NULL, '??????', NULL, 'M', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(83, NULL, '?????????', NULL, 'F', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(84, NULL, '?????????', NULL, 'M', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(85, NULL, '??????', NULL, 'F', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(86, NULL, '??????', NULL, 'M', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(87, NULL, '?????????', NULL, 'M', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(88, NULL, '??????', NULL, 'F', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(89, NULL, '?????????', NULL, 'M', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(90, NULL, '??????', NULL, 'M', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(91, NULL, '??????', NULL, 'F', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(92, NULL, '?????????', NULL, 'M', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(93, NULL, '?????????', NULL, 'F', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(94, NULL, '?????????', NULL, 'M', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(95, NULL, '?????????', NULL, 'M', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(96, NULL, '?????????', NULL, 'M', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(97, NULL, '??????', NULL, 'F', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(98, NULL, '?????????', NULL, 'F', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(99, NULL, '??????', NULL, 'F', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(100, NULL, '????????????', NULL, 'F', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29');

-- --------------------------------------------------------

--
-- Table structure for table `students`
--

CREATE TABLE `students` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name_zh` varchar(255) NOT NULL,
  `name_fn` varchar(255) DEFAULT NULL,
  `name_display` varchar(255) DEFAULT NULL,
  `gender` char(1) NOT NULL,
  `dob` date DEFAULT NULL,
  `pob` varchar(255) DEFAULT NULL,
  `start_letter` varchar(255) DEFAULT NULL,
  `start_grade` varchar(255) DEFAULT NULL,
  `sic` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `dsej_num` varchar(255) DEFAULT NULL,
  `medical_num` varchar(255) DEFAULT NULL,
  `entry_date` date DEFAULT NULL,
  `past_school_name` varchar(255) DEFAULT NULL,
  `religion` varchar(255) DEFAULT NULL,
  `phone_sms` varchar(255) DEFAULT NULL,
  `phone_home` varchar(255) DEFAULT NULL,
  `carer` varchar(255) DEFAULT NULL,
  `parent` text DEFAULT NULL,
  `garidan` text DEFAULT NULL,
  `liaison` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `students`
--

INSERT INTO `students` (`id`, `name_zh`, `name_fn`, `name_display`, `gender`, `dob`, `pob`, `start_letter`, `start_grade`, `sic`, `phone`, `dsej_num`, `medical_num`, `entry_date`, `past_school_name`, `religion`, `phone_sms`, `phone_home`, `carer`, `parent`, `garidan`, `liaison`, `created_at`, `updated_at`) VALUES
(1, '?????????', '??????', NULL, 'F', '2010-10-02', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(2, '??????', '???', NULL, 'F', '2014-10-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(3, '?????????', '???', NULL, 'M', '2013-01-25', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(4, '?????????', '??????', NULL, 'M', '2003-01-31', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(5, '??????', '??????', NULL, 'F', '2012-09-25', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(6, '?????????', '???', NULL, 'F', '2006-06-15', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(7, '??????', '???', NULL, 'F', '2003-03-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(8, '?????????', '??????', NULL, 'F', '2014-01-31', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(9, '????????????', '???', NULL, 'F', '2006-04-18', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(10, '?????????', '???', NULL, 'F', '2002-09-28', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(11, '?????????', '???', NULL, 'M', '2008-06-19', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(12, '??????', '???', NULL, 'F', '2009-04-24', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(13, '?????????', '??????', NULL, 'M', '2013-08-08', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(14, '?????????', '??????', NULL, 'M', '2006-08-28', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(15, '?????????', '???', NULL, 'F', '2001-03-11', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(16, '??????', '??????', NULL, 'M', '2004-04-17', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(17, '??????', '???', NULL, 'F', '2011-09-29', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(18, '?????????', '??????', NULL, 'F', '2012-01-13', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(19, '????????????', '??????', NULL, 'F', '2009-10-07', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(20, '?????????', '???', NULL, 'F', '2007-09-15', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(21, '?????????', '??????', NULL, 'F', '2004-05-04', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(22, '??????', '???', NULL, 'F', '2009-10-27', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(23, '??????', '??????', NULL, 'F', '2005-10-26', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(24, '??????', '??????', NULL, 'F', '2015-04-30', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(25, '?????????', '??????', NULL, 'F', '2005-12-18', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(26, '??????', '???', NULL, 'M', '2015-05-09', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(27, '?????????', '??????', NULL, 'F', '2001-09-25', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(28, '????????????', '??????', NULL, 'M', '2002-09-20', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(29, '?????????', '??????', NULL, 'M', '2007-10-06', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(30, '?????????', '???', NULL, 'F', '2006-10-10', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(31, '??????', '???', NULL, 'F', '2014-08-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(32, '?????????', '??????', NULL, 'M', '2010-09-08', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(33, '?????????', '???', NULL, 'M', '2008-05-31', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(34, '????????????', '??????', NULL, 'M', '2015-05-07', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(35, '????????????', '???', NULL, 'F', '2002-02-14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(36, '??????', '???', NULL, 'F', '2001-12-16', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(37, '?????????', '??????', NULL, 'M', '2012-02-10', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(38, '??????', '??????', NULL, 'M', '2004-04-30', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(39, '?????????', '???', NULL, 'F', '2004-09-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(40, '??????', '???', NULL, 'F', '2013-10-06', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(41, '?????????', '???', NULL, 'F', '2008-07-29', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(42, '??????', '???', NULL, 'M', '2007-02-06', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(43, '?????????', '??????', NULL, 'F', '2005-06-22', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(44, '?????????', '??????', NULL, 'M', '2008-07-25', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(45, '?????????', '???', NULL, 'F', '2006-09-20', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(46, '??????', '???', NULL, 'M', '2012-10-31', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(47, '?????????', '???', NULL, 'F', '2009-05-28', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(48, '?????????', '???', NULL, 'M', '2011-11-30', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(49, '?????????', '??????', NULL, 'M', '2007-01-24', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(50, '??????', '???', NULL, 'F', '2008-01-24', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(51, '??????', '???', NULL, 'M', '2014-03-10', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(52, '??????', '???', NULL, 'F', '2009-07-04', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(53, '??????', '???', NULL, 'F', '2000-12-31', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(54, '????????????', '???', NULL, 'M', '2006-07-22', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(55, '??????', '??????', NULL, 'F', '2006-03-19', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(56, '??????', '???', NULL, 'M', '2006-09-12', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(57, '?????????', '???', NULL, 'M', '2001-03-16', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(58, '??????', '???', NULL, 'M', '2014-03-06', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(59, '?????????', '???', NULL, 'M', '2012-02-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(60, '??????', '???', NULL, 'M', '2011-07-22', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(61, '?????????', '???', NULL, 'M', '2004-07-12', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(62, '??????', '??????', NULL, 'M', '2014-04-05', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(63, '??????', '???', NULL, 'F', '2005-04-24', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(64, '??????', '???', NULL, 'M', '2005-06-18', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(65, '?????????', '??????', NULL, 'F', '2013-12-07', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(66, '??????', '???', NULL, 'F', '2006-11-16', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(67, '??????', '??????', NULL, 'F', '2007-09-23', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(68, '?????????', '???', NULL, 'M', '2006-08-21', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(69, '?????????', '??????', NULL, 'M', '2010-06-30', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(70, '?????????', '???', NULL, 'F', '2009-04-06', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(71, '?????????', '??????', NULL, 'M', '2006-04-25', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(72, '??????', '??????', NULL, 'M', '2002-05-11', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(73, '??????', '???', NULL, 'F', '2014-10-19', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(74, '?????????', '???', NULL, 'M', '2001-10-27', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(75, '?????????', '??????', NULL, 'F', '2010-05-24', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(76, '??????', '???', NULL, 'M', '2009-02-17', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(77, '?????????', '??????', NULL, 'M', '2012-10-19', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(78, '??????', '???', NULL, 'F', '2001-01-12', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(79, '?????????', '???', NULL, 'F', '2002-03-19', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(80, '??????', '???', NULL, 'M', '2001-06-17', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(81, '?????????', '???', NULL, 'F', '2004-03-07', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(82, '?????????', '??????', NULL, 'M', '2006-03-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(83, '?????????', '??????', NULL, 'M', '2002-06-10', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(84, '?????????', '??????', NULL, 'F', '2013-02-11', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(85, '?????????', '??????', NULL, 'F', '2002-09-11', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(86, '?????????', '???', NULL, 'M', '2002-09-26', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(87, '??????', '??????', NULL, 'F', '2008-05-19', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(88, '??????', '???', NULL, 'M', '2007-11-14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(89, '??????', '???', NULL, 'F', '2009-02-15', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(90, '?????????', '???', NULL, 'F', '2001-06-12', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(91, '??????', '??????', NULL, 'M', '2015-08-05', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(92, '??????', '???', NULL, 'M', '2010-04-22', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(93, '?????????', '??????', NULL, 'F', '2011-07-03', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(94, '??????', '???', NULL, 'F', '2007-05-18', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(95, '????????????', '??????', NULL, 'M', '2007-01-14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(96, '?????????', '???', NULL, 'F', '2007-12-08', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(97, '??????', '???', NULL, 'F', '2001-01-23', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(98, '??????', '??????', NULL, 'M', '2004-05-27', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(99, '?????????', '??????', NULL, 'F', '2002-11-02', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(100, '?????????', '??????', NULL, 'M', '2009-12-18', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(101, '??????', '???', NULL, 'F', '2005-04-26', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(102, '??????', '??????', NULL, 'F', '2014-03-03', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(103, '??????', '???', NULL, 'F', '2004-03-22', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(104, '??????', '???', NULL, 'M', '2004-01-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(105, '??????', '???', NULL, 'M', '2004-09-17', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(106, '?????????', '??????', NULL, 'M', '2010-01-04', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(107, '??????', '???', NULL, 'M', '2002-02-14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(108, '????????????', '???', NULL, 'F', '2007-01-12', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(109, '?????????', '???', NULL, 'F', '2013-09-15', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(110, '?????????', '??????', NULL, 'F', '2010-12-12', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(111, '?????????', '???', NULL, 'M', '2014-02-09', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(112, '?????????', '???', NULL, 'F', '2001-06-16', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(113, '?????????', '??????', NULL, 'F', '2010-06-22', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(114, '??????', '??????', NULL, 'M', '2005-04-06', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(115, '?????????', '??????', NULL, 'M', '2007-07-28', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(116, '?????????', '??????', NULL, 'M', '2011-07-04', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(117, '?????????', '??????', NULL, 'M', '2011-11-10', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(118, '??????', '???', NULL, 'M', '2011-04-29', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(119, '??????', '???', NULL, 'F', '2008-09-07', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(120, '??????', '??????', NULL, 'M', '2002-05-11', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(121, '?????????', '???', NULL, 'F', '2007-09-16', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(122, '??????', '??????', NULL, 'M', '2006-09-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(123, '??????', '???', NULL, 'F', '2008-08-06', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(124, '?????????', '???', NULL, 'M', '2007-05-16', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(125, '?????????', '??????', NULL, 'M', '2013-09-11', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(126, '?????????', '??????', NULL, 'M', '2007-07-31', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(127, '??????', '???', NULL, 'M', '2015-06-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(128, '??????', '???', NULL, 'M', '2004-12-29', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(129, '????????????', '??????', NULL, 'F', '2009-11-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(130, '?????????', '???', NULL, 'M', '2013-06-28', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(131, '?????????', '???', NULL, 'F', '2008-06-13', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(132, '?????????', '??????', NULL, 'M', '2013-08-30', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(133, '?????????', '???', NULL, 'F', '2004-05-12', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(134, '?????????', '???', NULL, 'F', '2002-08-27', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(135, '?????????', '??????', NULL, 'M', '2008-01-14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(136, '??????', '???', NULL, 'M', '2002-06-15', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(137, '?????????', '???', NULL, 'M', '2008-05-10', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(138, '?????????', '??????', NULL, 'M', '2005-12-05', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(139, '??????', '???', NULL, 'F', '2008-06-02', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(140, '??????', '???', NULL, 'F', '2012-06-19', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(141, '?????????', '???', NULL, 'F', '2013-06-21', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(142, '?????????', '??????', NULL, 'M', '2015-08-16', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(143, '?????????', '???', NULL, 'M', '2007-03-22', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(144, '??????', '???', NULL, 'F', '2004-10-26', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(145, '??????', '??????', NULL, 'F', '2007-05-27', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(146, '?????????', '???', NULL, 'F', '2003-11-15', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(147, '?????????', '??????', NULL, 'M', '2012-04-19', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(148, '?????????', '??????', NULL, 'M', '2012-01-27', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(149, '??????', '??????', NULL, 'F', '2003-05-06', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(150, '?????????', '??????', NULL, 'F', '2001-06-07', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(151, '????????????', '??????', NULL, 'M', '2005-09-28', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(152, '??????', '??????', NULL, 'M', '2012-06-25', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(153, '?????????', '??????', NULL, 'F', '2002-07-28', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(154, '?????????', '???', NULL, 'M', '2014-05-23', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(155, '?????????', '???', NULL, 'F', '2002-07-28', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(156, '?????????', '??????', NULL, 'F', '2001-11-12', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(157, '?????????', '??????', NULL, 'F', '2005-01-17', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(158, '?????????', '??????', NULL, 'F', '2001-02-14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(159, '??????', '???', NULL, 'M', '2009-01-13', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(160, '?????????', '???', NULL, 'F', '2015-02-14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(161, '?????????', '??????', NULL, 'F', '2010-12-19', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(162, '?????????', '??????', NULL, 'M', '2012-10-25', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(163, '??????', '???', NULL, 'M', '2002-01-07', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(164, '?????????', '??????', NULL, 'F', '2014-06-24', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(165, '??????', '??????', NULL, 'F', '2005-11-08', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(166, '?????????', '???', NULL, 'F', '2011-05-02', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(167, '??????', '??????', NULL, 'M', '2009-03-12', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(168, '?????????', '??????', NULL, 'M', '2009-10-20', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(169, '?????????', '???', NULL, 'M', '2009-09-12', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(170, '?????????', '??????', NULL, 'F', '2006-11-20', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(171, '?????????', '??????', NULL, 'M', '2015-03-05', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(172, '?????????', '??????', NULL, 'M', '2003-11-22', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(173, '??????', '??????', NULL, 'F', '2004-04-25', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(174, '?????????', '??????', NULL, 'F', '2003-12-07', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(175, '?????????', '???', NULL, 'M', '2005-07-29', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(176, '??????', '??????', NULL, 'F', '2009-05-18', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(177, '?????????', '??????', NULL, 'F', '2007-02-21', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(178, '??????', '??????', NULL, 'F', '2009-11-20', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(179, '??????', '??????', NULL, 'M', '2013-08-10', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(180, '??????', '??????', NULL, 'M', '2003-09-29', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(181, '??????', '???', NULL, 'F', '2004-05-07', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(182, '??????', '??????', NULL, 'M', '2012-05-17', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(183, '?????????', '???', NULL, 'M', '2012-09-30', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(184, '??????', '??????', NULL, 'M', '2013-11-16', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(185, '??????', '??????', NULL, 'M', '2007-04-26', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(186, '??????', '???', NULL, 'M', '2010-01-25', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(187, '??????', '???', NULL, 'M', '2008-05-06', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(188, '?????????', '??????', NULL, 'F', '2007-07-07', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(189, '??????', '???', NULL, 'F', '2014-07-02', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(190, '?????????', '???', NULL, 'F', '2009-05-11', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(191, '?????????', '???', NULL, 'M', '2014-03-22', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(192, '????????????', '??????', NULL, 'M', '2013-06-03', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(193, '????????????', '???', NULL, 'F', '2013-01-09', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(194, '?????????', '??????', NULL, 'F', '2004-05-16', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(195, '?????????', '??????', NULL, 'F', '2000-11-26', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(196, '??????', '??????', NULL, 'M', '2006-07-23', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(197, '?????????', '??????', NULL, 'F', '2013-09-24', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(198, '?????????', '??????', NULL, 'M', '2009-12-12', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(199, '?????????', '???', NULL, 'F', '2013-11-09', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(200, '?????????', '???', NULL, 'F', '2005-01-08', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(201, '?????????', '???', NULL, 'M', '2005-08-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(202, '??????', '??????', NULL, 'M', '2005-05-12', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(203, '??????', '???', NULL, 'F', '2007-12-05', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(204, '?????????', '??????', NULL, 'M', '2007-10-24', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(205, '??????', '???', NULL, 'F', '2006-12-28', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(206, '?????????', '??????', NULL, 'F', '2009-08-24', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(207, '?????????', '??????', NULL, 'M', '2007-05-21', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(208, '?????????', '??????', NULL, 'M', '2001-05-09', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(209, '??????', '???', NULL, 'F', '2005-03-05', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(210, '?????????', '???', NULL, 'M', '2006-06-28', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(211, '??????', '??????', NULL, 'M', '2005-09-27', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(212, '??????', '???', NULL, 'F', '2015-02-23', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(213, '??????', '??????', NULL, 'F', '2002-11-28', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(214, '????????????', '???', NULL, 'F', '2008-09-19', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(215, '?????????', '??????', NULL, 'F', '2014-08-06', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(216, '?????????', '??????', NULL, 'F', '2002-09-02', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(217, '?????????', '???', NULL, 'F', '2009-06-06', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(218, '????????????', '??????', NULL, 'M', '2010-01-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(219, '?????????', '??????', NULL, 'M', '2007-07-06', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(220, '?????????', '???', NULL, 'M', '2008-03-27', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(221, '?????????', '??????', NULL, 'M', '2015-01-08', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(222, '?????????', '???', NULL, 'M', '2001-08-05', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(223, '??????', '??????', NULL, 'M', '2001-10-04', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(224, '??????', '???', NULL, 'M', '2003-10-17', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(225, '????????????', '??????', NULL, 'F', '2012-10-07', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(226, '??????', '??????', NULL, 'M', '2008-01-28', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(227, '??????', '??????', NULL, 'M', '2013-12-16', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(228, '????????????', '???', NULL, 'F', '2005-10-06', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(229, '?????????', '??????', NULL, 'F', '2010-12-18', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(230, '????????????', '??????', NULL, 'M', '2007-10-21', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(231, '??????', '??????', NULL, 'M', '2004-05-17', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(232, '?????????', '???', NULL, 'F', '2013-06-17', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(233, '????????????', '???', NULL, 'M', '2003-01-25', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(234, '?????????', '???', NULL, 'M', '2012-02-08', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(235, '?????????', '???', NULL, 'F', '2006-07-08', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(236, '?????????', '???', NULL, 'M', '2005-12-10', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(237, '??????', '???', NULL, 'M', '2010-03-25', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(238, '??????', '???', NULL, 'M', '2014-01-06', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(239, '?????????', '??????', NULL, 'M', '2005-09-18', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(240, '?????????', '???', NULL, 'F', '2015-05-08', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(241, '?????????', '??????', NULL, 'M', '2012-05-03', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(242, '?????????', '???', NULL, 'M', '2005-01-22', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(243, '??????', '??????', NULL, 'M', '2010-07-24', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(244, '?????????', '??????', NULL, 'F', '2006-05-15', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(245, '??????', '??????', NULL, 'F', '2011-05-20', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(246, '?????????', '???', NULL, 'M', '2003-03-12', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(247, '??????', '??????', NULL, 'M', '2001-01-22', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(248, '??????', '???', NULL, 'M', '2012-04-09', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(249, '??????', '???', NULL, 'F', '2007-01-22', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(250, '??????', '???', NULL, 'M', '2003-10-19', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(251, '??????', '??????', NULL, 'F', '2012-01-07', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(252, '?????????', '??????', NULL, 'M', '2004-09-20', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(253, '?????????', '??????', NULL, 'M', '2015-06-15', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(254, '?????????', '??????', NULL, 'F', '2007-03-03', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(255, '??????', '??????', NULL, 'M', '2012-06-13', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(256, '??????', '??????', NULL, 'F', '2011-10-18', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(257, '??????', '??????', NULL, 'M', '2005-12-18', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(258, '?????????', '??????', NULL, 'M', '2007-10-05', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(259, '?????????', '??????', NULL, 'F', '2010-05-12', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(260, '????????????', '???', NULL, 'M', '2012-08-17', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(261, '??????', '??????', NULL, 'M', '2004-01-20', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(262, '?????????', '???', NULL, 'M', '2007-03-29', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(263, '?????????', '???', NULL, 'M', '2008-10-02', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(264, '?????????', '??????', NULL, 'F', '2014-11-09', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(265, '??????', '??????', NULL, 'M', '2002-03-08', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(266, '?????????', '???', NULL, 'F', '2005-08-02', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(267, '??????', '??????', NULL, 'F', '2012-07-30', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(268, '??????', '???', NULL, 'M', '2012-10-07', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(269, '?????????', '???', NULL, 'M', '2012-12-31', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(270, '??????', '??????', NULL, 'M', '2005-09-22', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26');
INSERT INTO `students` (`id`, `name_zh`, `name_fn`, `name_display`, `gender`, `dob`, `pob`, `start_letter`, `start_grade`, `sic`, `phone`, `dsej_num`, `medical_num`, `entry_date`, `past_school_name`, `religion`, `phone_sms`, `phone_home`, `carer`, `parent`, `garidan`, `liaison`, `created_at`, `updated_at`) VALUES
(271, '?????????', '??????', NULL, 'F', '2001-02-28', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(272, '?????????', '???', NULL, 'M', '2012-08-12', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(273, '?????????', '??????', NULL, 'M', '2012-06-14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(274, '?????????', '???', NULL, 'M', '2003-08-07', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(275, '??????', '??????', NULL, 'M', '2012-11-26', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(276, '?????????', '???', NULL, 'F', '2004-06-20', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(277, '?????????', '??????', NULL, 'M', '2003-11-18', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(278, '?????????', '???', NULL, 'F', '2008-05-29', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(279, '??????', '??????', NULL, 'M', '2015-08-24', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(280, '?????????', '???', NULL, 'F', '2015-05-07', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(281, '?????????', '???', NULL, 'M', '2010-12-24', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(282, '?????????', '??????', NULL, 'F', '2013-08-12', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(283, '?????????', '??????', NULL, 'M', '2005-05-14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(284, '?????????', '???', NULL, 'F', '2004-12-15', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(285, '??????', '??????', NULL, 'F', '2012-02-28', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(286, '?????????', '???', NULL, 'F', '2008-12-16', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(287, '?????????', '???', NULL, 'M', '2010-06-25', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(288, '?????????', '??????', NULL, 'M', '2011-05-19', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(289, '??????', '??????', NULL, 'M', '2004-09-26', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(290, '?????????', '??????', NULL, 'M', '2013-07-03', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(291, '?????????', '??????', NULL, 'M', '2003-05-25', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(292, '??????', '??????', NULL, 'M', '2010-04-10', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(293, '?????????', '???', NULL, 'F', '2007-02-14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(294, '??????', '???', NULL, 'M', '2002-02-16', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(295, '?????????', '???', NULL, 'F', '2007-11-02', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(296, '??????', '??????', NULL, 'M', '2015-01-30', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(297, '????????????', '??????', NULL, 'M', '2001-03-15', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(298, '??????', '???', NULL, 'M', '2009-09-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(299, '?????????', '???', NULL, 'F', '2003-06-30', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(300, '??????', '???', NULL, 'F', '2006-08-23', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(301, '?????????', '??????', NULL, 'F', '2004-07-03', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(302, '??????', '??????', NULL, 'F', '2001-02-15', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(303, '??????', '??????', NULL, 'F', '2002-09-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(304, '??????', '???', NULL, 'M', '2013-06-07', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(305, '?????????', '???', NULL, 'F', '2011-07-04', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(306, '????????????', '??????', NULL, 'M', '2014-04-25', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(307, '??????', '??????', NULL, 'M', '2002-01-03', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(308, '?????????', '???', NULL, 'M', '2008-08-02', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(309, '??????', '??????', NULL, 'F', '2009-08-06', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(310, '??????', '??????', NULL, 'F', '2006-12-23', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(311, '?????????', '??????', NULL, 'F', '2001-09-04', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(312, '??????', '???', NULL, 'M', '2003-05-18', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(313, '?????????', '??????', NULL, 'F', '2015-03-13', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(314, '?????????', '???', NULL, 'M', '2004-07-14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(315, '??????', '??????', NULL, 'M', '2003-01-27', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(316, '?????????', '??????', NULL, 'F', '2011-04-06', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(317, '?????????', '???', NULL, 'F', '2004-03-03', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(318, '??????', '???', NULL, 'F', '2001-06-05', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(319, '??????', '??????', NULL, 'F', '2004-10-26', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(320, '?????????', '??????', NULL, 'M', '2005-01-06', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(321, '??????', '???', NULL, 'M', '2007-09-08', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(322, '??????', '??????', NULL, 'M', '2012-12-11', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(323, '??????', '??????', NULL, 'F', '2014-03-15', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(324, '????????????', '???', NULL, 'M', '2000-09-27', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(325, '??????', '???', NULL, 'F', '2008-04-17', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(326, '??????', '??????', NULL, 'F', '2005-11-26', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(327, '?????????', '??????', NULL, 'F', '2011-08-05', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(328, '?????????', '???', NULL, 'F', '2003-09-11', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(329, '?????????', '??????', NULL, 'M', '2010-04-20', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(330, '?????????', '??????', NULL, 'F', '2006-12-30', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(331, '??????', '???', NULL, 'M', '2003-11-17', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(332, '??????', '???', NULL, 'F', '2010-04-27', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(333, '?????????', '??????', NULL, 'M', '2006-09-07', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(334, '??????', '???', NULL, 'M', '2014-05-24', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(335, '?????????', '???', NULL, 'M', '2012-04-02', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(336, '??????', '??????', NULL, 'M', '2015-04-19', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(337, '?????????', '??????', NULL, 'F', '2013-06-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(338, '?????????', '??????', NULL, 'M', '2008-12-07', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(339, '??????', '???', NULL, 'F', '2007-12-16', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(340, '??????', '??????', NULL, 'F', '2014-09-10', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(341, '?????????', '??????', NULL, 'F', '2013-06-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(342, '??????', '??????', NULL, 'F', '2005-05-10', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(343, '??????', '??????', NULL, 'F', '2015-08-27', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(344, '?????????', '???', NULL, 'M', '2003-04-08', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(345, '??????', '???', NULL, 'M', '2013-09-11', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(346, '??????', '??????', NULL, 'M', '2003-03-11', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(347, '?????????', '???', NULL, 'M', '2005-01-10', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(348, '?????????', '???', NULL, 'M', '2002-01-12', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(349, '?????????', '??????', NULL, 'F', '2012-08-07', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(350, '??????', '???', NULL, 'F', '2008-05-26', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(351, '?????????', '???', NULL, 'F', '2001-06-24', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(352, '??????', '??????', NULL, 'M', '2005-11-22', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(353, '??????', '???', NULL, 'F', '2002-10-20', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(354, '??????', '??????', NULL, 'M', '2015-01-14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(355, '?????????', '??????', NULL, 'M', '2011-09-03', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(356, '?????????', '???', NULL, 'M', '2011-07-03', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(357, '??????', '???', NULL, 'M', '2013-10-05', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(358, '??????', '???', NULL, 'M', '2011-12-25', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(359, '??????', '??????', NULL, 'F', '2001-09-13', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(360, '?????????', '???', NULL, 'M', '2010-02-19', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(361, '??????', '??????', NULL, 'M', '2009-04-27', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(362, '??????', '??????', NULL, 'F', '2003-09-16', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(363, '??????', '??????', NULL, 'F', '2002-07-17', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(364, '?????????', '???', NULL, 'M', '2004-06-23', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(365, '?????????', '??????', NULL, 'M', '2003-08-24', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(366, '?????????', '???', NULL, 'F', '2004-05-30', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(367, '??????', '???', NULL, 'M', '2000-10-14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(368, '??????', '???', NULL, 'M', '2007-02-19', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(369, '?????????', '??????', NULL, 'M', '2013-04-13', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(370, '?????????', '???', NULL, 'F', '2011-11-30', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(371, '?????????', '???', NULL, 'M', '2011-07-15', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(372, '?????????', '??????', NULL, 'F', '2007-08-24', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(373, '??????', '??????', NULL, 'F', '2010-08-03', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(374, '??????', '??????', NULL, 'M', '2005-12-21', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(375, '?????????', '??????', NULL, 'M', '2014-04-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(376, '??????', '???', NULL, 'M', '2002-12-03', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(377, '??????', '???', NULL, 'F', '2011-09-07', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(378, '?????????', '??????', NULL, 'F', '2005-07-31', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(379, '??????', '???', NULL, 'F', '2002-10-05', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(380, '?????????', '???', NULL, 'F', '2007-03-22', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(381, '?????????', '??????', NULL, 'M', '2001-08-26', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(382, '??????', '??????', NULL, 'F', '2002-12-23', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(383, '??????', '???', NULL, 'M', '2002-05-16', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(384, '??????', '???', NULL, 'M', '2007-01-30', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(385, '??????', '??????', NULL, 'M', '2014-04-19', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(386, '?????????', '???', NULL, 'F', '2011-07-20', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(387, '?????????', '???', NULL, 'F', '2015-06-14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(388, '?????????', '??????', NULL, 'M', '2015-07-13', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(389, '?????????', '???', NULL, 'F', '2010-08-21', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(390, '?????????', '???', NULL, 'F', '2007-10-14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(391, '?????????', '???', NULL, 'M', '2003-07-23', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(392, '?????????', '??????', NULL, 'M', '2002-09-04', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(393, '??????', '???', NULL, 'F', '2014-10-04', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(394, '?????????', '??????', NULL, 'F', '2015-03-08', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(395, '?????????', '??????', NULL, 'F', '2003-08-11', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(396, '??????', '??????', NULL, 'F', '2010-06-08', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(397, '????????????', '??????', NULL, 'M', '2008-05-28', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(398, '?????????', '??????', NULL, 'F', '2014-09-26', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(399, '?????????', '???', NULL, 'M', '2010-11-08', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(400, '??????', '???', NULL, 'M', '2012-09-04', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(401, '?????????', '???', NULL, 'M', '2007-07-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(402, '??????', '???', NULL, 'F', '2002-12-03', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(403, '??????', '??????', NULL, 'F', '2007-11-26', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(404, '?????????', '???', NULL, 'M', '2007-10-06', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(405, '?????????', '??????', NULL, 'F', '2006-12-25', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(406, '?????????', '??????', NULL, 'M', '2010-07-05', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(407, '?????????', '??????', NULL, 'F', '2013-11-04', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(408, '??????', '???', NULL, 'F', '2013-01-14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(409, '??????', '???', NULL, 'F', '2012-05-07', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(410, '??????', '??????', NULL, 'F', '2002-11-17', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(411, '?????????', '???', NULL, 'F', '2005-10-27', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(412, '?????????', '??????', NULL, 'F', '2002-11-20', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(413, '??????', '??????', NULL, 'M', '2009-05-15', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(414, '?????????', '??????', NULL, 'F', '2009-03-08', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(415, '?????????', '??????', NULL, 'M', '2004-05-22', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(416, '??????', '???', NULL, 'F', '2009-02-09', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(417, '?????????', '??????', NULL, 'M', '2003-06-29', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(418, '??????', '???', NULL, 'F', '2010-11-13', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(419, '????????????', '???', NULL, 'M', '2006-05-07', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(420, '??????', '???', NULL, 'F', '2014-12-29', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(421, '??????', '???', NULL, 'F', '2003-10-08', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(422, '?????????', '??????', NULL, 'F', '2007-12-06', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(423, '????????????', '???', NULL, 'F', '2005-11-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(424, '??????', '???', NULL, 'F', '2002-11-24', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(425, '?????????', '??????', NULL, 'F', '2009-12-20', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(426, '??????', '???', NULL, 'M', '2010-11-21', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(427, '??????', '??????', NULL, 'M', '2007-02-12', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(428, '??????', '???', NULL, 'M', '2011-02-26', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(429, '????????????', '???', NULL, 'F', '2004-06-22', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(430, '?????????', '???', NULL, 'F', '2002-12-19', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(431, '??????', '???', NULL, 'F', '2008-08-16', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(432, '?????????', '???', NULL, 'M', '2003-06-06', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(433, '?????????', '???', NULL, 'M', '2003-03-10', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(434, '?????????', '???', NULL, 'M', '2001-05-27', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(435, '????????????', '???', NULL, 'M', '2003-02-10', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(436, '??????', '??????', NULL, 'M', '2005-05-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(437, '?????????', '???', NULL, 'M', '2005-04-29', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(438, '????????????', '??????', NULL, 'M', '2014-06-24', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(439, '?????????', '???', NULL, 'F', '2015-02-26', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(440, '?????????', '??????', NULL, 'F', '2014-03-21', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(441, '?????????', '??????', NULL, 'M', '2011-06-16', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(442, '??????', '??????', NULL, 'F', '2012-10-14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(443, '?????????', '??????', NULL, 'M', '2011-08-31', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(444, '?????????', '??????', NULL, 'M', '2012-10-19', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(445, '??????', '??????', NULL, 'M', '2000-11-09', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(446, '??????', '???', NULL, 'M', '2004-11-14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(447, '?????????', '???', NULL, 'M', '2012-01-04', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(448, '?????????', '???', NULL, 'F', '2004-03-06', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(449, '?????????', '???', NULL, 'F', '2013-02-19', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(450, '?????????', '??????', NULL, 'F', '2004-10-12', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(451, '?????????', '???', NULL, 'M', '2007-01-05', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(452, '??????', '???', NULL, 'M', '2009-10-04', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(453, '?????????', '???', NULL, 'M', '2014-01-16', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(454, '?????????', '??????', NULL, 'F', '2009-09-22', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(455, '?????????', '??????', NULL, 'F', '2015-03-23', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(456, '?????????', '???', NULL, 'F', '2007-08-07', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(457, '??????', '??????', NULL, 'F', '2005-03-22', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(458, '????????????', '??????', NULL, 'F', '2014-01-30', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(459, '??????', '???', NULL, 'F', '2001-03-16', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(460, '??????', '??????', NULL, 'F', '2004-07-16', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(461, '??????', '??????', NULL, 'M', '2010-06-14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(462, '?????????', '???', NULL, 'F', '2011-09-04', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(463, '??????', '???', NULL, 'F', '2007-11-03', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(464, '?????????', '???', NULL, 'F', '2012-11-07', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(465, '?????????', '??????', NULL, 'M', '2010-06-19', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(466, '??????', '??????', NULL, 'F', '2001-10-16', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(467, '?????????', '??????', NULL, 'F', '2004-07-02', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(468, '????????????', '???', NULL, 'F', '2003-09-02', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(469, '?????????', '??????', NULL, 'F', '2010-09-21', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(470, '??????', '??????', NULL, 'F', '2004-10-06', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(471, '??????', '???', NULL, 'M', '2001-04-05', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(472, '??????', '???', NULL, 'F', '2007-12-22', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(473, '?????????', '??????', NULL, 'F', '2015-06-19', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(474, '?????????', '??????', NULL, 'F', '2013-08-09', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(475, '?????????', '???', NULL, 'F', '2010-07-21', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(476, '?????????', '??????', NULL, 'M', '2013-10-15', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(477, '?????????', '???', NULL, 'M', '2006-05-18', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(478, '?????????', '???', NULL, 'M', '2008-04-18', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(479, '?????????', '??????', NULL, 'F', '2005-06-19', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(480, '?????????', '???', NULL, 'F', '2000-10-22', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(481, '??????', '??????', NULL, 'M', '2003-09-21', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(482, '?????????', '??????', NULL, 'F', '2001-02-28', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(483, '??????', '???', NULL, 'F', '2002-11-06', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(484, '????????????', '???', NULL, 'F', '2012-08-22', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(485, '??????', '??????', NULL, 'M', '2005-03-11', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(486, '?????????', '??????', NULL, 'F', '2004-03-13', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(487, '?????????', '???', NULL, 'F', '2002-10-16', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(488, '?????????', '???', NULL, 'F', '2009-01-09', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(489, '??????', '???', NULL, 'M', '2005-08-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(490, '????????????', '???', NULL, 'F', '2002-02-18', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(491, '?????????', '???', NULL, 'M', '2002-12-27', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(492, '??????', '??????', NULL, 'M', '2010-01-11', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(493, '?????????', '??????', NULL, 'F', '2011-09-03', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(494, '?????????', '??????', NULL, 'F', '2008-06-16', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(495, '??????', '??????', NULL, 'F', '2009-07-20', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(496, '??????', '??????', NULL, 'M', '2015-01-20', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(497, '?????????', '??????', NULL, 'M', '2010-12-23', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(498, '?????????', '???', NULL, 'M', '2006-09-06', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(499, '?????????', '??????', NULL, 'M', '2008-07-07', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(500, '??????', '??????', NULL, 'F', '2005-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(501, '?????????', '??????', NULL, 'F', '2009-05-02', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(502, '?????????', '??????', NULL, 'F', '2014-12-24', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(503, '?????????', '??????', NULL, 'F', '2005-10-04', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(504, '?????????', '??????', NULL, 'M', '2001-02-26', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(505, '??????', '??????', NULL, 'F', '2004-11-10', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(506, '??????', '???', NULL, 'M', '2010-04-09', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(507, '??????', '??????', NULL, 'M', '2010-07-08', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(508, '?????????', '??????', NULL, 'F', '2001-08-13', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(509, '??????', '??????', NULL, 'F', '2008-04-17', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(510, '??????', '??????', NULL, 'F', '2009-07-29', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(511, '?????????', '???', NULL, 'M', '2013-01-20', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(512, '?????????', '???', NULL, 'M', '2013-01-28', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(513, '??????', '??????', NULL, 'F', '2005-09-15', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(514, '??????', '???', NULL, 'M', '2013-08-25', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(515, '??????', '???', NULL, 'M', '2010-03-05', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(516, '??????', '???', NULL, 'F', '2005-01-02', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(517, '?????????', '???', NULL, 'M', '2008-09-04', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(518, '????????????', '???', NULL, 'F', '2004-07-27', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(519, '??????', '??????', NULL, 'M', '2015-05-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(520, '?????????', '???', NULL, 'F', '2007-03-24', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(521, '?????????', '???', NULL, 'M', '2013-11-15', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(522, '??????', '???', NULL, 'F', '2008-02-23', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(523, '??????', '???', NULL, 'M', '2008-05-13', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(524, '?????????', '??????', NULL, 'F', '2009-01-15', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(525, '??????', '???', NULL, 'F', '2011-08-29', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(526, '?????????', '???', NULL, 'M', '2010-03-20', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(527, '?????????', '??????', NULL, 'M', '2007-10-20', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(528, '?????????', '???', NULL, 'M', '2013-06-22', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(529, '?????????', '??????', NULL, 'F', '2001-07-19', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(530, '????????????', '???', NULL, 'M', '2007-06-02', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(531, '??????', '??????', NULL, 'M', '2011-09-05', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(532, '??????', '??????', NULL, 'M', '2013-02-24', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(533, '????????????', '???', NULL, 'M', '2011-03-23', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(534, '??????', '???', NULL, 'M', '2006-10-13', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(535, '??????', '??????', NULL, 'M', '2005-12-24', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(536, '?????????', '??????', NULL, 'M', '2004-03-03', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(537, '??????', '??????', NULL, 'M', '2012-04-11', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(538, '??????', '???', NULL, 'M', '2004-12-10', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(539, '??????', '??????', NULL, 'F', '2004-02-10', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26');
INSERT INTO `students` (`id`, `name_zh`, `name_fn`, `name_display`, `gender`, `dob`, `pob`, `start_letter`, `start_grade`, `sic`, `phone`, `dsej_num`, `medical_num`, `entry_date`, `past_school_name`, `religion`, `phone_sms`, `phone_home`, `carer`, `parent`, `garidan`, `liaison`, `created_at`, `updated_at`) VALUES
(540, '??????', '???', NULL, 'F', '2006-12-10', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(541, '?????????', '???', NULL, 'M', '2011-11-23', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(542, '??????', '??????', NULL, 'M', '2013-09-16', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(543, '??????', '???', NULL, 'F', '2007-01-28', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(544, '??????', '??????', NULL, 'F', '2013-04-05', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(545, '??????', '??????', NULL, 'F', '2007-10-14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(546, '??????', '???', NULL, 'F', '2006-09-21', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(547, '?????????', '???', NULL, 'M', '2006-10-07', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(548, '?????????', '??????', NULL, 'M', '2000-12-26', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(549, '??????', '???', NULL, 'M', '2012-10-28', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(550, '?????????', '??????', NULL, 'F', '2011-09-20', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(551, '?????????', '???', NULL, 'F', '2004-07-23', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(552, '?????????', '??????', NULL, 'F', '2013-08-29', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(553, '?????????', '??????', NULL, 'F', '2008-12-16', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(554, '?????????', '??????', NULL, 'F', '2014-08-16', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(555, '?????????', '??????', NULL, 'F', '2013-08-18', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(556, '??????', '??????', NULL, 'F', '2012-10-14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(557, '??????', '???', NULL, 'M', '2008-09-20', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(558, '??????', '???', NULL, 'M', '2010-05-04', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(559, '??????', '??????', NULL, 'F', '2015-06-16', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(560, '??????', '??????', NULL, 'M', '2013-05-10', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(561, '??????', '???', NULL, 'F', '2004-04-09', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(562, '?????????', '???', NULL, 'F', '2007-06-25', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(563, '?????????', '??????', NULL, 'M', '2015-07-20', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(564, '??????', '???', NULL, 'M', '2008-03-25', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(565, '?????????', '??????', NULL, 'M', '2010-11-10', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(566, '?????????', '??????', NULL, 'M', '2012-09-07', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(567, '??????', '??????', NULL, 'M', '2015-07-22', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(568, '?????????', '???', NULL, 'M', '2013-11-17', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(569, '??????', '??????', NULL, 'F', '2010-05-08', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(570, '??????', '???', NULL, 'M', '2009-10-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(571, '??????', '???', NULL, 'F', '2013-09-04', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(572, '??????', '??????', NULL, 'F', '2009-08-28', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(573, '????????????', '???', NULL, 'M', '2006-05-15', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(574, '?????????', '??????', NULL, 'M', '2003-01-30', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(575, '?????????', '???', NULL, 'F', '2001-05-02', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(576, '?????????', '??????', NULL, 'M', '2001-01-19', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(577, '??????', '??????', NULL, 'F', '2012-03-11', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(578, '??????', '???', NULL, 'M', '2005-08-30', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(579, '?????????', '???', NULL, 'M', '2012-03-28', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(580, '??????', '??????', NULL, 'M', '2012-07-28', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(581, '??????', '???', NULL, 'M', '2004-02-11', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(582, '????????????', '??????', NULL, 'M', '2008-03-04', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(583, '?????????', '???', NULL, 'M', '2007-05-31', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(584, '??????', '??????', NULL, 'M', '2010-10-28', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(585, '??????', '???', NULL, 'M', '2011-03-30', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(586, '?????????', '???', NULL, 'M', '2009-05-25', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(587, '??????', '???', NULL, 'F', '2011-03-16', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(588, '?????????', '???', NULL, 'F', '2010-10-25', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(589, '????????????', '??????', NULL, 'F', '2010-12-07', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(590, '??????', '??????', NULL, 'M', '2005-02-03', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(591, '????????????', '???', NULL, 'F', '2010-01-04', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(592, '????????????', '???', NULL, 'M', '2009-08-29', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(593, '?????????', '???', NULL, 'M', '2007-03-16', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(594, '??????', '???', NULL, 'M', '2001-01-20', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(595, '????????????', '??????', NULL, 'M', '2002-08-26', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(596, '??????', '???', NULL, 'M', '2004-11-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(597, '?????????', '??????', NULL, 'F', '2007-09-14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(598, '????????????', '???', NULL, 'F', '2009-12-31', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(599, '??????', '???', NULL, 'F', '2007-11-24', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(600, '??????', '??????', NULL, 'M', '2012-10-29', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(601, '?????????', '??????', NULL, 'M', '2013-02-11', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(602, '??????', '??????', NULL, 'M', '2005-04-22', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(603, '?????????', '???', NULL, 'F', '2011-05-03', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(604, '?????????', '???', NULL, 'F', '2011-02-19', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(605, '??????', '???', NULL, 'M', '2008-03-26', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(606, '?????????', '???', NULL, 'M', '2014-11-10', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(607, '??????', '??????', NULL, 'F', '2011-12-11', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(608, '?????????', '??????', NULL, 'F', '2014-08-04', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(609, '??????', '??????', NULL, 'F', '2009-03-17', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(610, '????????????', '??????', NULL, 'F', '2001-05-27', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(611, '?????????', '??????', NULL, 'F', '2006-06-15', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(612, '??????', '???', NULL, 'F', '2009-10-20', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(613, '?????????', '??????', NULL, 'M', '2003-07-06', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(614, '??????', '???', NULL, 'M', '2005-01-31', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(615, '??????', '??????', NULL, 'M', '2006-07-27', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(616, '?????????', '??????', NULL, 'F', '2004-06-06', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(617, '?????????', '???', NULL, 'F', '2008-06-17', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(618, '??????', '???', NULL, 'M', '2007-07-17', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(619, '?????????', '???', NULL, 'F', '2006-01-25', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(620, '?????????', '??????', NULL, 'F', '2005-12-28', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(621, '?????????', '???', NULL, 'M', '2008-03-25', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(622, '??????', '???', NULL, 'M', '2008-01-12', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(623, '?????????', '???', NULL, 'M', '2011-09-09', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(624, '??????', '???', NULL, 'F', '2013-09-29', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(625, '?????????', '??????', NULL, 'M', '2014-04-06', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(626, '??????', '??????', NULL, 'M', '2007-05-21', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(627, '?????????', '???', NULL, 'M', '2010-07-13', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(628, '??????', '???', NULL, 'M', '2003-01-05', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(629, '??????', '???', NULL, 'F', '2011-03-26', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(630, '??????', '??????', NULL, 'F', '2015-02-21', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(631, '??????', '???', NULL, 'M', '2010-02-20', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(632, '?????????', '???', NULL, 'F', '2006-02-06', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(633, '??????', '???', NULL, 'F', '2006-07-18', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(634, '??????', '???', NULL, 'F', '2001-10-14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(635, '?????????', '??????', NULL, 'M', '2014-04-26', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(636, '?????????', '??????', NULL, 'M', '2009-11-20', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(637, '??????', '???', NULL, 'M', '2004-07-07', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(638, '?????????', '??????', NULL, 'M', '2007-05-18', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(639, '??????', '??????', NULL, 'M', '2014-10-21', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(640, '??????', '???', NULL, 'F', '2004-01-21', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(641, '????????????', '???', NULL, 'M', '2012-06-09', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(642, '?????????', '??????', NULL, 'M', '2003-02-10', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(643, '?????????', '???', NULL, 'M', '2003-09-24', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(644, '?????????', '??????', NULL, 'M', '2011-10-30', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(645, '?????????', '???', NULL, 'M', '2003-12-07', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(646, '?????????', '??????', NULL, 'F', '2006-06-27', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(647, '?????????', '??????', NULL, 'M', '2014-09-11', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(648, '?????????', '???', NULL, 'M', '2003-03-07', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(649, '?????????', '???', NULL, 'F', '2013-08-13', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(650, '??????', '??????', NULL, 'F', '2011-03-04', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(651, '??????', '??????', NULL, 'F', '2012-04-28', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(652, '??????', '???', NULL, 'F', '2014-06-19', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(653, '?????????', '???', NULL, 'F', '2006-06-12', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(654, '??????', '??????', NULL, 'M', '2011-02-05', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(655, '?????????', '???', NULL, 'F', '2004-03-04', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(656, '?????????', '???', NULL, 'M', '2008-08-14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(657, '?????????', '??????', NULL, 'F', '2000-10-07', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(658, '??????', '??????', NULL, 'F', '2011-01-09', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(659, '??????', '??????', NULL, 'F', '2002-09-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(660, '?????????', '???', NULL, 'M', '2003-07-22', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(661, '??????', '??????', NULL, 'M', '2002-04-16', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(662, '??????', '???', NULL, 'F', '2009-07-29', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(663, '?????????', '???', NULL, 'M', '2011-02-15', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(664, '??????', '??????', NULL, 'M', '2011-06-21', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(665, '??????', '???', NULL, 'F', '2012-11-30', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(666, '??????', '???', NULL, 'F', '2014-03-29', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(667, '?????????', '??????', NULL, 'F', '2005-03-27', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(668, '?????????', '??????', NULL, 'M', '2003-04-23', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(669, '??????', '???', NULL, 'F', '2006-03-14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(670, '?????????', '???', NULL, 'M', '2002-07-24', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(671, '?????????', '??????', NULL, 'F', '2006-05-25', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(672, '?????????', '???', NULL, 'F', '2013-06-14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(673, '?????????', '??????', NULL, 'M', '2014-04-15', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(674, '?????????', '??????', NULL, 'M', '2013-01-04', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(675, '??????', '??????', NULL, 'F', '2010-06-12', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(676, '?????????', '??????', NULL, 'M', '2010-09-07', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(677, '?????????', '???', NULL, 'F', '2014-02-25', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(678, '?????????', '???', NULL, 'F', '2003-07-23', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(679, '?????????', '??????', NULL, 'M', '2008-09-15', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(680, '?????????', '??????', NULL, 'M', '2003-11-09', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(681, '??????', '??????', NULL, 'F', '2010-02-24', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(682, '??????', '???', NULL, 'F', '2009-11-25', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(683, '?????????', '???', NULL, 'M', '2012-04-13', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(684, '??????', '???', NULL, 'M', '2004-04-04', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(685, '?????????', '??????', NULL, 'F', '2005-11-09', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(686, '????????????', '???', NULL, 'M', '2008-12-24', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(687, '?????????', '???', NULL, 'M', '2011-01-06', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(688, '?????????', '??????', NULL, 'F', '2011-04-26', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(689, '?????????', '??????', NULL, 'F', '2013-07-23', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(690, '?????????', '??????', NULL, 'M', '2002-10-10', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(691, '??????', '??????', NULL, 'F', '2000-10-21', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(692, '?????????', '??????', NULL, 'F', '2006-08-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(693, '?????????', '??????', NULL, 'M', '2010-11-19', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(694, '????????????', '???', NULL, 'M', '2012-03-15', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(695, '?????????', '???', NULL, 'M', '2006-01-10', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(696, '??????', '??????', NULL, 'F', '2006-02-16', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(697, '?????????', '???', NULL, 'F', '2015-01-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(698, '??????', '??????', NULL, 'F', '2001-11-13', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(699, '?????????', '???', NULL, 'F', '2006-05-27', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(700, '??????', '???', NULL, 'M', '2012-09-06', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(701, '??????', '???', NULL, 'M', '2005-12-31', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(702, '??????', '???', NULL, 'M', '2006-01-31', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(703, '?????????', '??????', NULL, 'F', '2010-07-30', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(704, '?????????', '??????', NULL, 'F', '2013-08-18', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(705, '?????????', '???', NULL, 'M', '2005-10-19', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(706, '?????????', '??????', NULL, 'F', '2005-01-30', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(707, '??????', '??????', NULL, 'F', '2012-05-27', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(708, '??????', '???', NULL, 'M', '2001-01-03', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(709, '?????????', '???', NULL, 'F', '2012-10-09', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(710, '?????????', '???', NULL, 'F', '2011-03-19', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(711, '??????', '???', NULL, 'M', '2008-03-18', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(712, '?????????', '???', NULL, 'F', '2007-11-05', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(713, '?????????', '??????', NULL, 'F', '2007-09-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(714, '?????????', '???', NULL, 'F', '2013-03-19', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(715, '??????', '??????', NULL, 'F', '2004-04-02', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(716, '??????', '???', NULL, 'F', '2007-05-03', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(717, '??????', '??????', NULL, 'F', '2014-05-31', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(718, '?????????', '???', NULL, 'M', '2012-10-03', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(719, '?????????', '??????', NULL, 'M', '2001-02-11', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(720, '?????????', '??????', NULL, 'F', '2010-10-24', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(721, '??????', '??????', NULL, 'M', '2003-12-16', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(722, '?????????', '??????', NULL, 'F', '2005-11-22', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(723, '?????????', '??????', NULL, 'F', '2004-06-27', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(724, '?????????', '??????', NULL, 'F', '2012-02-23', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(725, '?????????', '??????', NULL, 'M', '2002-09-25', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(726, '??????', '??????', NULL, 'F', '2004-12-14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(727, '??????', '??????', NULL, 'M', '2012-01-30', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(728, '?????????', '??????', NULL, 'F', '2008-10-10', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(729, '?????????', '???', NULL, 'M', '2009-10-16', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(730, '?????????', '??????', NULL, 'F', '2006-04-08', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(731, '????????????', '??????', NULL, 'F', '2003-12-03', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(732, '?????????', '??????', NULL, 'M', '2009-11-16', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(733, '??????', '???', NULL, 'M', '2004-12-14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(734, '??????', '???', NULL, 'M', '2014-12-20', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(735, '????????????', '???', NULL, 'F', '2006-10-17', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(736, '??????', '???', NULL, 'F', '2010-08-05', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(737, '??????', '??????', NULL, 'F', '2008-06-08', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(738, '?????????', '???', NULL, 'M', '2004-07-11', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(739, '????????????', '???', NULL, 'M', '2013-05-30', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(740, '?????????', '???', NULL, 'M', '2003-10-31', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(741, '?????????', '??????', NULL, 'F', '2013-09-15', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(742, '?????????', '???', NULL, 'F', '2014-11-11', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(743, '??????', '??????', NULL, 'M', '2009-07-20', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(744, '??????', '??????', NULL, 'M', '2003-12-06', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(745, '?????????', '???', NULL, 'M', '2007-04-29', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(746, '?????????', '??????', NULL, 'F', '2008-04-26', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(747, '??????', '???', NULL, 'F', '2009-10-30', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(748, '??????', '???', NULL, 'M', '2002-06-18', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(749, '??????', '??????', NULL, 'F', '2010-11-17', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(750, '?????????', '???', NULL, 'F', '2007-11-10', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(751, '??????', '???', NULL, 'F', '2004-09-25', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(752, '??????', '??????', NULL, 'F', '2006-07-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(753, '?????????', '???', NULL, 'F', '2002-12-15', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(754, '?????????', '??????', NULL, 'F', '2001-10-14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(755, '?????????', '???', NULL, 'M', '2014-11-05', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(756, '??????', '??????', NULL, 'M', '2002-05-30', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(757, '??????', '???', NULL, 'F', '2005-05-03', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(758, '??????', '??????', NULL, 'F', '2001-08-19', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(759, '?????????', '???', NULL, 'F', '2005-02-02', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(760, '?????????', '???', NULL, 'F', '2010-05-06', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(761, '?????????', '??????', NULL, 'F', '2011-09-18', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(762, '??????', '???', NULL, 'M', '2015-03-06', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(763, '??????', '??????', NULL, 'M', '2004-04-22', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(764, '?????????', '???', NULL, 'M', '2010-08-07', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(765, '?????????', '??????', NULL, 'M', '2008-06-08', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(766, '?????????', '??????', NULL, 'M', '2006-07-14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(767, '?????????', '??????', NULL, 'F', '2011-01-29', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(768, '?????????', '???', NULL, 'F', '2000-10-03', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(769, '?????????', '???', NULL, 'F', '2003-10-17', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(770, '??????', '??????', NULL, 'M', '2001-04-14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(771, '?????????', '???', NULL, 'M', '2012-03-24', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(772, '?????????', '??????', NULL, 'F', '2004-02-26', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(773, '?????????', '??????', NULL, 'F', '2010-07-17', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(774, '??????', '???', NULL, 'F', '2012-12-06', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(775, '?????????', '??????', NULL, 'F', '2006-02-03', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(776, '?????????', '??????', NULL, 'M', '2008-12-19', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(777, '?????????', '??????', NULL, 'F', '2001-06-18', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(778, '?????????', '??????', NULL, 'M', '2002-12-27', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(779, '?????????', '???', NULL, 'M', '2010-07-30', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(780, '?????????', '??????', NULL, 'M', '2010-10-19', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(781, '?????????', '???', NULL, 'M', '2001-06-18', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(782, '?????????', '??????', NULL, 'F', '2004-09-14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(783, '?????????', '??????', NULL, 'F', '2006-08-22', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(784, '?????????', '??????', NULL, 'M', '2000-12-30', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(785, '?????????', '??????', NULL, 'F', '2008-02-03', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(786, '??????', '??????', NULL, 'M', '2012-06-28', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(787, '??????', '??????', NULL, 'F', '2000-10-13', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(788, '????????????', '???', NULL, 'F', '2008-09-15', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(789, '?????????', '???', NULL, 'M', '2005-01-20', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(790, '??????', '???', NULL, 'F', '2015-04-07', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(791, '?????????', '???', NULL, 'M', '2012-01-04', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(792, '??????', '???', NULL, 'M', '2008-03-17', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(793, '??????', '??????', NULL, 'F', '2002-01-28', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(794, '??????', '???', NULL, 'F', '2014-12-23', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(795, '??????', '??????', NULL, 'F', '2008-01-14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(796, '??????', '???', NULL, 'M', '2005-10-15', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(797, '??????', '??????', NULL, 'M', '2007-11-18', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(798, '??????', '???', NULL, 'M', '2010-09-22', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(799, '?????????', '???', NULL, 'M', '2014-07-26', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(800, '?????????', '???', NULL, 'M', '2001-02-18', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(801, '??????', '??????', NULL, 'M', '2001-10-02', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(802, '??????', '??????', NULL, 'F', '2008-02-15', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(803, '?????????', '???', NULL, 'M', '2006-03-18', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(804, '??????', '??????', NULL, 'F', '2015-03-29', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(805, '?????????', '???', NULL, 'F', '2002-01-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(806, '??????', '???', NULL, 'M', '2000-11-28', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(807, '?????????', '???', NULL, 'M', '2012-10-08', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(808, '??????', '??????', NULL, 'M', '2015-03-21', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27');
INSERT INTO `students` (`id`, `name_zh`, `name_fn`, `name_display`, `gender`, `dob`, `pob`, `start_letter`, `start_grade`, `sic`, `phone`, `dsej_num`, `medical_num`, `entry_date`, `past_school_name`, `religion`, `phone_sms`, `phone_home`, `carer`, `parent`, `garidan`, `liaison`, `created_at`, `updated_at`) VALUES
(809, '?????????', '???', NULL, 'M', '2008-09-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(810, '?????????', '??????', NULL, 'M', '2002-01-11', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(811, '????????????', '??????', NULL, 'F', '2011-03-03', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(812, '?????????', '??????', NULL, 'M', '2008-11-30', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(813, '??????', '???', NULL, 'F', '2014-03-26', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(814, '?????????', '???', NULL, 'M', '2015-01-25', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(815, '?????????', '???', NULL, 'F', '2012-07-26', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(816, '??????', '??????', NULL, 'M', '2005-10-09', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(817, '?????????', '??????', NULL, 'F', '2007-05-24', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(818, '??????', '??????', NULL, 'M', '2008-12-31', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(819, '??????', '???', NULL, 'F', '2012-03-17', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(820, '??????', '??????', NULL, 'M', '2004-10-04', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(821, '?????????', '??????', NULL, 'M', '2013-01-29', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(822, '??????', '??????', NULL, 'M', '2007-11-14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(823, '??????', '???', NULL, 'M', '2006-09-25', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(824, '??????', '???', NULL, 'M', '2010-11-16', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(825, '??????', '???', NULL, 'F', '2002-01-18', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(826, '?????????', '???', NULL, 'M', '2003-08-21', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(827, '?????????', '??????', NULL, 'M', '2001-11-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(828, '?????????', '??????', NULL, 'M', '2005-08-14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(829, '??????', '???', NULL, 'M', '2008-04-08', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(830, '?????????', '??????', NULL, 'M', '2004-10-30', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(831, '??????', '??????', NULL, 'M', '2014-03-20', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(832, '?????????', '??????', NULL, 'M', '2013-02-23', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(833, '?????????', '???', NULL, 'M', '2004-11-14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(834, '?????????', '???', NULL, 'F', '2011-01-31', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(835, '????????????', '???', NULL, 'M', '2009-06-11', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(836, '?????????', '??????', NULL, 'F', '2005-12-26', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(837, '?????????', '???', NULL, 'F', '2011-08-11', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(838, '??????', '???', NULL, 'M', '2013-05-19', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(839, '??????', '???', NULL, 'F', '2009-04-17', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(840, '?????????', '???', NULL, 'F', '2002-12-14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(841, '??????', '??????', NULL, 'M', '2006-10-27', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(842, '?????????', '??????', NULL, 'F', '2005-05-29', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(843, '??????', '???', NULL, 'F', '2014-11-28', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(844, '?????????', '??????', NULL, 'M', '2003-01-24', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(845, '?????????', '???', NULL, 'F', '2015-06-08', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(846, '??????', '??????', NULL, 'M', '2002-02-12', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(847, '?????????', '??????', NULL, 'F', '2011-08-21', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(848, '??????', '??????', NULL, 'M', '2011-01-14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(849, '?????????', '???', NULL, 'M', '2007-01-17', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(850, '??????', '???', NULL, 'M', '2009-05-03', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(851, '??????', '??????', NULL, 'F', '2004-12-25', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(852, '?????????', '???', NULL, 'M', '2004-02-27', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(853, '??????', '??????', NULL, 'M', '2010-05-14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(854, '?????????', '??????', NULL, 'F', '2013-09-28', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(855, '????????????', '???', NULL, 'F', '2003-03-24', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(856, '?????????', '??????', NULL, 'F', '2009-03-13', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(857, '?????????', '??????', NULL, 'M', '2015-08-18', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(858, '??????', '???', NULL, 'F', '2012-10-22', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(859, '??????', '???', NULL, 'M', '2006-10-17', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(860, '??????', '??????', NULL, 'F', '2002-09-10', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(861, '??????', '??????', NULL, 'M', '2013-07-06', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(862, '?????????', '??????', NULL, 'M', '2013-12-28', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(863, '??????', '??????', NULL, 'M', '2002-05-10', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(864, '?????????', '???', NULL, 'F', '2010-01-02', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(865, '??????', '??????', NULL, 'F', '2003-10-12', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(866, '?????????', '???', NULL, 'F', '2014-07-18', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(867, '?????????', '???', NULL, 'M', '2003-08-21', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(868, '??????', '???', NULL, 'F', '2009-04-24', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(869, '?????????', '??????', NULL, 'M', '2009-09-09', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(870, '?????????', '???', NULL, 'F', '2014-12-22', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(871, '?????????', '???', NULL, 'M', '2013-12-29', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(872, '?????????', '???', NULL, 'M', '2011-01-19', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(873, '????????????', '??????', NULL, 'M', '2012-10-27', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(874, '?????????', '??????', NULL, 'F', '2008-02-06', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(875, '??????', '??????', NULL, 'F', '2001-02-02', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(876, '?????????', '???', NULL, 'F', '2009-09-17', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(877, '?????????', '??????', NULL, 'F', '2012-09-03', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(878, '?????????', '??????', NULL, 'F', '2005-05-27', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(879, '??????', '???', NULL, 'M', '2003-04-23', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(880, '??????', '??????', NULL, 'M', '2005-01-17', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(881, '??????', '??????', NULL, 'F', '2009-05-27', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(882, '??????', '???', NULL, 'M', '2008-02-25', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(883, '??????', '??????', NULL, 'M', '2011-02-18', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(884, '??????', '???', NULL, 'F', '2015-07-08', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(885, '?????????', '??????', NULL, 'F', '2004-08-27', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(886, '?????????', '??????', NULL, 'M', '2015-06-25', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(887, '?????????', '???', NULL, 'M', '2006-10-03', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(888, '?????????', '??????', NULL, 'F', '2001-03-25', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(889, '??????', '???', NULL, 'F', '2001-01-29', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(890, '?????????', '???', NULL, 'F', '2004-05-28', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(891, '?????????', '??????', NULL, 'F', '2013-03-28', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(892, '?????????', '???', NULL, 'F', '2012-01-08', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(893, '??????', '??????', NULL, 'M', '2015-01-06', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(894, '??????', '???', NULL, 'F', '2003-12-20', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(895, '?????????', '???', NULL, 'F', '2015-03-16', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(896, '?????????', '??????', NULL, 'M', '2014-08-26', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(897, '?????????', '??????', NULL, 'M', '2008-04-08', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(898, '??????', '???', NULL, 'M', '2009-09-20', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(899, '?????????', '???', NULL, 'F', '2000-09-06', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(900, '?????????', '???', NULL, 'F', '2008-04-26', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(901, '??????', '???', NULL, 'M', '2003-06-02', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(902, '??????', '???', NULL, 'F', '2002-10-06', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(903, '??????', '???', NULL, 'M', '2004-06-29', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(904, '??????', '???', NULL, 'F', '2008-01-08', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(905, '??????', '???', NULL, 'F', '2002-04-06', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(906, '??????', '??????', NULL, 'F', '2001-07-19', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(907, '?????????', '???', NULL, 'M', '2013-04-02', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(908, '??????', '???', NULL, 'F', '2014-01-06', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(909, '??????', '???', NULL, 'M', '2014-05-20', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(910, '??????', '??????', NULL, 'M', '2002-06-27', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(911, '??????', '???', NULL, 'M', '2008-07-31', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(912, '??????', '??????', NULL, 'M', '2009-02-25', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(913, '?????????', '??????', NULL, 'F', '2002-12-23', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(914, '?????????', '??????', NULL, 'M', '2014-05-31', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(915, '??????', '???', NULL, 'M', '2007-10-22', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(916, '??????', '??????', NULL, 'M', '2005-08-06', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(917, '?????????', '??????', NULL, 'M', '2007-09-30', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(918, '?????????', '???', NULL, 'M', '2013-01-13', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(919, '?????????', '??????', NULL, 'M', '2004-03-11', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(920, '??????', '???', NULL, 'F', '2015-04-04', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(921, '??????', '???', NULL, 'M', '2006-02-17', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(922, '??????', '??????', NULL, 'F', '2004-11-27', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(923, '?????????', '??????', NULL, 'F', '2010-06-10', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(924, '??????', '??????', NULL, 'F', '2001-11-19', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(925, '??????', '??????', NULL, 'F', '2010-09-16', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(926, '??????', '???', NULL, 'M', '2002-11-23', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(927, '?????????', '???', NULL, 'F', '2010-05-18', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(928, '?????????', '???', NULL, 'F', '2007-06-03', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(929, '??????', '??????', NULL, 'F', '2008-12-13', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(930, '?????????', '???', NULL, 'M', '2001-05-23', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(931, '?????????', '???', NULL, 'M', '2009-08-26', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(932, '????????????', '???', NULL, 'F', '2009-04-05', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(933, '?????????', '??????', NULL, 'F', '2012-04-28', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(934, '????????????', '??????', NULL, 'M', '2005-04-26', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(935, '?????????', '??????', NULL, 'M', '2005-07-09', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(936, '????????????', '??????', NULL, 'F', '2001-01-05', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(937, '?????????', '???', NULL, 'F', '2009-05-24', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(938, '?????????', '??????', NULL, 'F', '2015-06-08', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(939, '??????', '??????', NULL, 'M', '2009-03-06', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(940, '?????????', '???', NULL, 'M', '2013-01-27', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(941, '??????', '???', NULL, 'F', '2015-06-27', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(942, '?????????', '??????', NULL, 'F', '2007-05-07', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(943, '??????', '???', NULL, 'F', '2007-04-16', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(944, '?????????', '??????', NULL, 'M', '2000-10-13', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(945, '??????', '???', NULL, 'F', '2002-01-17', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(946, '??????', '??????', NULL, 'M', '2011-08-29', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(947, '??????', '???', NULL, 'M', '2010-04-22', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(948, '??????', '??????', NULL, 'M', '2010-03-14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(949, '?????????', '??????', NULL, 'M', '2001-09-12', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(950, '??????', '???', NULL, 'F', '2008-01-12', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(951, '?????????', '???', NULL, 'M', '2005-08-14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(952, '?????????', '??????', NULL, 'F', '2011-11-23', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(953, '??????', '??????', NULL, 'F', '2010-11-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(954, '?????????', '???', NULL, 'M', '2015-08-07', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(955, '?????????', '???', NULL, 'M', '2013-12-24', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(956, '?????????', '??????', NULL, 'M', '2013-07-26', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(957, '??????', '???', NULL, 'F', '2012-08-22', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(958, '??????', '???', NULL, 'M', '2009-04-23', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(959, '??????', '??????', NULL, 'F', '2003-04-02', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(960, '??????', '??????', NULL, 'F', '2002-09-02', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(961, '??????', '???', NULL, 'M', '2010-03-04', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(962, '??????', '???', NULL, 'M', '2001-03-31', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(963, '??????', '??????', NULL, 'F', '2008-06-15', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(964, '?????????', '??????', NULL, 'M', '2014-05-04', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(965, '?????????', '???', NULL, 'M', '2009-12-19', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(966, '?????????', '???', NULL, 'M', '2000-10-28', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(967, '??????', '???', NULL, 'M', '2011-01-15', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(968, '?????????', '??????', NULL, 'M', '2007-09-20', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(969, '??????', '??????', NULL, 'F', '2011-05-07', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(970, '??????', '??????', NULL, 'F', '2002-09-25', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(971, '??????', '???', NULL, 'F', '2001-07-12', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(972, '?????????', '??????', NULL, 'F', '2012-03-04', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(973, '?????????', '??????', NULL, 'M', '2007-12-07', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(974, '?????????', '??????', NULL, 'F', '2007-03-18', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(975, '??????', '??????', NULL, 'M', '2008-06-02', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(976, '?????????', '???', NULL, 'F', '2003-03-23', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(977, '??????', '??????', NULL, 'M', '2015-01-02', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(978, '??????', '??????', NULL, 'F', '2015-08-24', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(979, '?????????', '??????', NULL, 'F', '2003-10-20', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(980, '????????????', '??????', NULL, 'M', '2013-03-08', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(981, '??????', '???', NULL, 'F', '2006-10-04', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(982, '??????', '???', NULL, 'F', '2015-08-12', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(983, '??????', '??????', NULL, 'M', '2012-12-11', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(984, '?????????', '???', NULL, 'F', '2004-06-02', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(985, '????????????', '??????', NULL, 'M', '2006-10-22', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(986, '??????', '???', NULL, 'F', '2010-07-22', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(987, '??????', '??????', NULL, 'M', '2014-11-09', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(988, '??????', '???', NULL, 'M', '2000-12-26', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(989, '??????', '??????', NULL, 'F', '2013-06-04', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(990, '??????', '???', NULL, 'F', '2006-03-16', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(991, '??????', '???', NULL, 'M', '2010-12-30', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(992, '?????????', '??????', NULL, 'M', '2003-05-19', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(993, '??????', '???', NULL, 'F', '2014-07-02', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(994, '?????????', '???', NULL, 'M', '2015-04-29', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(995, '?????????', '???', NULL, 'M', '2004-12-22', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(996, '?????????', '???', NULL, 'F', '2001-01-11', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(997, '??????', '???', NULL, 'M', '2015-04-22', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(998, '??????', '???', NULL, 'F', '2002-06-11', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(999, '?????????', '??????', NULL, 'F', '2004-07-16', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(1000, '?????????', '??????', NULL, 'F', '2007-08-27', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27');

-- --------------------------------------------------------

--
-- Table structure for table `student_details`
--

CREATE TABLE `student_details` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `student_id` bigint(20) NOT NULL,
  `holy_name` varchar(255) DEFAULT NULL,
  `baptized` date DEFAULT NULL,
  `first_communion` date DEFAULT NULL,
  `past_entry_grade` varchar(255) DEFAULT NULL,
  `past_entry_date` date DEFAULT NULL,
  `past_grade` varchar(255) DEFAULT NULL,
  `valid_stay` date DEFAULT NULL,
  `sibling` int(11) DEFAULT NULL,
  `sibling_at_work` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `student_gardians`
--

CREATE TABLE `student_gardians` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `student_id` bigint(20) NOT NULL,
  `gardian_id` bigint(20) NOT NULL,
  `relation` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `studies`
--

CREATE TABLE `studies` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `version` int(11) NOT NULL,
  `title_zh` varchar(255) NOT NULL,
  `title_en` varchar(255) NOT NULL,
  `stream` varchar(255) NOT NULL,
  `grade` varchar(255) NOT NULL,
  `active` tinyint(1) NOT NULL,
  `description` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `studies`
--

INSERT INTO `studies` (`id`, `version`, `title_zh`, `title_en`, `stream`, `grade`, `active`, `description`, `created_at`, `updated_at`) VALUES
(1, 1, '????????????', '????????????', 'ALL', 'P', 1, NULL, '2023-02-06 01:27:17', '2023-02-06 18:51:32'),
(2, 1, '????????????', '????????????', 'ART', 'S', 1, NULL, '2023-02-06 17:50:56', '2023-02-06 17:50:56'),
(3, 1, '????????????', '????????????', 'ALL', 'S', 1, NULL, '2023-02-06 17:51:20', '2023-02-06 17:51:20');

-- --------------------------------------------------------

--
-- Table structure for table `study_subject`
--

CREATE TABLE `study_subject` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `study_id` bigint(20) NOT NULL,
  `subject_id` bigint(20) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `study_subject`
--

INSERT INTO `study_subject` (`id`, `study_id`, `subject_id`, `created_at`, `updated_at`) VALUES
(1, 1, 1, NULL, NULL),
(2, 1, 2, NULL, NULL),
(3, 1, 3, NULL, NULL),
(4, 1, 4, NULL, NULL),
(5, 1, 5, NULL, NULL),
(6, 1, 6, NULL, NULL),
(7, 1, 7, NULL, NULL),
(8, 1, 8, NULL, NULL),
(9, 1, 9, NULL, NULL),
(10, 1, 10, NULL, NULL),
(11, 1, 11, NULL, NULL),
(12, 1, 12, NULL, NULL),
(13, 1, 13, NULL, NULL),
(14, 1, 14, NULL, NULL),
(15, 1, 15, NULL, NULL),
(16, 1, 16, NULL, NULL),
(17, 1, 17, NULL, NULL),
(18, 1, 18, NULL, NULL),
(19, 1, 19, NULL, NULL),
(20, 1, 20, NULL, NULL),
(21, 1, 21, NULL, NULL),
(22, 1, 22, NULL, NULL),
(23, 1, 23, NULL, NULL),
(24, 1, 24, NULL, NULL),
(25, 1, 25, NULL, NULL),
(26, 1, 26, NULL, NULL),
(27, 1, 27, NULL, NULL),
(28, 1, 28, NULL, NULL),
(29, 1, 29, NULL, NULL),
(30, 1, 30, NULL, NULL),
(31, 1, 31, NULL, NULL),
(32, 1, 32, NULL, NULL),
(33, 1, 33, NULL, NULL),
(34, 1, 34, NULL, NULL),
(35, 1, 35, NULL, NULL),
(36, 1, 36, NULL, NULL),
(37, 1, 37, NULL, NULL),
(38, 1, 38, NULL, NULL),
(39, 1, 39, NULL, NULL),
(40, 1, 40, NULL, NULL),
(41, 2, 1, NULL, NULL),
(42, 2, 2, NULL, NULL),
(43, 2, 3, NULL, NULL),
(44, 2, 4, NULL, NULL),
(45, 2, 5, NULL, NULL),
(46, 2, 6, NULL, NULL),
(47, 2, 7, NULL, NULL),
(48, 2, 8, NULL, NULL),
(49, 2, 9, NULL, NULL),
(50, 2, 10, NULL, NULL),
(51, 2, 11, NULL, NULL),
(52, 2, 12, NULL, NULL),
(53, 2, 13, NULL, NULL),
(54, 2, 14, NULL, NULL),
(55, 2, 15, NULL, NULL),
(56, 2, 16, NULL, NULL),
(57, 2, 17, NULL, NULL),
(58, 2, 18, NULL, NULL),
(59, 2, 19, NULL, NULL),
(60, 2, 20, NULL, NULL),
(61, 2, 21, NULL, NULL),
(62, 2, 22, NULL, NULL),
(63, 2, 23, NULL, NULL),
(64, 2, 24, NULL, NULL),
(65, 2, 25, NULL, NULL),
(66, 2, 26, NULL, NULL),
(67, 2, 27, NULL, NULL),
(68, 2, 28, NULL, NULL),
(69, 2, 29, NULL, NULL),
(70, 2, 30, NULL, NULL),
(71, 2, 31, NULL, NULL),
(72, 2, 32, NULL, NULL),
(73, 2, 33, NULL, NULL),
(74, 2, 34, NULL, NULL),
(75, 2, 35, NULL, NULL),
(76, 2, 36, NULL, NULL),
(77, 2, 37, NULL, NULL),
(78, 2, 38, NULL, NULL),
(79, 2, 39, NULL, NULL),
(80, 2, 40, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `subjects`
--

CREATE TABLE `subjects` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `grade_id` bigint(20) NOT NULL,
  `category` varchar(255) NOT NULL,
  `code` varchar(255) NOT NULL,
  `title_zh` varchar(255) DEFAULT NULL,
  `title_en` varchar(255) DEFAULT NULL,
  `type` varchar(6) DEFAULT NULL,
  `stream` varchar(6) DEFAULT NULL,
  `elective` varchar(6) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `active` tinyint(1) NOT NULL,
  `study_id` bigint(20) DEFAULT NULL,
  `score_column_template` varchar(255) DEFAULT NULL,
  `version` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `subjects`
--

INSERT INTO `subjects` (`id`, `grade_id`, `category`, `code`, `title_zh`, `title_en`, `type`, `stream`, `elective`, `description`, `active`, `study_id`, `score_column_template`, `version`, `created_at`, `updated_at`) VALUES
(1, 1, 'SUBJECT', 'REL', '??????', 'Relegion', 'SUB', 'LIB', '1', NULL, 1, 1, 'TERMS', 1, '2023-02-05 22:37:18', '2023-02-05 22:37:18'),
(2, 1, 'SUBJECT', 'PHY', '??????', 'Physic', 'SUB', 'LIB', '1', NULL, 1, 2, 'TERMS', 1, '2023-02-05 22:37:18', '2023-02-05 22:37:18'),
(3, 1, 'SUBJECT', 'CLT', '??????', 'Chinese Literature', 'SUB', 'LIB', '1', NULL, 1, 3, 'TERMS', 1, '2023-02-05 22:37:18', '2023-02-05 22:37:18'),
(4, 1, 'SUBJECT', 'STY', '??????', 'Stry', 'SUB', 'LIB', '1', NULL, 1, 4, 'TERMS', 1, '2023-02-05 22:37:18', '2023-02-05 22:37:18'),
(5, 1, 'SUBJECT', 'CWR', '??????', 'Chinse_writting', 'SUB', 'LIB', '1', NULL, 1, 5, 'TERMS', 1, '2023-02-05 22:37:18', '2023-02-05 22:37:18'),
(6, 1, 'SUBJECT', 'ELT', '??????', 'English Literature', 'SUB', 'LIB', '1', NULL, 1, 6, 'TERMS', 1, '2023-02-05 22:37:18', '2023-02-05 22:37:18'),
(7, 1, 'SUBJECT', 'EWR', '??????', 'English Writing', 'SUB', 'LIB', '1', NULL, 1, 7, 'TERMS', 1, '2023-02-05 22:37:18', '2023-02-05 22:37:18'),
(8, 1, 'SUBJECT', 'OCS', '??????', 'Ordinary Common Sense', 'SUB', 'LIB', '1', NULL, 1, 8, 'TERMS', 1, '2023-02-05 22:37:18', '2023-02-05 22:37:18'),
(9, 1, 'SUBJECT', 'NUM', '??????', 'Numeracy', 'SUB', 'LIB', '1', NULL, 1, 9, 'TERMS', 1, '2023-02-05 22:37:18', '2023-02-05 22:37:18'),
(10, 1, 'SUBJECT', 'COM', '??????', 'Computer', 'SUB', 'LIB', '1', NULL, 1, 10, 'TERMS', 1, '2023-02-05 22:37:18', '2023-02-05 22:37:18'),
(11, 1, 'SUBJECT', 'PLA', '??????', 'Playgroup', 'SUB', 'LIB', '1', NULL, 1, 11, 'TERMS', 1, '2023-02-05 22:37:18', '2023-02-05 22:37:18'),
(12, 1, 'SUBJECT', 'ART', '??????', 'Art Craft', 'SUB', 'LIB', '1', NULL, 1, 12, 'TERMS', 1, '2023-02-05 22:37:18', '2023-02-05 22:37:18'),
(13, 1, 'ATTITUDE', 'health_1', '????????????????????????', NULL, 'ATT', 'LIB', '1', NULL, 1, 13, 'TERMS', 1, '2023-02-05 22:37:18', '2023-02-05 22:37:18'),
(14, 1, 'ATTITUDE', 'health_2', '????????????', NULL, 'ATT', 'LIB', '1', NULL, 1, 14, 'TERMS', 1, '2023-02-05 22:37:18', '2023-02-05 22:37:18'),
(15, 1, 'ATTITUDE', 'health_3', '???????????????????????????', NULL, 'ATT', 'LIB', '1', NULL, 1, 15, 'TERMS', 1, '2023-02-05 22:37:18', '2023-02-05 22:37:18'),
(16, 1, 'ATTITUDE', 'health_4', '??????????????????????????????', NULL, 'ATT', 'LIB', '1', NULL, 1, 16, 'TERMS', 1, '2023-02-05 22:37:18', '2023-02-05 22:37:18'),
(17, 1, 'ATTITUDE', 'health_5', '??????????????????????????????', NULL, 'ATT', 'LIB', '1', NULL, 1, 17, 'TERMS', 1, '2023-02-05 22:37:18', '2023-02-05 22:37:18'),
(18, 1, 'ATTITUDE', 'behaviour_1', '??????????????????', NULL, 'ATT', 'LIB', '1', NULL, 1, 18, 'TERMS', 1, '2023-02-05 22:37:18', '2023-02-05 22:37:18'),
(19, 1, 'ATTITUDE', 'behaviour_2', '????????????', NULL, 'ATT', 'LIB', '1', NULL, 1, 19, 'TERMS', 1, '2023-02-05 22:37:18', '2023-02-05 22:37:18'),
(20, 1, 'ATTITUDE', 'behaviour_3', '????????????????????????', NULL, 'ATT', 'LIB', '1', NULL, 1, 20, 'TERMS', 1, '2023-02-05 22:37:18', '2023-02-05 22:37:18'),
(21, 1, 'ATTITUDE', 'behaviour_4', '????????????????????????????????????', NULL, 'ATT', 'LIB', '1', NULL, 1, 21, 'TERMS', 1, '2023-02-05 22:37:18', '2023-02-05 22:37:18'),
(22, 1, 'ATTITUDE', 'behaviour_5', '??????????????????????????????', NULL, 'ATT', 'LIB', '1', NULL, 1, 22, 'TERMS', 1, '2023-02-05 22:37:18', '2023-02-05 22:37:18'),
(23, 1, 'ATTITUDE', 'behaviour_6', '????????????', NULL, 'ATT', 'LIB', '1', NULL, 1, 23, 'TERMS', 1, '2023-02-05 22:37:18', '2023-02-05 22:37:18'),
(24, 1, 'ATTITUDE', 'social_1', '??????', NULL, 'ATT', 'LIB', '1', NULL, 1, 24, 'TERMS', 1, '2023-02-05 22:37:18', '2023-02-05 22:37:18'),
(25, 1, 'ATTITUDE', 'social_2', '????????????,????????????', NULL, 'ATT', 'LIB', '1', NULL, 1, 25, 'TERMS', 1, '2023-02-05 22:37:18', '2023-02-05 22:37:18'),
(26, 1, 'ATTITUDE', 'social_3', '????????????', NULL, 'ATT', 'LIB', '1', NULL, 1, 26, 'TERMS', 1, '2023-02-05 22:37:18', '2023-02-05 22:37:18'),
(27, 1, 'ATTITUDE', 'social_4', '???????????????????????????', NULL, 'ATT', 'LIB', '1', NULL, 1, 27, 'TERMS', 1, '2023-02-05 22:37:18', '2023-02-05 22:37:18'),
(28, 1, 'ATTITUDE', 'social_5', '?????????????????????', NULL, 'ATT', 'LIB', '1', NULL, 1, 28, 'TERMS', 1, '2023-02-05 22:37:18', '2023-02-05 22:37:18'),
(29, 1, 'SUMMARY', 'total_score', '??????', NULL, 'SUM', 'LIB', '1', NULL, 1, 29, 'TERMS', 1, '2023-02-05 22:37:18', '2023-02-05 22:37:18'),
(30, 1, 'SUMMARY', 'average_score', '?????????', NULL, 'SUM', 'LIB', '1', NULL, 1, 30, 'TERMS', 1, '2023-02-05 22:37:18', '2023-02-05 22:37:18'),
(31, 1, 'SUMMARY', 'class_size', '????????????', NULL, 'SUM', 'LIB', '1', NULL, 1, 31, 'TERMS', 1, '2023-02-05 22:37:18', '2023-02-05 22:37:18'),
(32, 1, 'SUMMARY', 'ranking', '????????????', NULL, 'SUM', 'LIB', '1', NULL, 1, 32, 'TERMS', 1, '2023-02-05 22:37:18', '2023-02-05 22:37:18'),
(33, 1, 'SUMMARY', 'late', '????????????', NULL, 'SUM', 'LIB', '1', NULL, 1, 33, 'TERMS', 1, '2023-02-05 22:37:18', '2023-02-05 22:37:18'),
(34, 1, 'SUMMARY', 'absent', '????????????', NULL, 'SUM', 'LIB', '1', NULL, 1, 34, 'TERMS', 1, '2023-02-05 22:37:18', '2023-02-05 22:37:18'),
(35, 1, 'GENERAL', 'comment', '??????', NULL, 'GEN', 'LIB', '1', NULL, 1, 35, 'TERMS', 1, '2023-02-05 22:37:18', '2023-02-05 22:37:18'),
(36, 1, 'GENERAL', 'reward_punishment', '????????????', NULL, 'GEN', 'LIB', '1', NULL, 1, 36, 'TERMS', 1, '2023-02-05 22:37:18', '2023-02-05 22:37:18'),
(37, 1, 'GENERAL', 'leisure_name', '??????????????????', NULL, 'GEN', 'LIB', '1', NULL, 1, 37, 'TERMS', 1, '2023-02-05 22:37:18', '2023-02-05 22:37:18'),
(38, 1, 'GENERAL', 'leisure_performance', '??????????????????', NULL, 'GEN', 'LIB', '1', NULL, 1, 38, 'TERMS', 1, '2023-02-05 22:37:18', '2023-02-05 22:37:18'),
(39, 1, 'GENERAL', 'remark', '??????', NULL, 'GEN', 'LIB', '1', NULL, 1, 39, 'COMMENT', 1, '2023-02-05 22:37:18', '2023-02-05 22:37:18'),
(40, 1, 'GENERAL', 'appraisal', '????????????', NULL, 'GEN', 'LIB', '1', NULL, 1, 40, 'COMMENT', 1, '2023-02-05 22:37:18', '2023-02-05 22:37:18');

-- --------------------------------------------------------

--
-- Table structure for table `subject_templates`
--

CREATE TABLE `subject_templates` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `category` varchar(255) DEFAULT NULL,
  `code` varchar(255) NOT NULL,
  `title_zh` varchar(255) DEFAULT NULL,
  `title_en` varchar(255) DEFAULT NULL,
  `type` varchar(6) DEFAULT NULL,
  `stream` varchar(6) DEFAULT NULL,
  `elective` varchar(6) DEFAULT NULL,
  `grades` varchar(255) NOT NULL DEFAULT '[]',
  `description` text DEFAULT NULL,
  `score_template_batch` varchar(255) DEFAULT NULL,
  `version` varchar(255) NOT NULL,
  `active` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `subject_templates`
--

INSERT INTO `subject_templates` (`id`, `category`, `code`, `title_zh`, `title_en`, `type`, `stream`, `elective`, `grades`, `description`, `score_template_batch`, `version`, `active`, `created_at`, `updated_at`) VALUES
(1, 'SUBJECT', 'REL', '??????', 'Relegion', 'SUB', 'AAS', 'COP', '[]', '1', 'SUB', '1', 1, NULL, '2023-02-07 01:41:09'),
(2, 'SUBJECT', 'PHY', '??????', 'Physic', 'SUB', 'LIB', 'COP', '[]', NULL, 'SUB', '1', 1, NULL, '2023-02-05 19:51:50'),
(3, 'SUBJECT', 'CLT', '??????', 'Chinese Literature', 'SUB', 'LIB', 'COP', '[]', NULL, 'SUB', '1', 1, NULL, '2023-02-05 19:52:31'),
(4, 'SUBJECT', 'STY', '??????', 'Stry', 'SUB', 'LIB', 'COP', '[]', NULL, 'SUB', '1', 1, NULL, '2023-02-05 19:52:40'),
(5, 'SUBJECT', 'CWR', '??????', 'Chinse_writting', 'SUB', 'LIB', 'COP', '[]', NULL, 'SUB', '1', 1, NULL, '2023-02-05 19:52:54'),
(6, 'SUBJECT', 'ELT', '??????', 'English Literature', 'SUB', 'LIB', 'COP', '[]', NULL, 'SUB', '1', 1, NULL, '2023-02-05 20:00:40'),
(7, 'SUBJECT', 'EWR', '??????', 'English Writing', 'SUB', 'LIB', 'COP', '[]', NULL, 'SUB', '1', 1, NULL, '2023-02-05 20:00:49'),
(8, 'SUBJECT', 'OCS', '??????', 'Ordinary Common Sense', 'SUB', 'LIB', 'COP', '[]', NULL, 'SUB', '1', 1, NULL, '2023-02-05 20:01:02'),
(9, 'SUBJECT', 'NUM', '??????', 'Numeracy', 'SUB', 'LIB', 'COP', '[]', NULL, 'SUB', '1', 1, NULL, '2023-02-05 20:01:11'),
(10, 'SUBJECT', 'COM', '??????', 'Computer', 'SUB', 'LIB', 'COP', '[]', NULL, 'SUB', '1', 1, NULL, '2023-02-05 20:01:19'),
(11, 'SUBJECT', 'PLA', '??????', 'Playgroup', 'SUB', 'LIB', 'COP', '[]', NULL, 'SUB', '1', 1, NULL, '2023-02-05 20:01:38'),
(12, 'SUBJECT', 'ART', '??????', 'Art Craft', 'SUB', 'LIB', 'COP', '[]', NULL, 'SUB', '1', 1, NULL, '2023-02-05 20:01:50'),
(13, 'ATTITUDE', 'health_1', '????????????????????????', NULL, NULL, NULL, NULL, '[]', NULL, NULL, '1', 1, NULL, NULL),
(14, 'ATTITUDE', 'health_2', '????????????', NULL, NULL, NULL, NULL, '[]', NULL, NULL, '1', 1, NULL, NULL),
(15, 'ATTITUDE', 'health_3', '???????????????????????????', NULL, NULL, NULL, NULL, '[]', NULL, NULL, '1', 1, NULL, NULL),
(16, 'ATTITUDE', 'health_4', '??????????????????????????????', NULL, NULL, NULL, NULL, '[]', NULL, NULL, '1', 1, NULL, NULL),
(17, 'ATTITUDE', 'health_5', '??????????????????????????????', NULL, NULL, NULL, NULL, '[]', NULL, NULL, '1', 1, NULL, NULL),
(18, 'ATTITUDE', 'behaviour_1', '??????????????????', NULL, NULL, NULL, NULL, '[]', NULL, NULL, '1', 1, NULL, NULL),
(19, 'ATTITUDE', 'behaviour_2', '????????????', NULL, NULL, NULL, NULL, '[]', NULL, NULL, '1', 1, NULL, NULL),
(20, 'ATTITUDE', 'behaviour_3', '????????????????????????', NULL, NULL, NULL, NULL, '[]', NULL, NULL, '1', 1, NULL, NULL),
(21, 'ATTITUDE', 'behaviour_4', '????????????????????????????????????', NULL, NULL, NULL, NULL, '[]', NULL, NULL, '1', 1, NULL, NULL),
(22, 'ATTITUDE', 'behaviour_5', '??????????????????????????????', NULL, NULL, NULL, NULL, '[]', NULL, NULL, '1', 1, NULL, NULL),
(23, 'ATTITUDE', 'behaviour_6', '????????????', NULL, NULL, NULL, NULL, '[]', NULL, NULL, '1', 1, NULL, NULL),
(24, 'ATTITUDE', 'social_1', '??????', NULL, NULL, NULL, NULL, '[]', NULL, NULL, '1', 1, NULL, NULL),
(25, 'ATTITUDE', 'social_2', '????????????,????????????', NULL, NULL, NULL, NULL, '[]', NULL, NULL, '1', 1, NULL, NULL),
(26, 'ATTITUDE', 'social_3', '????????????', NULL, NULL, NULL, NULL, '[]', NULL, NULL, '1', 1, NULL, NULL),
(27, 'ATTITUDE', 'social_4', '???????????????????????????', NULL, NULL, NULL, NULL, '[]', NULL, NULL, '1', 1, NULL, NULL),
(28, 'ATTITUDE', 'social_5', '?????????????????????', NULL, NULL, NULL, NULL, '[]', NULL, NULL, '1', 1, NULL, NULL),
(29, 'SUMMARY', 'total_score', '??????', NULL, NULL, NULL, NULL, '[]', NULL, NULL, '1', 1, NULL, NULL),
(30, 'SUMMARY', 'average_score', '?????????', NULL, NULL, NULL, NULL, '[]', NULL, NULL, '1', 1, NULL, NULL),
(31, 'SUMMARY', 'class_size', '????????????', NULL, NULL, NULL, NULL, '[]', NULL, NULL, '1', 1, NULL, NULL),
(32, 'SUMMARY', 'ranking', '????????????', NULL, NULL, NULL, NULL, '[]', NULL, NULL, '1', 1, NULL, NULL),
(33, 'SUMMARY', 'late', '????????????', NULL, NULL, NULL, NULL, '[]', NULL, NULL, '1', 1, NULL, NULL),
(34, 'SUMMARY', 'absent', '????????????', NULL, NULL, NULL, NULL, '[]', NULL, NULL, '1', 1, NULL, NULL),
(35, 'GENERAL', 'comment', '??????', NULL, NULL, NULL, NULL, '[]', NULL, NULL, '1', 1, NULL, NULL),
(36, 'GENERAL', 'reward_punishment', '????????????', NULL, NULL, NULL, NULL, '[]', NULL, NULL, '1', 1, NULL, NULL),
(37, 'GENERAL', 'leisure_name', '??????????????????', NULL, NULL, NULL, NULL, '[]', NULL, NULL, '1', 1, NULL, NULL),
(38, 'GENERAL', 'leisure_performance', '??????????????????', NULL, NULL, NULL, NULL, '[]', NULL, NULL, '1', 1, NULL, NULL),
(39, 'GENERAL', 'remark', '??????', NULL, NULL, NULL, NULL, '[]', NULL, NULL, '1', 1, NULL, NULL),
(40, 'GENERAL', 'appraisal', '????????????', NULL, NULL, NULL, NULL, '[]', NULL, NULL, '1', 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `suppliers`
--

CREATE TABLE `suppliers` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name_zh` varchar(255) NOT NULL,
  `name_en` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `phone` varchar(255) NOT NULL,
  `address` varchar(255) NOT NULL,
  `categories` varchar(255) NOT NULL,
  `registed_date` date NOT NULL,
  `disproved_date` date NOT NULL,
  `remark` text NOT NULL,
  `active` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `teachers`
--

CREATE TABLE `teachers` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `code` varchar(255) DEFAULT NULL,
  `staff_id` bigint(20) NOT NULL,
  `subject_area` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `teachers`
--

INSERT INTO `teachers` (`id`, `code`, `staff_id`, `subject_area`, `created_at`, `updated_at`) VALUES
(1, NULL, 30, NULL, NULL, NULL),
(2, NULL, 31, NULL, NULL, NULL),
(3, NULL, 32, NULL, NULL, NULL),
(4, NULL, 33, NULL, NULL, NULL),
(5, NULL, 34, NULL, NULL, NULL),
(6, NULL, 35, NULL, NULL, NULL),
(7, NULL, 36, NULL, NULL, NULL),
(8, NULL, 37, NULL, NULL, NULL),
(9, NULL, 38, NULL, NULL, NULL),
(10, NULL, 39, NULL, NULL, NULL),
(11, NULL, 40, NULL, NULL, NULL),
(12, NULL, 41, NULL, NULL, NULL),
(13, NULL, 42, NULL, NULL, NULL),
(14, NULL, 43, NULL, NULL, NULL),
(15, NULL, 44, NULL, NULL, NULL),
(16, NULL, 45, NULL, NULL, NULL),
(17, NULL, 46, NULL, NULL, NULL),
(18, NULL, 47, NULL, NULL, NULL),
(19, NULL, 48, NULL, NULL, NULL),
(20, NULL, 49, NULL, NULL, NULL),
(21, NULL, 50, NULL, NULL, NULL),
(22, NULL, 51, NULL, NULL, NULL),
(23, NULL, 52, NULL, NULL, NULL),
(24, NULL, 53, NULL, NULL, NULL),
(25, NULL, 54, NULL, NULL, NULL),
(26, NULL, 55, NULL, NULL, NULL),
(27, NULL, 56, NULL, NULL, NULL),
(28, NULL, 57, NULL, NULL, NULL),
(29, NULL, 58, NULL, NULL, NULL),
(30, NULL, 59, NULL, NULL, NULL),
(31, NULL, 60, NULL, NULL, NULL),
(32, NULL, 61, NULL, NULL, NULL),
(33, NULL, 62, NULL, NULL, NULL),
(34, NULL, 63, NULL, NULL, NULL),
(35, NULL, 64, NULL, NULL, NULL),
(36, NULL, 65, NULL, NULL, NULL),
(37, NULL, 66, NULL, NULL, NULL),
(38, NULL, 67, NULL, NULL, NULL),
(39, NULL, 68, NULL, NULL, NULL),
(40, NULL, 69, NULL, NULL, NULL),
(41, NULL, 70, NULL, NULL, NULL),
(42, NULL, 71, NULL, NULL, NULL),
(43, NULL, 72, NULL, NULL, NULL),
(44, NULL, 73, NULL, NULL, NULL),
(45, NULL, 74, NULL, NULL, NULL),
(46, NULL, 75, NULL, NULL, NULL),
(47, NULL, 76, NULL, NULL, NULL),
(48, NULL, 77, NULL, NULL, NULL),
(49, NULL, 78, NULL, NULL, NULL),
(50, NULL, 79, NULL, NULL, NULL),
(51, NULL, 80, NULL, NULL, NULL),
(52, NULL, 81, NULL, NULL, NULL),
(53, NULL, 82, NULL, NULL, NULL),
(54, NULL, 83, NULL, NULL, NULL),
(55, NULL, 84, NULL, NULL, NULL),
(56, NULL, 85, NULL, NULL, NULL),
(57, NULL, 86, NULL, NULL, NULL),
(58, NULL, 87, NULL, NULL, NULL),
(59, NULL, 88, NULL, NULL, NULL),
(60, NULL, 89, NULL, NULL, NULL),
(61, NULL, 90, NULL, NULL, NULL),
(62, NULL, 91, NULL, NULL, NULL),
(63, NULL, 92, NULL, NULL, NULL),
(64, NULL, 93, NULL, NULL, NULL),
(65, NULL, 94, NULL, NULL, NULL),
(66, NULL, 95, NULL, NULL, NULL),
(67, NULL, 96, NULL, NULL, NULL),
(68, NULL, 97, NULL, NULL, NULL),
(69, NULL, 98, NULL, NULL, NULL),
(70, NULL, 99, NULL, NULL, NULL),
(71, NULL, 100, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `teams`
--

CREATE TABLE `teams` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `personal_team` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `teams`
--

INSERT INTO `teams` (`id`, `user_id`, `name`, `personal_team`, `created_at`, `updated_at`) VALUES
(1, 1, 'Master\'s Team', 1, '2023-02-03 01:27:30', '2023-02-03 01:27:30'),
(2, 2, 'Admin\'s Team', 1, '2023-02-03 01:27:30', '2023-02-03 01:27:30');

-- --------------------------------------------------------

--
-- Table structure for table `team_invitations`
--

CREATE TABLE `team_invitations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `team_id` bigint(20) UNSIGNED NOT NULL,
  `email` varchar(255) NOT NULL,
  `role` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `team_user`
--

CREATE TABLE `team_user` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `team_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `role` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `transcripts`
--

CREATE TABLE `transcripts` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `klass_student_id` bigint(20) NOT NULL,
  `column` enum('PSN','T1','T2','T3','T4','T1E','T1P','T1A','T2E','T2P','T2A','T3E','T3P','T3A','T4E','T4P','T4A','FIN') NOT NULL,
  `category` enum('PERSONAL','SUBJECT','ATTITUDE','SUMMARY','GENERAL') NOT NULL,
  `field_name` varchar(255) NOT NULL,
  `field_value` varchar(255) NOT NULL,
  `version` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `transcripts`
--

INSERT INTO `transcripts` (`id`, `klass_student_id`, `column`, `category`, `field_name`, `field_value`, `version`, `created_at`, `updated_at`) VALUES
(1, 1, 'T1', 'PERSONAL', 'name_ch', 'TEST name_ch', 1, NULL, NULL),
(2, 1, 'T1', 'PERSONAL', 'name_fn', 'TEST name_fn', 1, NULL, NULL),
(3, 1, 'T1', 'PERSONAL', 'academic_year', 'TEST academic_year', 1, NULL, NULL),
(4, 1, 'T1', 'PERSONAL', 'grade_class', 'TEST grade_class', 1, NULL, NULL),
(5, 1, 'T1', 'PERSONAL', 'student_number', 'TEST student_number', 1, NULL, NULL),
(6, 1, 'T1', 'PERSONAL', 'id_number', 'TEST id_number', 1, NULL, NULL),
(7, 1, 'T1', 'PERSONAL', 'issue_date', 'TEST issue_date', 1, NULL, NULL),
(8, 1, 'T1E', 'SUBJECT', 'religion', '55', 1, NULL, NULL),
(9, 1, 'T1E', 'SUBJECT', 'chinese_literature', '80', 1, NULL, NULL),
(10, 1, 'T1E', 'SUBJECT', 'common_sense', '85', 1, NULL, NULL),
(11, 1, 'T1E', 'SUBJECT', 'story', '18', 1, NULL, NULL),
(12, 1, 'T1E', 'SUBJECT', 'chinese_writing', '22', 1, NULL, NULL),
(13, 1, 'T1E', 'SUBJECT', 'numeracy', '74', 1, NULL, NULL),
(14, 1, 'T1E', 'SUBJECT', 'english_reading', '14', 1, NULL, NULL),
(15, 1, 'T1E', 'SUBJECT', 'english_writing', '8', 1, NULL, NULL),
(16, 1, 'T1E', 'SUBJECT', 'computer', '27', 1, NULL, NULL),
(17, 1, 'T1E', 'SUBJECT', 'mandarin', '83', 1, NULL, NULL),
(18, 1, 'T1E', 'SUBJECT', 'art_craft', '7', 1, NULL, NULL),
(19, 1, 'T1E', 'SUBJECT', 'playgroup', '60', 1, NULL, NULL),
(20, 1, 'T1E', 'SUBJECT', 'physical_fitness', '85', 1, NULL, NULL),
(21, 1, 'T1P', 'SUBJECT', 'religion', '33', 1, NULL, NULL),
(22, 1, 'T1P', 'SUBJECT', 'chinese_literature', '26', 1, NULL, NULL),
(23, 1, 'T1P', 'SUBJECT', 'common_sense', '79', 1, NULL, NULL),
(24, 1, 'T1P', 'SUBJECT', 'story', '34', 1, NULL, NULL),
(25, 1, 'T1P', 'SUBJECT', 'chinese_writing', '59', 1, NULL, NULL),
(26, 1, 'T1P', 'SUBJECT', 'numeracy', '54', 1, NULL, NULL),
(27, 1, 'T1P', 'SUBJECT', 'english_reading', '12', 1, NULL, NULL),
(28, 1, 'T1P', 'SUBJECT', 'english_writing', '37', 1, NULL, NULL),
(29, 1, 'T1P', 'SUBJECT', 'computer', '70', 1, NULL, NULL),
(30, 1, 'T1P', 'SUBJECT', 'mandarin', '5', 1, NULL, NULL),
(31, 1, 'T1P', 'SUBJECT', 'art_craft', '92', 1, NULL, NULL),
(32, 1, 'T1P', 'SUBJECT', 'playgroup', '54', 1, NULL, NULL),
(33, 1, 'T1P', 'SUBJECT', 'physical_fitness', '55', 1, NULL, NULL),
(34, 1, 'T1A', 'SUBJECT', 'religion', '10', 1, NULL, NULL),
(35, 1, 'T1A', 'SUBJECT', 'chinese_literature', '22', 1, NULL, NULL),
(36, 1, 'T1A', 'SUBJECT', 'common_sense', '71', 1, NULL, NULL),
(37, 1, 'T1A', 'SUBJECT', 'story', '78', 1, NULL, NULL),
(38, 1, 'T1A', 'SUBJECT', 'chinese_writing', '55', 1, NULL, NULL),
(39, 1, 'T1A', 'SUBJECT', 'numeracy', '71', 1, NULL, NULL),
(40, 1, 'T1A', 'SUBJECT', 'english_reading', '22', 1, NULL, NULL),
(41, 1, 'T1A', 'SUBJECT', 'english_writing', '53', 1, NULL, NULL),
(42, 1, 'T1A', 'SUBJECT', 'computer', '50', 1, NULL, NULL),
(43, 1, 'T1A', 'SUBJECT', 'mandarin', '83', 1, NULL, NULL),
(44, 1, 'T1A', 'SUBJECT', 'art_craft', '26', 1, NULL, NULL),
(45, 1, 'T1A', 'SUBJECT', 'playgroup', '36', 1, NULL, NULL),
(46, 1, 'T1A', 'SUBJECT', 'physical_fitness', '48', 1, NULL, NULL),
(47, 1, 'T2E', 'SUBJECT', 'religion', '36', 1, NULL, NULL),
(48, 1, 'T2E', 'SUBJECT', 'chinese_literature', '92', 1, NULL, NULL),
(49, 1, 'T2E', 'SUBJECT', 'common_sense', '74', 1, NULL, NULL),
(50, 1, 'T2E', 'SUBJECT', 'story', '11', 1, NULL, NULL),
(51, 1, 'T2E', 'SUBJECT', 'chinese_writing', '98', 1, NULL, NULL),
(52, 1, 'T2E', 'SUBJECT', 'numeracy', '67', 1, NULL, NULL),
(53, 1, 'T2E', 'SUBJECT', 'english_reading', '22', 1, NULL, NULL),
(54, 1, 'T2E', 'SUBJECT', 'english_writing', '50', 1, NULL, NULL),
(55, 1, 'T2E', 'SUBJECT', 'computer', '23', 1, NULL, NULL),
(56, 1, 'T2E', 'SUBJECT', 'mandarin', '33', 1, NULL, NULL),
(57, 1, 'T2E', 'SUBJECT', 'art_craft', '17', 1, NULL, NULL),
(58, 1, 'T2E', 'SUBJECT', 'playgroup', '51', 1, NULL, NULL),
(59, 1, 'T2E', 'SUBJECT', 'physical_fitness', '52', 1, NULL, NULL),
(60, 1, 'T2P', 'SUBJECT', 'religion', '86', 1, NULL, NULL),
(61, 1, 'T2P', 'SUBJECT', 'chinese_literature', '80', 1, NULL, NULL),
(62, 1, 'T2P', 'SUBJECT', 'common_sense', '26', 1, NULL, NULL),
(63, 1, 'T2P', 'SUBJECT', 'story', '60', 1, NULL, NULL),
(64, 1, 'T2P', 'SUBJECT', 'chinese_writing', '52', 1, NULL, NULL),
(65, 1, 'T2P', 'SUBJECT', 'numeracy', '18', 1, NULL, NULL),
(66, 1, 'T2P', 'SUBJECT', 'english_reading', '80', 1, NULL, NULL),
(67, 1, 'T2P', 'SUBJECT', 'english_writing', '32', 1, NULL, NULL),
(68, 1, 'T2P', 'SUBJECT', 'computer', '67', 1, NULL, NULL),
(69, 1, 'T2P', 'SUBJECT', 'mandarin', '18', 1, NULL, NULL),
(70, 1, 'T2P', 'SUBJECT', 'art_craft', '85', 1, NULL, NULL),
(71, 1, 'T2P', 'SUBJECT', 'playgroup', '60', 1, NULL, NULL),
(72, 1, 'T2P', 'SUBJECT', 'physical_fitness', '23', 1, NULL, NULL),
(73, 1, 'T2A', 'SUBJECT', 'religion', '7', 1, NULL, NULL),
(74, 1, 'T2A', 'SUBJECT', 'chinese_literature', '34', 1, NULL, NULL),
(75, 1, 'T2A', 'SUBJECT', 'common_sense', '43', 1, NULL, NULL),
(76, 1, 'T2A', 'SUBJECT', 'story', '100', 1, NULL, NULL),
(77, 1, 'T2A', 'SUBJECT', 'chinese_writing', '3', 1, NULL, NULL),
(78, 1, 'T2A', 'SUBJECT', 'numeracy', '18', 1, NULL, NULL),
(79, 1, 'T2A', 'SUBJECT', 'english_reading', '6', 1, NULL, NULL),
(80, 1, 'T2A', 'SUBJECT', 'english_writing', '53', 1, NULL, NULL),
(81, 1, 'T2A', 'SUBJECT', 'computer', '27', 1, NULL, NULL),
(82, 1, 'T2A', 'SUBJECT', 'mandarin', '27', 1, NULL, NULL),
(83, 1, 'T2A', 'SUBJECT', 'art_craft', '54', 1, NULL, NULL),
(84, 1, 'T2A', 'SUBJECT', 'playgroup', '15', 1, NULL, NULL),
(85, 1, 'T2A', 'SUBJECT', 'physical_fitness', '55', 1, NULL, NULL),
(86, 1, 'FIN', 'SUBJECT', 'religion', '73', 1, NULL, NULL),
(87, 1, 'FIN', 'SUBJECT', 'chinese_literature', '67', 1, NULL, NULL),
(88, 1, 'FIN', 'SUBJECT', 'common_sense', '75', 1, NULL, NULL),
(89, 1, 'FIN', 'SUBJECT', 'story', '96', 1, NULL, NULL),
(90, 1, 'FIN', 'SUBJECT', 'chinese_writing', '94', 1, NULL, NULL),
(91, 1, 'FIN', 'SUBJECT', 'numeracy', '73', 1, NULL, NULL),
(92, 1, 'FIN', 'SUBJECT', 'english_reading', '56', 1, NULL, NULL),
(93, 1, 'FIN', 'SUBJECT', 'english_writing', '69', 1, NULL, NULL),
(94, 1, 'FIN', 'SUBJECT', 'computer', '72', 1, NULL, NULL),
(95, 1, 'FIN', 'SUBJECT', 'mandarin', '87', 1, NULL, NULL),
(96, 1, 'FIN', 'SUBJECT', 'art_craft', '81', 1, NULL, NULL),
(97, 1, 'FIN', 'SUBJECT', 'playgroup', '66', 1, NULL, NULL),
(98, 1, 'FIN', 'SUBJECT', 'physical_fitness', '95', 1, NULL, NULL),
(99, 1, 'T1', 'ATTITUDE', 'health_1', 'A', 1, NULL, NULL),
(100, 1, 'T1', 'ATTITUDE', 'health_2', 'A', 1, NULL, NULL),
(101, 1, 'T1', 'ATTITUDE', 'health_3', 'A', 1, NULL, NULL),
(102, 1, 'T1', 'ATTITUDE', 'health_4', 'A', 1, NULL, NULL),
(103, 1, 'T1', 'ATTITUDE', 'health_5', 'A', 1, NULL, NULL),
(104, 1, 'T1', 'ATTITUDE', 'behaviour_1', 'A', 1, NULL, NULL),
(105, 1, 'T1', 'ATTITUDE', 'behaviour_2', 'A', 1, NULL, NULL),
(106, 1, 'T1', 'ATTITUDE', 'behaviour_3', 'A', 1, NULL, NULL),
(107, 1, 'T1', 'ATTITUDE', 'behaviour_4', 'A', 1, NULL, NULL),
(108, 1, 'T1', 'ATTITUDE', 'behaviour_5', 'A', 1, NULL, NULL),
(109, 1, 'T1', 'ATTITUDE', 'behaviour_6', 'A', 1, NULL, NULL),
(110, 1, 'T1', 'ATTITUDE', 'social_1', 'A', 1, NULL, NULL),
(111, 1, 'T1', 'ATTITUDE', 'social_2', 'A', 1, NULL, NULL),
(112, 1, 'T1', 'ATTITUDE', 'social_3', 'A', 1, NULL, NULL),
(113, 1, 'T1', 'ATTITUDE', 'social_4', 'A', 1, NULL, NULL),
(114, 1, 'T1', 'ATTITUDE', 'social_5', 'A', 1, NULL, NULL),
(115, 1, 'T2', 'ATTITUDE', 'health_1', 'B', 1, NULL, NULL),
(116, 1, 'T2', 'ATTITUDE', 'health_2', 'B', 1, NULL, NULL),
(117, 1, 'T2', 'ATTITUDE', 'health_3', 'B', 1, NULL, NULL),
(118, 1, 'T2', 'ATTITUDE', 'health_4', 'B', 1, NULL, NULL),
(119, 1, 'T2', 'ATTITUDE', 'health_5', 'B', 1, NULL, NULL),
(120, 1, 'T2', 'ATTITUDE', 'behaviour_1', 'B', 1, NULL, NULL),
(121, 1, 'T2', 'ATTITUDE', 'behaviour_2', 'B', 1, NULL, NULL),
(122, 1, 'T2', 'ATTITUDE', 'behaviour_3', 'B', 1, NULL, NULL),
(123, 1, 'T2', 'ATTITUDE', 'behaviour_4', 'B', 1, NULL, NULL),
(124, 1, 'T2', 'ATTITUDE', 'behaviour_5', 'B', 1, NULL, NULL),
(125, 1, 'T2', 'ATTITUDE', 'behaviour_6', 'B', 1, NULL, NULL),
(126, 1, 'T2', 'ATTITUDE', 'social_1', 'B', 1, NULL, NULL),
(127, 1, 'T2', 'ATTITUDE', 'social_2', 'B', 1, NULL, NULL),
(128, 1, 'T2', 'ATTITUDE', 'social_3', 'B', 1, NULL, NULL),
(129, 1, 'T2', 'ATTITUDE', 'social_4', 'B', 1, NULL, NULL),
(130, 1, 'T2', 'ATTITUDE', 'social_5', 'B', 1, NULL, NULL),
(131, 1, 'T1', 'SUMMARY', 'total_score', '100', 1, NULL, NULL),
(132, 1, 'T1', 'SUMMARY', 'average_score', '72', 1, NULL, NULL),
(133, 1, 'T1', 'SUMMARY', 'class_size', '87', 1, NULL, NULL),
(134, 1, 'T1', 'SUMMARY', 'ranking', '97', 1, NULL, NULL),
(135, 1, 'T1', 'SUMMARY', 'late', '91', 1, NULL, NULL),
(136, 1, 'T1', 'SUMMARY', 'absent', '4', 1, NULL, NULL),
(137, 1, 'T2', 'SUMMARY', 'total_score', '41', 1, NULL, NULL),
(138, 1, 'T2', 'SUMMARY', 'average_score', '9', 1, NULL, NULL),
(139, 1, 'T2', 'SUMMARY', 'class_size', '14', 1, NULL, NULL),
(140, 1, 'T2', 'SUMMARY', 'ranking', '39', 1, NULL, NULL),
(141, 1, 'T2', 'SUMMARY', 'late', '9', 1, NULL, NULL),
(142, 1, 'T2', 'SUMMARY', 'absent', '71', 1, NULL, NULL),
(143, 1, 'FIN', 'SUMMARY', 'total_score', '24', 1, NULL, NULL),
(144, 1, 'FIN', 'SUMMARY', 'average_score', '95', 1, NULL, NULL),
(145, 1, 'FIN', 'SUMMARY', 'class_size', '48', 1, NULL, NULL),
(146, 1, 'FIN', 'SUMMARY', 'ranking', '100', 1, NULL, NULL),
(147, 1, 'FIN', 'SUMMARY', 'late', '50', 1, NULL, NULL),
(148, 1, 'FIN', 'SUMMARY', 'absent', '96', 1, NULL, NULL),
(149, 1, 'T1', 'GENERAL', 'comment', 'T1 Comment', 1, NULL, NULL),
(150, 1, 'T2', 'GENERAL', 'comment', 'T2 Coment', 1, NULL, NULL),
(151, 1, 'T1', 'GENERAL', 'reward_punishment', 'T1 reward punishment', 1, NULL, NULL),
(152, 1, 'T2', 'GENERAL', 'reward_punishment', 'T2 reward punishment', 1, NULL, NULL),
(153, 1, 'T1', 'GENERAL', 'leisure_name', 'T1 leisure name', 1, NULL, NULL),
(154, 1, 'T2', 'GENERAL', 'leisure_name', 'T2 leisure name', 1, NULL, NULL),
(155, 1, 'T1', 'GENERAL', 'leisure_performance', 'T1 leisure performance', 1, NULL, NULL),
(156, 1, 'T2', 'GENERAL', 'leisure_performance', 'T2 leisure performance', 1, NULL, NULL),
(157, 1, 'T1', 'GENERAL', 'remark', 'T1 remark', 1, NULL, NULL),
(158, 1, 'T2', 'GENERAL', 'remark', 'T2 remark', 1, NULL, NULL),
(159, 1, 'FIN', 'GENERAL', 'remark', 'FIN remark', 1, NULL, NULL),
(160, 1, 'FIN', 'GENERAL', 'appraisal', 'FIN Appraisal', 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `transcript_templates`
--

CREATE TABLE `transcript_templates` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `category` enum('PERSONAL','SUBJECT','ATTITUDE','SUMMARY','GENERAL') NOT NULL,
  `field_name` varchar(255) NOT NULL,
  `title_zh` varchar(255) DEFAULT NULL,
  `title_en` varchar(255) DEFAULT NULL,
  `remark` text DEFAULT NULL,
  `subject_code` varchar(255) NOT NULL,
  `version` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `transcript_templates`
--

INSERT INTO `transcript_templates` (`id`, `category`, `field_name`, `title_zh`, `title_en`, `remark`, `subject_code`, `version`, `created_at`, `updated_at`) VALUES
(1, 'PERSONAL', 'name_ch', '????????????', NULL, NULL, '', 1, NULL, NULL),
(2, 'PERSONAL', 'name_fn', '????????????', NULL, NULL, '', 1, NULL, NULL),
(3, 'PERSONAL', 'academic_year', '??????', NULL, NULL, '', 1, NULL, NULL),
(4, 'PERSONAL', 'grade_class', '??????', NULL, NULL, '', 1, NULL, NULL),
(5, 'PERSONAL', 'student_number', '???????????????', NULL, NULL, '', 1, NULL, NULL),
(6, 'PERSONAL', 'id_number', '???????????????', NULL, NULL, '', 1, NULL, NULL),
(7, 'PERSONAL', 'issue_date', '????????????', NULL, NULL, '', 1, NULL, NULL),
(8, 'SUBJECT', 'religion', '??????', NULL, NULL, '', 1, NULL, NULL),
(9, 'SUBJECT', 'chinese_literature', '??????', NULL, NULL, '', 1, NULL, NULL),
(10, 'SUBJECT', 'common_sense', '??????', NULL, NULL, '', 1, NULL, NULL),
(11, 'SUBJECT', 'story', '??????', NULL, NULL, '', 1, NULL, NULL),
(12, 'SUBJECT', 'chinese_writing', '??????', NULL, NULL, '', 1, NULL, NULL),
(13, 'SUBJECT', 'numeracy', '??????', NULL, NULL, '', 1, NULL, NULL),
(14, 'SUBJECT', 'english_reading', '??????', NULL, NULL, '', 1, NULL, '2023-02-05 20:00:10'),
(15, 'SUBJECT', 'english_writing', '??????', NULL, NULL, '', 1, NULL, NULL),
(16, 'SUBJECT', 'computer', '??????', NULL, NULL, '', 1, NULL, NULL),
(17, 'SUBJECT', 'mandarin', '?????????', NULL, NULL, '', 1, NULL, NULL),
(18, 'SUBJECT', 'art_craft', '??????', NULL, NULL, '', 1, NULL, NULL),
(19, 'SUBJECT', 'playgroup', '??????', NULL, NULL, '', 1, NULL, NULL),
(20, 'SUBJECT', 'physical_fitness', '??????', NULL, NULL, '', 1, NULL, NULL),
(21, 'ATTITUDE', 'health_1', '????????????????????????', NULL, NULL, '', 1, NULL, NULL),
(22, 'ATTITUDE', 'health_2', '????????????', NULL, NULL, '', 1, NULL, NULL),
(23, 'ATTITUDE', 'health_3', '???????????????????????????', NULL, NULL, '', 1, NULL, NULL),
(24, 'ATTITUDE', 'health_4', '??????????????????????????????', NULL, NULL, '', 1, NULL, NULL),
(25, 'ATTITUDE', 'health_5', '??????????????????????????????', NULL, NULL, '', 1, NULL, NULL),
(26, 'ATTITUDE', 'behaviour_1', '??????????????????', NULL, NULL, '', 1, NULL, NULL),
(27, 'ATTITUDE', 'behaviour_2', '????????????', NULL, NULL, '', 1, NULL, NULL),
(28, 'ATTITUDE', 'behaviour_3', '????????????????????????', NULL, NULL, '', 1, NULL, NULL),
(29, 'ATTITUDE', 'behaviour_4', '????????????????????????????????????', NULL, NULL, '', 1, NULL, NULL),
(30, 'ATTITUDE', 'behaviour_5', '??????????????????????????????', NULL, NULL, '', 1, NULL, NULL),
(31, 'ATTITUDE', 'behaviour_6', '????????????', NULL, NULL, '', 1, NULL, NULL),
(32, 'ATTITUDE', 'social_1', '??????', NULL, NULL, '', 1, NULL, NULL),
(33, 'ATTITUDE', 'social_2', '????????????,????????????', NULL, NULL, '', 1, NULL, NULL),
(34, 'ATTITUDE', 'social_3', '????????????', NULL, NULL, '', 1, NULL, NULL),
(35, 'ATTITUDE', 'social_4', '???????????????????????????', NULL, NULL, '', 1, NULL, NULL),
(36, 'ATTITUDE', 'social_5', '?????????????????????', NULL, NULL, '', 1, NULL, NULL),
(37, 'SUMMARY', 'total_score', '??????', NULL, NULL, '', 1, NULL, NULL),
(38, 'SUMMARY', 'average_score', '?????????', NULL, NULL, '', 1, NULL, NULL),
(39, 'SUMMARY', 'class_size', '????????????', NULL, NULL, '', 1, NULL, NULL),
(40, 'SUMMARY', 'ranking', '????????????', NULL, NULL, '', 1, NULL, NULL),
(41, 'SUMMARY', 'late', '????????????', NULL, NULL, '', 1, NULL, NULL),
(42, 'SUMMARY', 'absent', '????????????', NULL, NULL, '', 1, NULL, NULL),
(43, 'GENERAL', 'comment', '??????', NULL, NULL, '', 1, NULL, NULL),
(44, 'GENERAL', 'reward_punishment', '????????????', NULL, NULL, '', 1, NULL, NULL),
(45, 'GENERAL', 'leisure_name', '??????????????????', NULL, NULL, '', 1, NULL, NULL),
(46, 'GENERAL', 'leisure_performance', '??????????????????', NULL, NULL, '', 1, NULL, NULL),
(47, 'GENERAL', 'remark', '??????', NULL, NULL, '', 1, NULL, NULL),
(48, 'GENERAL', 'appraisal', '????????????', NULL, NULL, '', 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `two_factor_secret` text DEFAULT NULL,
  `two_factor_recovery_codes` text DEFAULT NULL,
  `two_factor_confirmed_at` timestamp NULL DEFAULT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `current_team_id` bigint(20) UNSIGNED DEFAULT NULL,
  `profile_photo_path` varchar(2048) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `two_factor_secret`, `two_factor_recovery_codes`, `two_factor_confirmed_at`, `remember_token`, `current_team_id`, `profile_photo_path`, `created_at`, `updated_at`) VALUES
(1, 'Master', 'master@example.com', NULL, '$2y$10$5kcHKzNKE1cwYyavtHbuaumDTUcMtE12SfE8ht7cxEGrftehwkx3q', NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:30', '2023-02-03 01:27:30'),
(2, 'Admin', 'admin@example.com', NULL, '$2y$10$TanPI5vzhD5251Zzokh8w.oGAsVS6KQnJcvqrMhmle2bxzfBPnQbq', NULL, NULL, NULL, NULL, 2, NULL, '2023-02-03 01:27:30', '2023-02-03 01:28:14');

-- --------------------------------------------------------

--
-- Table structure for table `years`
--

CREATE TABLE `years` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `code` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `meta` text DEFAULT NULL,
  `transcript` text DEFAULT NULL,
  `start` date DEFAULT NULL,
  `end` date DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `years`
--

INSERT INTO `years` (`id`, `code`, `title`, `description`, `meta`, `transcript`, `start`, `end`, `active`, `created_at`, `updated_at`) VALUES
(1, '2021', '2021-2022', NULL, NULL, NULL, '2021-09-01', '2022-07-30', 1, NULL, '2023-02-03 01:27:25'),
(2, '2022', '2022-2023', NULL, NULL, NULL, '2022-09-01', '2023-07-30', 0, NULL, NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `addresses`
--
ALTER TABLE `addresses`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `banks`
--
ALTER TABLE `banks`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `behaviours`
--
ALTER TABLE `behaviours`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `behaviours_klass_student_id_term_id_unique` (`klass_student_id`,`term_id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `configs`
--
ALTER TABLE `configs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `configs_key_unique` (`key`);

--
-- Indexes for table `courses`
--
ALTER TABLE `courses`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `course_scores`
--
ALTER TABLE `course_scores`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `course_teachers`
--
ALTER TABLE `course_teachers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `disciplines`
--
ALTER TABLE `disciplines`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `gardians`
--
ALTER TABLE `gardians`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `grades`
--
ALTER TABLE `grades`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `guardians`
--
ALTER TABLE `guardians`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `habits`
--
ALTER TABLE `habits`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `klass_student_id_term_id` (`klass_student_id`,`term_id`);

--
-- Indexes for table `healthcares`
--
ALTER TABLE `healthcares`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `identity_documents`
--
ALTER TABLE `identity_documents`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `klasses`
--
ALTER TABLE `klasses`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `klass_students`
--
ALTER TABLE `klass_students`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `locations`
--
ALTER TABLE `locations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `model_has_permissions`
--
ALTER TABLE `model_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`model_id`,`model_type`),
  ADD KEY `model_has_permissions_model_id_model_type_index` (`model_id`,`model_type`);

--
-- Indexes for table `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD PRIMARY KEY (`role_id`,`model_id`,`model_type`),
  ADD KEY `model_has_roles_model_id_model_type_index` (`model_id`,`model_type`);

--
-- Indexes for table `outcomes`
--
ALTER TABLE `outcomes`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `klass_student_id_term_id` (`klass_student_id`,`terim_id`);

--
-- Indexes for table `parentals`
--
ALTER TABLE `parentals`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indexes for table `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `permissions_name_guard_name_unique` (`name`,`guard_name`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `roles_name_guard_name_unique` (`name`,`guard_name`);

--
-- Indexes for table `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`role_id`),
  ADD KEY `role_has_permissions_role_id_foreign` (`role_id`);

--
-- Indexes for table `scores`
--
ALTER TABLE `scores`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `student_score` (`klass_student_id`,`course_score_id`) USING BTREE;

--
-- Indexes for table `score_columns2`
--
ALTER TABLE `score_columns2`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `score_templates`
--
ALTER TABLE `score_templates`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indexes for table `staff`
--
ALTER TABLE `staff`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `students`
--
ALTER TABLE `students`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `student_details`
--
ALTER TABLE `student_details`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `student_gardians`
--
ALTER TABLE `student_gardians`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `studies`
--
ALTER TABLE `studies`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `study_subject`
--
ALTER TABLE `study_subject`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `subjects`
--
ALTER TABLE `subjects`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `subjects_grade_id_code_unique` (`grade_id`,`code`);

--
-- Indexes for table `subject_templates`
--
ALTER TABLE `subject_templates`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `suppliers`
--
ALTER TABLE `suppliers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `teachers`
--
ALTER TABLE `teachers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `teams`
--
ALTER TABLE `teams`
  ADD PRIMARY KEY (`id`),
  ADD KEY `teams_user_id_index` (`user_id`);

--
-- Indexes for table `team_invitations`
--
ALTER TABLE `team_invitations`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `team_invitations_team_id_email_unique` (`team_id`,`email`);

--
-- Indexes for table `team_user`
--
ALTER TABLE `team_user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `team_user_team_id_user_id_unique` (`team_id`,`user_id`);

--
-- Indexes for table `transcripts`
--
ALTER TABLE `transcripts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `transcript_templates`
--
ALTER TABLE `transcript_templates`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- Indexes for table `years`
--
ALTER TABLE `years`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `years_code_unique` (`code`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `addresses`
--
ALTER TABLE `addresses`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `banks`
--
ALTER TABLE `banks`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `behaviours`
--
ALTER TABLE `behaviours`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `configs`
--
ALTER TABLE `configs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `courses`
--
ALTER TABLE `courses`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=381;

--
-- AUTO_INCREMENT for table `course_scores`
--
ALTER TABLE `course_scores`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=333;

--
-- AUTO_INCREMENT for table `course_teachers`
--
ALTER TABLE `course_teachers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `disciplines`
--
ALTER TABLE `disciplines`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `gardians`
--
ALTER TABLE `gardians`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `grades`
--
ALTER TABLE `grades`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `guardians`
--
ALTER TABLE `guardians`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `habits`
--
ALTER TABLE `habits`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `healthcares`
--
ALTER TABLE `healthcares`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `identity_documents`
--
ALTER TABLE `identity_documents`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `klasses`
--
ALTER TABLE `klasses`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=75;

--
-- AUTO_INCREMENT for table `klass_students`
--
ALTER TABLE `klass_students`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1261;

--
-- AUTO_INCREMENT for table `locations`
--
ALTER TABLE `locations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=48;

--
-- AUTO_INCREMENT for table `outcomes`
--
ALTER TABLE `outcomes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `parentals`
--
ALTER TABLE `parentals`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `scores`
--
ALTER TABLE `scores`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=394;

--
-- AUTO_INCREMENT for table `score_columns2`
--
ALTER TABLE `score_columns2`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=333;

--
-- AUTO_INCREMENT for table `score_templates`
--
ALTER TABLE `score_templates`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT for table `staff`
--
ALTER TABLE `staff`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=101;

--
-- AUTO_INCREMENT for table `students`
--
ALTER TABLE `students`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1001;

--
-- AUTO_INCREMENT for table `student_details`
--
ALTER TABLE `student_details`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `student_gardians`
--
ALTER TABLE `student_gardians`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `studies`
--
ALTER TABLE `studies`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `study_subject`
--
ALTER TABLE `study_subject`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=81;

--
-- AUTO_INCREMENT for table `subjects`
--
ALTER TABLE `subjects`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT for table `subject_templates`
--
ALTER TABLE `subject_templates`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT for table `suppliers`
--
ALTER TABLE `suppliers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `teachers`
--
ALTER TABLE `teachers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=72;

--
-- AUTO_INCREMENT for table `teams`
--
ALTER TABLE `teams`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `team_invitations`
--
ALTER TABLE `team_invitations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `team_user`
--
ALTER TABLE `team_user`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `transcripts`
--
ALTER TABLE `transcripts`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=161;

--
-- AUTO_INCREMENT for table `transcript_templates`
--
ALTER TABLE `transcript_templates`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `years`
--
ALTER TABLE `years`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `model_has_permissions`
--
ALTER TABLE `model_has_permissions`
  ADD CONSTRAINT `model_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD CONSTRAINT `model_has_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD CONSTRAINT `role_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `role_has_permissions_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `team_invitations`
--
ALTER TABLE `team_invitations`
  ADD CONSTRAINT `team_invitations_team_id_foreign` FOREIGN KEY (`team_id`) REFERENCES `teams` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
