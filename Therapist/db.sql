-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- 主机： 127.0.0.1
-- 生成日期： 2024-10-11 03:27:41
-- 服务器版本： 10.4.32-MariaDB
-- PHP 版本： 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- 数据库： `care`
--

Drop DATABASE IF EXISTS care;
Create DATABASE care;

use care;

-- --------------------------------------------------------

--
-- 表的结构 `appointments`
--

CREATE TABLE `appointments` (
  `id` int(11) NOT NULL,
  `therapist_id` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `appointment_date` datetime NOT NULL,
  `duration_minutes` int(11) DEFAULT 60,
  `appointment_type` enum('Consultation','Follow-up','Therapy Session') DEFAULT 'Consultation',
  `location` varchar(255) DEFAULT NULL,
  `status` enum('Scheduled','Completed','Cancelled') DEFAULT 'Scheduled',
  `notes` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- 转存表中的数据 `appointments`
--

INSERT INTO `appointments` (`id`, `therapist_id`, `patient_id`, `appointment_date`, `duration_minutes`, `appointment_type`, `location`, `status`, `notes`) VALUES
(1, 1, 1, '2024-10-09 10:00:00', 60, 'Consultation', 'Room 101', 'Scheduled', 'Initial consultation.'),
(2, 2, 2, '2023-08-20 14:00:00', 45, 'Therapy Session', 'Room 202', 'Completed', 'Follow-up therapy session.'),
(3, 3, 3, '2023-09-25 09:30:00', 30, 'Consultation', 'Room 303', 'Scheduled', 'Neurological assessment.'),
(4, 4, 4, '2023-10-01 11:00:00', 60, 'Follow-up', 'Room 404', 'Cancelled', 'Appointment cancelled by patient.'),
(5, 5, 5, '2023-11-05 15:00:00', 90, 'Therapy Session', 'Room 505', 'Scheduled', 'Extended therapy session.');

-- --------------------------------------------------------

--
-- 表的结构 `auditors`
--

CREATE TABLE `auditors` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `phone_number` varchar(20) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `audit_privileges` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`audit_privileges`)),
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `photo` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- 转存表中的数据 `auditors`
--

INSERT INTO `auditors` (`id`, `name`, `email`, `phone_number`, `password`, `audit_privileges`, `created_at`, `updated_at`, `photo`) VALUES
(1, 'Auditor 1', 'auditor1@care.com', '1112223333', '29618d60acd075fc93cac898b8e4a1231e97aaabcb851566756b171448f92ef5', '{\"case_types\": \"All\", \"consultation_lengths\": \"View Only\"}', '2024-10-04 22:45:24', '2024-10-11 01:26:51', NULL),
(2, 'Auditor 2', 'auditor2@care.com', '4445556666', '897dab869ad1e41e0e1edf518e1a6c5aba0aa5487af0f8e9e3fe490c3914fcea', '{\"case_types\": \"Pediatrics\", \"consultation_lengths\": \"View and Edit\"}', '2024-10-04 22:45:24', '2024-10-07 19:38:25', NULL),
(3, 'Auditor 3', 'auditor3@care.com', '7778889999', '3de7d8db5f60e954a1b833556da9e8d91c9d6a8bd661cb2628f85683dcf5cf46', '{\"case_types\": \"Neurology\", \"consultation_lengths\": \"View Only\"}', '2024-10-04 22:45:24', '2024-10-07 19:38:25', NULL),
(4, 'Auditor 4', 'auditor4@care.com', '1231231234', 'cd3a8236cf30b7037474f1e66a0eaf9d2e6d6f4528023acd0be8cd067d36ffca', '{\"case_types\": \"General Medicine\", \"consultation_lengths\": \"View and Edit\"}', '2024-10-04 22:45:24', '2024-10-07 19:38:25', NULL),
(5, 'Auditor 5', 'auditor5@care.com', '3213214321', '229ba5afdba30ae51ae61019a40a1750a463de0b727dfe42cc0124d0d33b0975', '{\"case_types\": \"Dermatology\", \"consultation_lengths\": \"View Only\"}', '2024-10-04 22:45:24', '2024-10-07 19:38:25', NULL);

-- --------------------------------------------------------

--
-- 表的结构 `certification`
--

CREATE TABLE `certification` (
  `id` int(11) NOT NULL,
  `therapist_id` int(11) NOT NULL,
  `cert_type` varchar(255) NOT NULL,
  `path` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- 表的结构 `groupmeetings`
--

CREATE TABLE `groupmeetings` (
  `id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  `theme` varchar(255) NOT NULL,
  `meeting_date` date NOT NULL,
  `meeting_time` time NOT NULL,
  `mode` enum('Online','In-Clinic') DEFAULT 'Online',
  `notification` varchar(255) DEFAULT NULL,
  `reminder` enum('On','Off') DEFAULT 'On',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- 转存表中的数据 `groupmeetings`
--

INSERT INTO `groupmeetings` (`id`, `group_id`, `theme`, `meeting_date`, `meeting_time`, `mode`, `notification`, `reminder`, `created_at`, `updated_at`) VALUES
(1, 1, 'Psychological Counseling', '2024-10-01', '09:00:00', 'Online', 'Reminder for counseling', 'On', '2024-10-08 06:30:47', '2024-10-08 06:30:47'),
(2, 1, 'Stress Management', '2024-10-02', '10:00:00', 'In-Clinic', 'Focus on breathing exercises', 'On', '2024-10-08 06:30:47', '2024-10-08 06:30:47'),
(3, 1, 'Anxiety Management', '2024-10-03', '11:00:00', 'Online', 'Discussion on coping strategies', 'Off', '2024-10-08 06:30:47', '2024-10-08 06:30:47'),
(4, 1, 'Anger Management', '2024-10-04', '12:30:00', 'Online', 'Techniques to handle anger', 'On', '2024-10-08 06:30:47', '2024-10-08 06:30:47'),
(5, 1, 'Grief Counseling', '2024-10-05', '14:00:00', 'In-Clinic', 'Dealing with loss', 'Off', '2024-10-08 06:30:47', '2024-10-08 06:30:47'),
(6, 1, 'Family Therapy', '2024-10-06', '15:00:00', 'Online', 'Reminder for family support', 'On', '2024-10-08 06:30:47', '2024-10-08 06:30:47'),
(7, 1, 'Depression Recovery', '2024-10-07', '16:00:00', 'In-Clinic', 'Coping with depression', 'On', '2024-10-08 06:30:47', '2024-10-08 06:30:47'),
(8, 1, 'Addiction Support', '2024-10-08', '17:30:00', 'Online', 'Dealing with addiction', 'Off', '2024-10-08 06:30:47', '2024-10-08 06:30:47'),
(9, 1, 'Cognitive Behavioral Therapy', '2024-10-09', '09:30:00', 'Online', 'Behavioral techniques', 'On', '2024-10-08 06:30:47', '2024-10-08 06:30:47'),
(10, 1, 'Post-Traumatic Stress', '2024-10-10', '10:30:00', 'In-Clinic', 'Managing PTSD', 'Off', '2024-10-08 06:30:47', '2024-10-08 06:30:47'),
(11, 1, 'Eating Disorder Support', '2024-10-11', '11:30:00', 'Online', 'Body image recovery', 'On', '2024-10-08 06:30:47', '2024-10-08 06:30:47'),
(12, 1, 'Meditation Techniques', '2024-10-12', '12:00:00', 'In-Clinic', 'Focus on mindfulness', 'On', '2024-10-08 06:30:47', '2024-10-08 06:30:47'),
(13, 1, 'Crisis Counseling', '2024-10-13', '13:00:00', 'Online', 'Dealing with crisis', 'Off', '2024-10-08 06:30:47', '2024-10-08 06:30:47'),
(14, 1, 'Mindfulness Training', '2024-10-14', '14:30:00', 'Online', 'Focus on mindfulness', 'On', '2024-10-08 06:30:47', '2024-10-08 06:30:47'),
(15, 1, 'Trauma Therapy', '2024-10-15', '16:30:00', 'In-Clinic', 'Recovery from trauma', 'Off', '2024-10-08 06:30:47', '2024-10-08 06:30:47'),
(16, 1, 'Stress Relief', '2024-10-16', '09:00:00', 'Online', 'Relaxation techniques', 'On', '2024-10-08 06:30:47', '2024-10-08 06:30:47'),
(17, 1, 'Support Group for Teens', '2024-10-17', '10:00:00', 'In-Clinic', 'Teen support', 'On', '2024-10-08 06:30:47', '2024-10-08 06:30:47'),
(18, 1, 'Support Group for Seniors', '2024-10-18', '11:00:00', 'Online', 'Elder care support', 'Off', '2024-10-08 06:30:47', '2024-10-08 06:30:47'),
(19, 1, 'Anxiety Reduction', '2024-10-19', '12:30:00', 'Online', 'Managing anxiety', 'On', '2024-10-08 06:30:47', '2024-10-08 06:30:47'),
(20, 1, 'Career Counseling', '2024-10-20', '14:00:00', 'In-Clinic', 'Career advice', 'Off', '2024-10-08 06:30:47', '2024-10-08 06:30:47'),
(21, 1, 'Family Dynamics', '2024-10-21', '15:00:00', 'Online', 'Family relationship building', 'On', '2024-10-08 06:30:47', '2024-10-08 06:30:47'),
(22, 1, 'Overcoming Loneliness', '2024-10-22', '16:00:00', 'In-Clinic', 'Social interaction techniques', 'On', '2024-10-08 06:30:47', '2024-10-08 06:30:47'),
(23, 1, 'Public Speaking Anxiety', '2024-10-23', '17:30:00', 'Online', 'Handling speaking anxiety', 'Off', '2024-10-08 06:30:47', '2024-10-08 06:30:47'),
(24, 1, 'Communication Skills', '2024-10-24', '09:30:00', 'Online', 'Improving communication', 'On', '2024-10-08 06:30:47', '2024-10-08 06:30:47'),
(25, 1, 'Positive Thinking', '2024-10-25', '10:30:00', 'In-Clinic', 'Developing a positive mindset', 'Off', '2024-10-08 06:30:47', '2024-10-08 06:30:47'),
(26, 1, 'Motivation Boost', '2024-10-26', '11:30:00', 'Online', 'Inspiration and motivation', 'On', '2024-10-08 06:30:47', '2024-10-08 06:30:47'),
(27, 1, 'Breaking Bad Habits', '2024-10-27', '12:00:00', 'In-Clinic', 'Techniques for habit change', 'On', '2024-10-08 06:30:47', '2024-10-08 06:30:47'),
(28, 1, 'Building Self-Esteem', '2024-10-28', '13:00:00', 'Online', 'Boosting self-esteem', 'Off', '2024-10-08 06:30:47', '2024-10-08 06:30:47'),
(29, 1, 'Conflict Resolution', '2024-10-29', '14:30:00', 'Online', 'Managing conflict', 'On', '2024-10-08 06:30:47', '2024-10-08 06:30:47'),
(30, 1, 'Sleep Hygiene', '2024-10-30', '16:30:00', 'In-Clinic', 'Improving sleep quality', 'Off', '2024-10-08 06:30:47', '2024-10-08 06:30:47'),
(31, 1, 'Work-Life Balance', '2024-10-31', '09:00:00', 'Online', 'Balancing work and life', 'On', '2024-10-08 06:30:47', '2024-10-08 06:30:47'),
(32, 1, '123', '2024-10-01', '00:00:00', 'Online', '', 'On', '2024-10-08 11:09:03', '2024-10-08 11:09:03'),
(33, 1, 'test meeting ', '0000-00-00', '00:00:00', 'In-Clinic', 'test', 'On', '2024-10-08 11:10:10', '2024-10-08 11:10:10'),
(34, 1, '123', '2024-10-09', '21:42:00', 'Online', '', 'On', '2024-10-08 11:12:45', '2024-10-08 11:12:45'),
(35, 21, 'test meeting', '2024-10-10', '10:06:00', 'In-Clinic', 'test notification', 'On', '2024-10-08 11:35:30', '2024-10-08 11:35:30'),
(36, 1, '3', '2024-10-10', '01:13:00', 'Online', '1', 'On', '2024-10-09 02:41:04', '2024-10-09 02:41:04');

-- --------------------------------------------------------

--
-- 表的结构 `groupnotes`
--

CREATE TABLE `groupnotes` (
  `note_id` int(11) NOT NULL,
  `group_id` int(11) DEFAULT NULL,
  `note_date` date DEFAULT NULL,
  `note_text` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- 转存表中的数据 `groupnotes`
--

INSERT INTO `groupnotes` (`note_id`, `group_id`, `note_date`, `note_text`) VALUES
(1, 1, '2024-09-09', 'Discussion about managing panic attacks.'),
(2, 1, '2024-09-10', 'Introduced breathing exercises.'),
(3, 1, '2024-09-11', 'Shared personal experiences.'),
(4, 2, '2024-09-12', 'Focus on time management techniques.'),
(5, 2, '2024-09-13', 'Mindfulness meditation session.'),
(6, 2, '2024-09-14', 'Reviewed stress relief progress.'),
(7, 3, '2024-09-15', 'Guided mindfulness session.'),
(8, 3, '2024-09-16', 'Participants shared relaxation techniques.'),
(9, 3, '2024-09-17', 'Daily mindfulness practice was encouraged.'),
(10, 4, '2024-09-18', 'Focused on improving mood through positive activities.'),
(11, 4, '2024-09-19', 'Discussed sleep hygiene.'),
(12, 4, '2024-09-20', 'Provided resources for dealing with depressive episodes.'),
(13, 5, '2024-09-21', 'Taught participants how to handle triggers.'),
(14, 5, '2024-09-22', 'Role-playing for managing confrontations.'),
(15, 5, '2024-09-23', 'Participants practiced calming techniques.'),
(16, 6, '2024-09-24', 'Shared stories of loss and coping strategies.'),
(17, 6, '2024-09-25', 'Discussion on dealing with anniversaries of loss.'),
(18, 6, '2024-09-26', 'Focused on rebuilding life after grief.'),
(19, 7, '2024-09-27', 'Worked on positive affirmations.'),
(20, 7, '2024-09-28', 'Discussed self-worth and personal achievements.'),
(21, 7, '2024-09-29', 'Encouraged participants to identify their strengths.'),
(22, 8, '2024-09-30', 'Participants practiced thought restructuring techniques.'),
(23, 8, '2024-10-01', 'Reviewed cognitive distortions.'),
(24, 8, '2024-10-02', 'Focused on challenging negative thoughts.'),
(25, 9, '2024-10-03', 'Group shared experiences with relapse prevention.'),
(26, 9, '2024-10-04', 'Discussed coping strategies for cravings.'),
(27, 9, '2024-10-05', 'Provided resources for addiction recovery.'),
(28, 10, '2024-10-06', 'Taught emotional awareness techniques.'),
(29, 10, '2024-10-07', 'Participants practiced self-regulation strategies.'),
(30, 10, '2024-10-08', 'Reviewed emotional regulation progress.'),
(31, 1, '2024-10-08', 'test note for group 1'),
(32, 1, '2024-10-09', '1');

-- --------------------------------------------------------

--
-- 表的结构 `grouppatient`
--

CREATE TABLE `grouppatient` (
  `group_id` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- 转存表中的数据 `grouppatient`
--

INSERT INTO `grouppatient` (`group_id`, `patient_id`) VALUES
(1, 1),
(1, 2),
(1, 5),
(2, 104),
(2, 105),
(2, 106),
(3, 107),
(3, 108),
(3, 109),
(4, 110),
(4, 111),
(4, 112),
(5, 113),
(5, 114),
(5, 115);

-- --------------------------------------------------------

--
-- 表的结构 `groups`
--

CREATE TABLE `groups` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `leader` varchar(255) NOT NULL,
  `number_of_members` int(11) NOT NULL,
  `assigned_patients` int(11) DEFAULT NULL,
  `creation_date` date NOT NULL,
  `status` enum('Active','Inactive','Disbanded','Recruiting') DEFAULT 'Active',
  `head_img` varchar(255) DEFAULT NULL,
  `therapist_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- 转存表中的数据 `groups`
--

INSERT INTO `groups` (`id`, `name`, `leader`, `number_of_members`, `assigned_patients`, `creation_date`, `status`, `head_img`, `therapist_id`, `created_at`, `updated_at`) VALUES
(1, 'Mindful Masters', '101', 12, 5, '2023-01-15', 'Active', 'img/group1.jpg', 1, '2024-10-08 06:30:47', '2024-10-08 06:33:24'),
(2, 'Calm Collective', '102', 8, 3, '2023-03-22', 'Active', 'img/group2.jpg', 1, '2024-10-08 06:30:47', '2024-10-08 06:33:24'),
(3, 'Healing Minds', '103', 15, 7, '2022-11-30', 'Inactive', 'img/group3.jpg', 1, '2024-10-08 06:30:47', '2024-10-08 06:33:24'),
(4, 'Serene Souls', '104', 10, 4, '2023-05-10', 'Active', 'img/group4.jpg', 1, '2024-10-08 06:30:47', '2024-10-08 06:33:24'),
(5, 'Peaceful Pathways', '105', 9, 6, '2023-07-05', 'Active', 'img/group5.jpg', 1, '2024-10-08 06:30:47', '2024-10-08 06:33:24'),
(6, 'Harmony Hub', '106', 7, 3, '2022-09-01', 'Inactive', 'img/group6.jpg', 1, '2024-10-08 06:30:47', '2024-10-08 06:33:24'),
(7, 'Balanced Beings', '107', 11, 8, '2023-02-18', 'Active', 'img/group7.jpg', 1, '2024-10-08 06:30:47', '2024-10-08 06:33:24'),
(8, 'Tranquil Transitions', '108', 13, 5, '2023-06-20', 'Active', 'img/group8.jpg', 1, '2024-10-08 06:30:47', '2024-10-08 06:33:24'),
(9, 'Soothing Support', '109', 6, 2, '2022-12-12', 'Inactive', 'img/group9.jpg', 1, '2024-10-08 06:30:47', '2024-10-08 06:33:24'),
(10, 'Zen Zone', '110', 10, 4, '2023-01-10', 'Active', 'img/group10.jpg', 1, '2024-10-08 06:30:47', '2024-10-08 06:33:24'),
(11, 'Resilient Roots', '111', 14, 6, '2023-07-15', 'Active', 'img/group11.jpg', 1, '2024-10-08 06:30:47', '2024-10-08 06:33:24'),
(12, 'Peaceful Pillars', '112', 9, 5, '2023-04-01', 'Inactive', 'img/group12.jpg', 1, '2024-10-08 06:30:47', '2024-10-08 06:33:24'),
(13, 'Mindful Motion', '113', 8, 4, '2023-05-22', 'Active', 'img/group13.jpg', 1, '2024-10-08 06:30:47', '2024-10-08 06:33:24'),
(14, 'Calm Connections', '114', 7, 2, '2023-03-10', 'Inactive', 'img/group14.jpg', 1, '2024-10-08 06:30:47', '2024-10-08 06:33:24'),
(15, 'Serenity Circle', '115', 10, 3, '2023-06-05', 'Active', 'img/group15.jpg', 1, '2024-10-08 06:30:47', '2024-10-08 06:33:24'),
(16, 'Healing Hearts', '116', 12, 5, '2022-08-25', 'Inactive', 'img/group16.jpg', 1, '2024-10-08 06:30:47', '2024-10-08 06:33:24'),
(17, 'Balanced Bridges', '117', 9, 4, '2023-07-25', 'Active', 'img/group17.jpg', 1, '2024-10-08 06:30:47', '2024-10-08 06:33:24'),
(18, 'Tranquil Tribes', '118', 8, 6, '2022-11-12', 'Inactive', 'img/group18.jpg', 1, '2024-10-08 06:30:47', '2024-10-08 06:33:24'),
(19, 'Resilient Warriors', '119', 11, 7, '2023-02-01', 'Active', 'img/group19.jpg', 1, '2024-10-08 06:30:47', '2024-10-08 06:33:24'),
(20, 'Serene Spirits', '120', 10, 4, '2023-03-30', 'Active', 'img/group20.jpg', 1, '2024-10-08 06:30:47', '2024-10-08 06:33:24'),
(21, 'testor', '', 0, NULL, '2024-10-08', 'Active', NULL, 1, '2024-10-08 11:34:38', '2024-10-08 11:34:38');

-- --------------------------------------------------------

--
-- 表的结构 `mentaldiseases`
--

CREATE TABLE `mentaldiseases` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- 转存表中的数据 `mentaldiseases`
--

INSERT INTO `mentaldiseases` (`id`, `name`) VALUES
(1, 'Depression'),
(2, 'Anxiety'),
(3, 'Bipolar Disorder'),
(4, 'Obsessive-Compulsive Disorder'),
(5, 'Post-Traumatic Stress Disorder'),
(6, 'Schizophrenia'),
(7, 'Eating Disorder'),
(8, 'Personality Disorder'),
(9, 'Panic Disorder'),
(10, 'ADHD'),
(11, 'Dissociative Disorder');

-- --------------------------------------------------------

--
-- 表的结构 `patientdailyrecords`
--

CREATE TABLE `patientdailyrecords` (
  `id` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `record_date` date NOT NULL,
  `mood` varchar(255) DEFAULT NULL,
  `fitness_level` varchar(50) DEFAULT NULL,
  `sleep_hours` int(11) DEFAULT NULL,
  `diet` varchar(255) DEFAULT NULL,
  `caloric_intake` int(11) DEFAULT NULL,
  `sleep_time` time DEFAULT NULL,
  `exercise_time` int(11) DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `location` varchar(255) DEFAULT NULL,
  `voice` varchar(255) DEFAULT NULL,
  `picture` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- 转存表中的数据 `patientdailyrecords`
--

INSERT INTO `patientdailyrecords` (`id`, `patient_id`, `record_date`, `mood`, `fitness_level`, `sleep_hours`, `diet`, `caloric_intake`, `sleep_time`, `exercise_time`, `notes`, `location`, `voice`, `picture`) VALUES
(1, 1, '2024-10-03', '3', '3', 7, '1', 2477, '23:27:00', 5, 'Productive and happy today', 'Flinders University Bedford Park Campus', NULL, NULL),
(2, 113, '2024-10-01', '1', '4', 7, '4', 2452, '21:12:00', 5, 'Feeling energetic after a good workout', 'Flinders University Bedford Park Campus', NULL, NULL),
(3, 164, '2024-10-01', '10', '4', 8, '5', 2489, '23:09:00', 9, 'A little low on energy', 'Flinders University Bedford Park Campus', NULL, NULL),
(4, 21, '2024-10-01', '10', '1', 6, '5', 1575, '21:19:00', 5, 'A little low on energy', 'Flinders University Bedford Park Campus', NULL, NULL),
(5, 119, '2024-10-03', '6', '4', 9, '4', 2042, '23:00:00', 8, 'Feeling good, average fitness day', 'Flinders University Bedford Park Campus', NULL, NULL),
(6, 168, '2024-10-03', '8', '3', 6, '4', 2431, '22:58:00', 8, 'Feeling good, average fitness day', 'Flinders University Bedford Park Campus', NULL, NULL),
(7, 209, '2024-10-03', '9', '4', 8, '4', 1872, '23:22:00', 5, 'A little low on energy', 'Flinders University Bedford Park Campus', NULL, NULL),
(8, 9, '2024-10-01', '6', '5', 7, '5', 2352, '23:49:00', 7, 'Productive and happy today', 'Flinders University Bedford Park Campus', NULL, NULL),
(9, 128, '2024-10-01', '5', '1', 8, '1', 1727, '23:58:00', 8, 'Feeling a bit off today', 'Flinders University Bedford Park Campus', NULL, NULL),
(10, 20, '2024-10-01', '5', '1', 9, '3', 1696, '21:08:00', 5, 'Mood is stable and calm', 'Flinders University Bedford Park Campus', NULL, NULL),
(11, 175, '2024-10-01', '6', '3', 7, '2', 2322, '22:02:00', 5, 'Feeling a bit off today', 'Flinders University Bedford Park Campus', NULL, NULL),
(12, 200, '2024-10-03', '10', '2', 8, '3', 2391, '21:33:00', 6, 'A little low on energy', 'Flinders University Bedford Park Campus', NULL, NULL),
(13, 224, '2024-10-01', '1', '1', 6, '4', 2420, '22:40:00', 7, 'Feeling a bit off today', 'Flinders University Bedford Park Campus', NULL, NULL),
(14, 134, '2024-10-02', '10', '4', 9, '1', 1573, '23:42:00', 5, 'Need more sleep, feeling sluggish', 'Flinders University Bedford Park Campus', NULL, NULL),
(15, 50, '2024-10-02', '4', '3', 9, '4', 2439, '23:10:00', 6, 'Productive and happy today', 'Flinders University Bedford Park Campus', NULL, NULL),
(16, 154, '2024-10-01', '4', '3', 8, '5', 2414, '21:39:00', 6, 'Feeling good, average fitness day', 'Flinders University Bedford Park Campus', NULL, NULL),
(17, 87, '2024-10-03', '10', '4', 8, '1', 2456, '22:47:00', 9, 'Slightly tired, but manageable', 'Flinders University Bedford Park Campus', NULL, NULL),
(18, 163, '2024-10-02', '1', '4', 7, '4', 2089, '22:20:00', 8, 'Mood is stable and calm', 'Flinders University Bedford Park Campus', NULL, NULL),
(19, 77, '2024-10-01', '7', '1', 6, '4', 1644, '23:48:00', 5, 'Feeling energetic after a good workout', 'Flinders University Bedford Park Campus', NULL, NULL),
(20, 70, '2024-10-01', '2', '4', 6, '5', 2352, '23:20:00', 8, 'Excellent day, everything feels in sync', 'Flinders University Bedford Park Campus', NULL, NULL),
(21, 163, '2024-10-02', '5', '1', 5, '5', 1783, '21:29:00', 6, 'Feeling a bit off today', 'Flinders University Bedford Park Campus', NULL, NULL),
(22, 37, '2024-10-01', '7', '4', 6, '2', 1944, '22:39:00', 9, 'Slightly tired, but manageable', 'Flinders University Bedford Park Campus', NULL, NULL),
(23, 81, '2024-10-03', '3', '2', 6, '5', 1610, '23:04:00', 6, 'Productive and happy today', 'Flinders University Bedford Park Campus', NULL, NULL),
(24, 228, '2024-10-02', '3', '1', 5, '4', 2086, '21:25:00', 8, 'Focused and ready for the day', 'Flinders University Bedford Park Campus', NULL, NULL),
(25, 164, '2024-10-03', '6', '2', 7, '5', 1503, '23:33:00', 7, 'Feeling good, average fitness day', 'Flinders University Bedford Park Campus', NULL, NULL),
(26, 274, '2024-10-02', '4', '3', 5, '1', 2195, '22:24:00', 8, 'Slightly tired, but manageable', 'Flinders University Bedford Park Campus', NULL, NULL),
(27, 248, '2024-10-02', '1', '4', 6, '4', 1610, '21:05:00', 9, 'Focused and ready for the day', 'Flinders University Bedford Park Campus', NULL, NULL),
(28, 21, '2024-10-02', '8', '1', 6, '3', 1974, '21:26:00', 6, 'Feeling good, average fitness day', 'Flinders University Bedford Park Campus', NULL, NULL),
(29, 292, '2024-10-03', '6', '1', 6, '2', 2230, '21:18:00', 5, 'Slightly tired, but manageable', 'Flinders University Bedford Park Campus', NULL, NULL),
(30, 283, '2024-10-01', '4', '2', 9, '2', 1779, '21:39:00', 5, 'A little low on energy', 'Flinders University Bedford Park Campus', NULL, NULL),
(31, 225, '2024-10-02', '5', '3', 9, '3', 1580, '22:07:00', 5, 'Focused and ready for the day', 'Flinders University Bedford Park Campus', NULL, NULL),
(32, 141, '2024-10-02', '10', '1', 7, '1', 2059, '21:46:00', 5, 'Productive and happy today', 'Flinders University Bedford Park Campus', NULL, NULL),
(33, 188, '2024-10-02', '9', '4', 8, '4', 1549, '23:45:00', 6, 'A little low on energy', 'Flinders University Bedford Park Campus', NULL, NULL),
(34, 183, '2024-10-01', '9', '4', 6, '3', 1737, '23:41:00', 8, 'Mood is stable and calm', 'Flinders University Bedford Park Campus', NULL, NULL),
(35, 22, '2024-10-03', '6', '4', 7, '2', 2405, '23:09:00', 7, 'Productive and happy today', 'Flinders University Bedford Park Campus', NULL, NULL),
(36, 9, '2024-10-02', '7', '2', 8, '2', 2197, '21:39:00', 6, 'A little low on energy', 'Flinders University Bedford Park Campus', NULL, NULL),
(37, 182, '2024-10-02', '3', '1', 8, '2', 1519, '23:44:00', 5, 'Excellent day, everything feels in sync', 'Flinders University Bedford Park Campus', NULL, NULL),
(38, 122, '2024-10-02', '2', '2', 8, '2', 1570, '21:56:00', 6, 'Slightly tired, but manageable', 'Flinders University Bedford Park Campus', NULL, NULL),
(39, 82, '2024-10-02', '2', '1', 5, '4', 1645, '22:21:00', 7, 'Focused and ready for the day', 'Flinders University Bedford Park Campus', NULL, NULL),
(40, 157, '2024-10-03', '4', '1', 5, '2', 1526, '23:53:00', 8, 'Feeling a bit off today', 'Flinders University Bedford Park Campus', NULL, NULL),
(41, 129, '2024-10-02', '9', '3', 9, '5', 2335, '23:09:00', 8, 'Slightly tired, but manageable', 'Flinders University Bedford Park Campus', NULL, NULL),
(42, 80, '2024-10-01', '9', '4', 6, '2', 1966, '21:48:00', 7, 'Feeling good, average fitness day', 'Flinders University Bedford Park Campus', NULL, NULL),
(43, 69, '2024-10-02', '5', '3', 8, '1', 1771, '21:37:00', 5, 'Mood is stable and calm', 'Flinders University Bedford Park Campus', NULL, NULL),
(44, 23, '2024-10-01', '10', '3', 5, '5', 1694, '22:41:00', 6, 'A little low on energy', 'Flinders University Bedford Park Campus', NULL, NULL),
(45, 203, '2024-10-02', '10', '2', 6, '2', 2255, '23:07:00', 5, 'Focused and ready for the day', 'Flinders University Bedford Park Campus', NULL, NULL),
(46, 32, '2024-10-03', '4', '2', 5, '4', 2041, '22:17:00', 5, 'Feeling good, average fitness day', 'Flinders University Bedford Park Campus', NULL, NULL),
(47, 36, '2024-10-02', '10', '1', 9, '4', 2116, '22:14:00', 8, 'Slightly tired, but manageable', 'Flinders University Bedford Park Campus', NULL, NULL),
(48, 276, '2024-10-03', '3', '2', 8, '1', 2238, '23:33:00', 5, 'Feeling energetic after a good workout', 'Flinders University Bedford Park Campus', NULL, NULL),
(49, 100, '2024-10-02', '2', '3', 9, '2', 2233, '22:42:00', 9, 'Need more sleep, feeling sluggish', 'Flinders University Bedford Park Campus', NULL, NULL),
(50, 187, '2024-10-01', '10', '3', 7, '2', 2212, '21:03:00', 8, 'Need more sleep, feeling sluggish', 'Flinders University Bedford Park Campus', NULL, NULL),
(51, 278, '2024-10-01', '3', '5', 8, '5', 1879, '21:37:00', 9, 'Excellent day, everything feels in sync', 'Flinders University Bedford Park Campus', NULL, NULL),
(52, 226, '2024-10-02', '4', '4', 6, '1', 1903, '21:37:00', 6, 'Productive and happy today', 'Flinders University Bedford Park Campus', NULL, NULL),
(53, 215, '2024-10-02', '2', '4', 5, '1', 1620, '23:51:00', 8, 'Slightly tired, but manageable', 'Flinders University Bedford Park Campus', NULL, NULL),
(54, 82, '2024-10-03', '4', '1', 7, '2', 2091, '23:19:00', 5, 'Feeling good, average fitness day', 'Flinders University Bedford Park Campus', NULL, NULL),
(55, 161, '2024-10-02', '3', '1', 5, '5', 2488, '23:35:00', 7, 'Feeling energetic after a good workout', 'Flinders University Bedford Park Campus', NULL, NULL),
(56, 141, '2024-10-03', '8', '5', 6, '5', 1939, '23:15:00', 6, 'Slightly tired, but manageable', 'Flinders University Bedford Park Campus', NULL, NULL),
(57, 73, '2024-10-02', '8', '2', 7, '2', 1941, '22:33:00', 9, 'Feeling a bit off today', 'Flinders University Bedford Park Campus', NULL, NULL),
(58, 214, '2024-10-03', '8', '2', 7, '4', 2290, '23:18:00', 8, 'Feeling a bit off today', 'Flinders University Bedford Park Campus', NULL, NULL),
(59, 235, '2024-10-02', '4', '4', 8, '3', 1856, '23:23:00', 6, 'Feeling good, average fitness day', 'Flinders University Bedford Park Campus', NULL, NULL),
(60, 49, '2024-10-01', '1', '1', 7, '4', 1953, '21:25:00', 6, 'Mood is stable and calm', 'Flinders University Bedford Park Campus', NULL, NULL),
(61, 180, '2024-10-03', '9', '3', 9, '1', 1994, '21:53:00', 5, 'Feeling good, average fitness day', 'Flinders University Bedford Park Campus', NULL, NULL),
(62, 20, '2024-10-01', '9', '4', 7, '4', 1629, '21:07:00', 6, 'Slightly tired, but manageable', 'Flinders University Bedford Park Campus', NULL, NULL),
(63, 65, '2024-10-03', '2', '1', 6, '2', 2017, '23:16:00', 9, 'Feeling good, average fitness day', 'Flinders University Bedford Park Campus', NULL, NULL),
(64, 156, '2024-10-02', '3', '2', 5, '1', 1924, '23:32:00', 9, 'A little low on energy', 'Flinders University Bedford Park Campus', NULL, NULL),
(65, 111, '2024-10-02', '1', '4', 7, '4', 2028, '23:54:00', 7, 'Feeling energetic after a good workout', 'Flinders University Bedford Park Campus', NULL, NULL),
(66, 268, '2024-10-03', '1', '1', 9, '1', 2093, '22:35:00', 9, 'Mood is stable and calm', 'Flinders University Bedford Park Campus', NULL, NULL),
(67, 99, '2024-10-03', '4', '4', 7, '4', 1954, '22:50:00', 8, 'A little low on energy', 'Flinders University Bedford Park Campus', NULL, NULL),
(68, 298, '2024-10-03', '1', '2', 8, '1', 1521, '21:00:00', 6, 'A little low on energy', 'Flinders University Bedford Park Campus', NULL, NULL),
(69, 267, '2024-10-03', '4', '3', 7, '4', 2032, '21:55:00', 7, 'Focused and ready for the day', 'Flinders University Bedford Park Campus', NULL, NULL),
(70, 218, '2024-10-02', '8', '1', 7, '5', 1646, '21:53:00', 5, 'Mood is stable and calm', 'Flinders University Bedford Park Campus', NULL, NULL),
(71, 15, '2024-10-03', '2', '3', 5, '1', 1933, '22:31:00', 6, 'Slightly tired, but manageable', 'Flinders University Bedford Park Campus', NULL, NULL),
(72, 261, '2024-10-03', '3', '4', 9, '3', 2117, '23:30:00', 6, 'Slightly tired, but manageable', 'Flinders University Bedford Park Campus', NULL, NULL),
(73, 267, '2024-10-03', '10', '1', 6, '5', 2101, '23:35:00', 9, 'Feeling good, average fitness day', 'Flinders University Bedford Park Campus', NULL, NULL),
(74, 240, '2024-10-01', '7', '4', 9, '5', 1699, '21:42:00', 5, 'Feeling energetic after a good workout', 'Flinders University Bedford Park Campus', NULL, NULL),
(75, 132, '2024-10-02', '10', '1', 8, '5', 1849, '21:00:00', 8, 'Feeling energetic after a good workout', 'Flinders University Bedford Park Campus', NULL, NULL),
(76, 110, '2024-10-03', '10', '2', 8, '1', 1549, '23:34:00', 6, 'Focused and ready for the day', 'Flinders University Bedford Park Campus', NULL, NULL),
(77, 85, '2024-10-01', '9', '1', 6, '4', 1687, '23:16:00', 5, 'Feeling a bit off today', 'Flinders University Bedford Park Campus', NULL, NULL),
(78, 248, '2024-10-01', '3', '1', 5, '2', 2109, '23:25:00', 9, 'Feeling energetic after a good workout', 'Flinders University Bedford Park Campus', NULL, NULL),
(79, 161, '2024-10-03', '8', '5', 7, '1', 2473, '22:52:00', 6, 'Mood is stable and calm', 'Flinders University Bedford Park Campus', NULL, NULL),
(80, 172, '2024-10-03', '2', '2', 8, '4', 2102, '22:35:00', 9, 'Productive and happy today', 'Flinders University Bedford Park Campus', NULL, NULL),
(81, 119, '2024-10-03', '7', '5', 8, '3', 2366, '22:15:00', 9, 'Feeling good, average fitness day', 'Flinders University Bedford Park Campus', NULL, NULL),
(82, 200, '2024-10-02', '7', '4', 6, '4', 2364, '22:37:00', 9, 'Mood is stable and calm', 'Flinders University Bedford Park Campus', NULL, NULL),
(83, 115, '2024-10-02', '6', '5', 6, '3', 1787, '22:13:00', 6, 'Mood is stable and calm', 'Flinders University Bedford Park Campus', NULL, NULL),
(84, 65, '2024-10-02', '9', '2', 6, '3', 2304, '22:09:00', 8, 'Focused and ready for the day', 'Flinders University Bedford Park Campus', NULL, NULL),
(85, 198, '2024-10-01', '2', '3', 8, '1', 1796, '22:21:00', 6, 'Feeling a bit off today', 'Flinders University Bedford Park Campus', NULL, NULL),
(86, 154, '2024-10-02', '4', '3', 7, '1', 1923, '21:33:00', 5, 'Feeling a bit off today', 'Flinders University Bedford Park Campus', NULL, NULL),
(87, 285, '2024-10-02', '9', '4', 8, '4', 1947, '22:38:00', 7, 'Feeling energetic after a good workout', 'Flinders University Bedford Park Campus', NULL, NULL),
(88, 174, '2024-10-03', '8', '4', 9, '1', 1886, '22:38:00', 9, 'Mood is stable and calm', 'Flinders University Bedford Park Campus', NULL, NULL),
(89, 21, '2024-10-03', '10', '4', 9, '4', 2192, '23:30:00', 9, 'Feeling a bit off today', 'Flinders University Bedford Park Campus', NULL, NULL),
(90, 97, '2024-10-02', '6', '4', 7, '5', 1941, '22:14:00', 7, 'Feeling a bit off today', 'Flinders University Bedford Park Campus', NULL, NULL),
(91, 25, '2024-10-01', '9', '2', 7, '4', 2031, '23:04:00', 9, 'Feeling energetic after a good workout', 'Flinders University Bedford Park Campus', NULL, NULL),
(92, 16, '2024-10-01', '7', '3', 8, '5', 1700, '23:21:00', 8, 'Slightly tired, but manageable', 'Flinders University Bedford Park Campus', NULL, NULL),
(93, 258, '2024-10-02', '10', '5', 5, '1', 2269, '21:40:00', 7, 'Feeling good, average fitness day', 'Flinders University Bedford Park Campus', NULL, NULL),
(94, 206, '2024-10-02', '2', '3', 5, '5', 2098, '22:18:00', 9, 'Slightly tired, but manageable', 'Flinders University Bedford Park Campus', NULL, NULL),
(95, 300, '2024-10-02', '7', '5', 8, '4', 2183, '23:15:00', 5, 'Feeling a bit off today', 'Flinders University Bedford Park Campus', NULL, NULL),
(96, 270, '2024-10-02', '6', '3', 7, '5', 2497, '23:57:00', 5, 'Focused and ready for the day', 'Flinders University Bedford Park Campus', NULL, NULL),
(97, 96, '2024-10-01', '8', '3', 7, '3', 2263, '21:07:00', 5, 'Feeling a bit off today', 'Flinders University Bedford Park Campus', NULL, NULL),
(98, 103, '2024-10-01', '3', '2', 7, '4', 1770, '22:30:00', 5, 'Feeling good, average fitness day', 'Flinders University Bedford Park Campus', NULL, NULL),
(99, 188, '2024-10-01', '5', '5', 5, '2', 1947, '23:29:00', 6, 'Productive and happy today', 'Flinders University Bedford Park Campus', NULL, NULL),
(100, 201, '2024-10-01', '2', '2', 5, '2', 2285, '21:55:00', 7, 'Feeling energetic after a good workout', 'Flinders University Bedford Park Campus', NULL, NULL),
(101, 1, '2024-10-03', '3', '3', 7, '1', 2477, '23:27:00', 5, 'Productive and happy today', 'Flinders University Bedford Park Campus', NULL, NULL),
(102, 1, '2024-10-04', '4', '4', 8, '2', 2500, '22:45:00', 6, 'Feeling a bit tired', 'Flinders University Bedford Park Campus', NULL, NULL),
(103, 1, '2024-10-05', '6', '5', 7, '3', 2300, '23:13:00', 4, 'Energized after a good workout', 'Flinders University Bedford Park Campus', NULL, NULL),
(104, 1, '2024-10-06', '5', '3', 6, '4', 2700, '23:00:00', 5, 'Didn\'t sleep well', 'Flinders University Bedford Park Campus', NULL, NULL),
(105, 1, '2024-10-07', '7', '4', 8, '5', 2477, '23:30:00', 5, 'Mood improved after talking with friends', 'Flinders University Bedford Park Campus', NULL, NULL),
(106, 1, '2024-10-08', '8', '5', 6, '6', 2500, '22:50:00', 6, 'A bit stressed from work', 'Flinders University Bedford Park Campus', NULL, NULL),
(107, 1, '2024-10-09', '9', '4', 7, '1', 2300, '22:55:00', 4, 'Feeling accomplished after finishing tasks', 'Flinders University Bedford Park Campus', NULL, NULL),
(108, 1, '2024-10-10', '4', '3', 8, '2', 2000, '23:22:00', 6, 'Productive and happy today', 'Flinders University Bedford Park Campus', NULL, NULL),
(109, 1, '2024-10-11', '2', '2', 7, '3', 2500, '23:10:00', 5, 'Didn\'t sleep well', 'Flinders University Bedford Park Campus', NULL, NULL),
(110, 1, '2024-10-12', '5', '5', 6, '4', 2700, '22:47:00', 4, 'A bit stressed from work', 'Flinders University Bedford Park Campus', NULL, NULL),
(111, 1, '2024-10-10', '5', NULL, NULL, '5', NULL, NULL, NULL, '', 'Flinders University', '', ''),
(112, 1, '2024-10-10', '5', NULL, NULL, '5', NULL, NULL, NULL, '', 'Flinders University', '', ''),
(113, 1, '2024-10-10', '5', '6', 6, '5', NULL, NULL, NULL, '', 'Flinders University', '', ''),
(114, 1, '2024-10-10', '5', '6', 6, '5', NULL, NULL, NULL, '1', 'Flinders University', '', ''),
(115, 1, '2024-10-10', '5', '6', 6, '5', NULL, NULL, NULL, '1', 'Flinders University', '', ''),
(116, 1, '2024-10-11', '8', '6', 6, '1', NULL, NULL, NULL, 'dd', 'Flinders University', '', ''),
(117, 302, '2024-10-10', '5', '6', 6, '3', NULL, NULL, NULL, 'sad', 'Flinders University', '', '');

-- --------------------------------------------------------

--
-- 表的结构 `patientnotes`
--

CREATE TABLE `patientnotes` (
  `note_id` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `therapist_id` int(11) NOT NULL,
  `note_text` text NOT NULL,
  `note_date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- 转存表中的数据 `patientnotes`
--

INSERT INTO `patientnotes` (`note_id`, `patient_id`, `therapist_id`, `note_text`, `note_date`) VALUES
(1, 1, 5, 'Patient showing signs of improvement', '2024-09-30 14:30:00'),
(2, 1, 2, 'Discussed new therapy approach', '2024-10-04 14:30:00'),
(3, 1, 7, 'Patient feels less anxious', '2024-10-09 13:30:00'),
(4, 1, 3, 'Recommended exercise routine', '2024-10-11 13:30:00'),
(5, 1, 9, 'Follow-up scheduled', '2024-10-14 13:30:00'),
(6, 2, 2, 'Initial consultation', '2024-09-30 14:30:00'),
(7, 2, 8, 'Patient feels stressed at work', '2024-10-05 14:30:00'),
(8, 2, 4, 'Introduced mindfulness exercises', '2024-10-08 13:30:00'),
(9, 2, 1, 'Patient reported better sleep', '2024-10-10 13:30:00'),
(10, 2, 6, 'Next session in two weeks', '2024-10-13 13:30:00'),
(11, 3, 1, 'Review of medication', '2024-10-01 14:30:00'),
(12, 3, 6, 'Patient responding well to treatment', '2024-10-06 13:30:00'),
(13, 3, 3, 'Discussed coping strategies', '2024-10-08 13:30:00'),
(14, 3, 7, 'Reduced anxiety reported', '2024-10-12 13:30:00'),
(15, 3, 10, 'Next appointment confirmed', '2024-10-16 13:30:00'),
(16, 4, 3, 'Initial assessment completed', '2024-10-02 14:30:00'),
(17, 4, 10, 'Patient hesitant about therapy', '2024-10-07 13:30:00'),
(18, 4, 9, 'Motivational exercises introduced', '2024-10-08 13:30:00'),
(19, 4, 4, 'Follow-up on therapy progress', '2024-10-10 13:30:00'),
(20, 4, 2, 'Patient shows better mood', '2024-10-14 13:30:00'),
(21, 5, 5, 'Discussed patient’s goals', '2024-10-03 14:30:00'),
(22, 5, 7, 'Scheduled next session', '2024-10-06 13:30:00'),
(23, 5, 8, 'Exercise routine discussed', '2024-10-09 13:30:00'),
(24, 5, 9, 'Patient reported improved mood', '2024-10-12 13:30:00'),
(25, 5, 2, 'Next follow-up in two weeks', '2024-10-15 13:30:00'),
(26, 1, 1, 'test notes for patient', '2024-10-08 12:27:00'),
(27, 1, 1, 'test notes 2 for patient', '2024-10-08 12:27:40'),
(28, 1, 1, 't', '2024-10-08 12:28:03'),
(29, 1, 1, 'tt', '2024-10-09 02:52:29');

-- --------------------------------------------------------

--
-- 表的结构 `patients`
--

CREATE TABLE `patients` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `phone_number` varchar(20) DEFAULT NULL,
  `group_name` varchar(50) DEFAULT NULL,
  `field` varchar(50) DEFAULT NULL,
  `status` enum('Online','Rest','Quit') DEFAULT 'Online',
  `date_of_birth` date DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `emergency_contact_name` varchar(255) DEFAULT NULL,
  `emergency_contact_phone` varchar(20) DEFAULT NULL,
  `insurance_policy_number` varchar(50) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `photo` varchar(255) DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- 转存表中的数据 `patients`
--

INSERT INTO `patients` (`id`, `name`, `email`, `phone_number`, `group_name`, `field`, `status`, `date_of_birth`, `password`, `emergency_contact_name`, `emergency_contact_phone`, `insurance_policy_number`, `address`, `photo`, `notes`, `created_at`, `updated_at`) VALUES
(1, 'Laura Lewis', 'patient1@care.com', '1119096577', 'Group 2', 'Orthopedics', 'Online', '1983-11-07', '29618d60acd075fc93cac898b8e4a1231e97aaabcb851566756b171448f92ef5', 'Emergency Contact 1', '1103862043', 'POL86577', '560 Elm St', 'assets/patient1.jpg', 'Asthma patient', '2024-09-07 02:31:23', '2024-10-11 01:26:22'),
(2, 'Sarah Moore', 'patient2@care.com', '1316780152', 'Group 4', 'Orthopedics', 'Quit', '1995-10-15', 'cd4e790a5f73201c2022ec0c326ae03e0003fb6218dcc6f270bd32dbebee42e8', 'Emergency Contact 2', '1550945404', 'POL52622', '767 Elm St', 'assets/patient2.jpg', 'Diabetic', '2024-09-20 02:31:23', '2024-10-08 06:30:47'),
(3, 'Laura Davis', 'patient3@care.com', '1511101871', 'Group 3', 'Dermatology', 'Rest', '2009-01-04', '5888e0023c8316005d9fd0d5b23b7cbcd2e521b76cabc0a9016cb8aaf4f2d86f', 'Emergency Contact 3', '1955603860', 'POL25367', '683 Elm St', 'assets/patient3.jpg', 'Asthma patient', '2024-09-12 02:31:23', '2024-10-08 06:30:47'),
(4, 'Mia White', 'patient4@care.com', '1709807803', 'Group 5', 'Orthopedics', 'Online', '1986-05-13', '4208f235050bf48bd263fede72d15cc87823f1161f52794d96468060639f2609', 'Emergency Contact 4', '1657723691', 'POL48382', '486 Elm St', 'assets/patient4.jpg', 'Asthma patient', '2024-09-15 02:31:23', '2024-10-08 06:30:47'),
(5, 'David Taylor', 'patient5@care.com', '1685921426', 'Group 4', 'Orthopedics', 'Online', '2011-02-06', '246ecb6ebf8a42e7e7e9b43afc27432f970561d51985499af4634839982c6c3c', 'Emergency Contact 5', '1883571918', 'POL52306', '459 Elm St', 'assets/patient5.jpg', 'No known allergies', '2024-09-28 02:31:23', '2024-10-08 06:30:47'),
(6, 'Robert Taylor', 'patient6@care.com', '1561351916', 'Group 3', 'Neurology', 'Rest', '1980-01-02', 'c3acb310b2dfd69823d6a275ebad07b78a22cdd0440c0d1560474f46849ec8e6', 'Emergency Contact 6', '1693496325', 'POL76710', '887 Elm St', 'assets/patient6.jpg', 'Diabetic', '2024-09-19 02:31:23', '2024-10-08 06:30:47'),
(7, 'Daniel Jackson', 'patient7@care.com', '1602097562', 'Group 1', 'Orthopedics', 'Rest', '1982-02-24', 'de1d7d61919a115b73f6345d8181347f3746e09c03208a8dc7954fe84125ad77', 'Emergency Contact 7', '1993054152', 'POL42532', '347 Elm St', 'assets/patient7.jpg', 'Asthma patient', '2024-09-20 02:31:23', '2024-10-08 06:30:47'),
(8, 'Lucas Davis', 'patient8@care.com', '1596760495', 'Group 5', 'Pediatrics', 'Online', '2014-03-06', '6dbe41274b63ce5245b3fa35915b4694c32effc624bc0354c0b5628a860c4991', 'Emergency Contact 8', '1979711661', 'POL19001', '735 Elm St', 'assets/patient8.jpg', 'High blood pressure', '2024-10-01 02:31:23', '2024-10-08 06:30:47'),
(9, 'Daniel Moore', 'patient9@care.com', '1620667579', 'Group 3', 'Neurology', 'Quit', '2015-05-15', '4aaf95c45e6a79cb3d9f0c2037616a04f00642fcc471cac19a0344593dd4db3a', 'Emergency Contact 9', '1284396174', 'POL35503', '157 Elm St', 'assets/patient9.jpg', 'No notes', '2024-09-08 02:31:23', '2024-10-08 06:30:47'),
(10, 'Sarah Rodriguez', 'patient10@care.com', '1850765020', 'Group 5', 'Oncology', 'Rest', '1986-12-13', '9e560d8e19c7540773d20021d60f7afa794a3789cde21815fa5811a181420774', 'Emergency Contact 10', '1978312236', 'POL46796', '827 Elm St', 'assets/patient10.jpg', 'Asthma patient', '2024-09-20 02:31:23', '2024-10-08 06:30:47'),
(11, 'Michael Thompson', 'patient11@care.com', '1571314144', 'Group 1', 'Pediatrics', 'Rest', '1983-10-28', 'eb0fa33d78a096a147f0631d38a2790589e0ef717fd52da1d7d6783c86031772', 'Emergency Contact 11', '1168402362', 'POL60198', '231 Elm St', 'assets/patient11.jpg', 'Asthma patient', '2024-09-14 02:31:23', '2024-10-08 06:30:47'),
(12, 'Emma White', 'patient12@care.com', '1554760899', 'Group 1', 'Neurology', 'Quit', '2007-09-22', 'b35875c6e2ce47e5fb07de384e9d8c0534f578c12bb1ff959ac3d4af9ff679b9', 'Emergency Contact 12', '1507251179', 'POL55304', '733 Elm St', 'assets/patient12.jpg', 'No known allergies', '2024-09-24 02:31:23', '2024-10-08 06:30:47'),
(13, 'Sophia Jackson', 'patient13@care.com', '1106878258', 'Group 4', 'Neurology', 'Online', '2003-08-28', '7352a6de3d914ba96502b297904028ba9a39a9c9b3f466bb43585c1200b477f3', 'Emergency Contact 13', '1265973192', 'POL24265', '325 Elm St', 'assets/patient13.jpg', 'Diabetic', '2024-09-21 02:31:23', '2024-10-08 06:30:47'),
(14, 'Jane Garcia', 'patient14@care.com', '1591052191', 'Group 2', 'Dermatology', 'Quit', '1981-06-23', 'e9bac61e6d981540a6f4cb4ac0b5dcf88a1ea38636ec8a60b6ec92a349e5ea48', 'Emergency Contact 14', '1665308381', 'POL89407', '878 Elm St', 'assets/patient14.jpg', 'High blood pressure', '2024-09-11 02:31:23', '2024-10-08 06:30:47'),
(15, 'Mia Taylor', 'patient15@care.com', '1985289706', 'Group 5', 'Orthopedics', 'Online', '2010-01-12', 'dd78f40c096917f44a3ae57dd84fc9524230f712fc60bfa26afbf8882acad0db', 'Emergency Contact 15', '1131581338', 'POL27797', '264 Elm St', 'assets/patient15.jpg', 'Diabetic', '2024-10-02 02:31:23', '2024-10-08 06:30:47'),
(16, 'Sophia Martinez', 'patient16@care.com', '1761125723', 'Group 1', 'Neurology', 'Rest', '1987-05-03', 'cc3351a9399ae9068c158b5e9210b78c1f2132820f1c184adf93d988f276beee', 'Emergency Contact 16', '1857405035', 'POL33091', '602 Elm St', 'assets/patient16.jpg', 'High blood pressure', '2024-09-27 02:31:23', '2024-10-08 06:30:47'),
(17, 'James Brown', 'patient17@care.com', '1989611422', 'Group 5', 'Pediatrics', 'Online', '1995-08-03', '6ac0e904b7edc0572b19e997cd4fc4d9f12d8909dfa17e9fd7961dbe458b9209', 'Emergency Contact 17', '1460214537', 'POL73644', '405 Elm St', 'assets/patient17.jpg', 'High blood pressure', '2024-10-05 02:31:23', '2024-10-08 06:30:47'),
(18, 'Laura Brown', 'patient18@care.com', '1593757854', 'Group 2', 'Oncology', 'Quit', '2002-10-03', '00995bdd408a8b147cfc77e2e9111a4bacae576bcb429558d30af2183147132f', 'Emergency Contact 18', '1246721227', 'POL81426', '541 Elm St', 'assets/patient18.jpg', 'High blood pressure', '2024-10-05 02:31:23', '2024-10-08 06:30:47'),
(19, 'Lucas Lewis', 'patient19@care.com', '1803233334', 'Group 4', 'Dermatology', 'Quit', '2016-05-22', '1e819928cbf525f6b46d5a9f3bc9cf855c7ae3194ae2c48ef94089cbd5fa15c6', 'Emergency Contact 19', '1978175865', 'POL91319', '554 Elm St', 'assets/patient19.jpg', 'Diabetic', '2024-09-15 02:31:23', '2024-10-08 06:30:47'),
(20, 'Mia Miller', 'patient20@care.com', '1501358198', 'Group 3', 'Orthopedics', 'Quit', '1996-07-26', 'a13089fe520a9ea4945868b74041aa5c104b0f823a106b1917b3f04b12c2ecdd', 'Emergency Contact 20', '1592058852', 'POL14322', '335 Elm St', 'assets/patient20.jpg', 'No known allergies', '2024-09-17 02:31:23', '2024-10-08 06:30:47'),
(21, 'Sarah Clark', 'patient21@care.com', '1462127711', 'Group 3', 'Orthopedics', 'Quit', '2019-01-13', '735202fc56627add9fb068434819bd7d599000b63849d956a1633bae50bcb3c0', 'Emergency Contact 21', '1651700773', 'POL18504', '656 Elm St', 'assets/patient21.jpg', 'Asthma patient', '2024-09-16 02:31:23', '2024-10-08 06:30:47'),
(22, 'Daniel Miller', 'patient22@care.com', '1175643354', 'Group 5', 'Oncology', 'Quit', '1997-08-20', '9164532dc5563b2eca645010e764578c541ea633647b90c9f11bdd07e3feda8f', 'Emergency Contact 22', '1917957435', 'POL22468', '212 Elm St', 'assets/patient22.jpg', 'High blood pressure', '2024-09-12 02:31:23', '2024-10-08 06:30:47'),
(23, 'Michael Johnson', 'patient23@care.com', '1423289163', 'Group 3', 'Orthopedics', 'Online', '2009-02-23', '1d1e2487eac63c001c54705ab13a1236368868d5393eae57ff8be7483f20b7b4', 'Emergency Contact 23', '1656666781', 'POL25255', '964 Elm St', 'assets/patient23.jpg', 'No notes', '2024-09-23 02:31:23', '2024-10-08 06:30:47'),
(24, 'Ethan Martinez', 'patient24@care.com', '1844451134', 'Group 1', 'Oncology', 'Online', '1981-01-05', 'b534916e26f561a53df5fbd8a397d944a874dd31bd10c97a44427c8e8d1f8fa6', 'Emergency Contact 24', '1444561001', 'POL74409', '978 Elm St', 'assets/patient24.jpg', 'Asthma patient', '2024-09-08 02:31:23', '2024-10-08 06:30:47'),
(25, 'John Davis', 'patient25@care.com', '1888265592', 'Group 2', 'Pediatrics', 'Online', '1998-06-27', 'f453acecd54903e66945d93fe4b54c503daba63a88b376b054cc3a770801510b', 'Emergency Contact 25', '1697292775', 'POL69671', '581 Elm St', 'assets/patient25.jpg', 'Asthma patient', '2024-09-16 02:31:23', '2024-10-08 06:30:47'),
(26, 'Mia Wilson', 'patient26@care.com', '1952495663', 'Group 2', 'Pediatrics', 'Quit', '2000-10-25', '61db68f678644ec907a470fb15194719c82458773d5e3b8a3a5f1c0bd59773fc', 'Emergency Contact 26', '1235231086', 'POL46676', '297 Elm St', 'assets/patient26.jpg', 'Diabetic', '2024-09-26 02:31:23', '2024-10-08 06:30:47'),
(27, 'Ethan White', 'patient27@care.com', '1555331250', 'Group 4', 'Dermatology', 'Online', '2005-03-20', '4ce7f08d7e55ed7ff4dfbb96c8d454905333fc1e3e10251d46548d7d6873518b', 'Emergency Contact 27', '1386340922', 'POL50081', '765 Elm St', 'assets/patient27.jpg', 'High blood pressure', '2024-09-10 02:31:23', '2024-10-08 06:30:47'),
(28, 'Jane Walker', 'patient28@care.com', '1568773690', 'Group 3', 'Dermatology', 'Online', '1989-03-15', '16461bec9eb3b12e19b49c017583a357c59218f66a6752e2b867f90553331195', 'Emergency Contact 28', '1375480888', 'POL31396', '720 Elm St', 'assets/patient28.jpg', 'No known allergies', '2024-10-01 02:31:23', '2024-10-08 06:30:47'),
(29, 'Ethan Miller', 'patient29@care.com', '1677166656', 'Group 1', 'Orthopedics', 'Quit', '2006-04-01', 'b024c56f6f3218b190b80069e4e79d6310001cc46098b2003729a68cca7e61dc', 'Emergency Contact 29', '1400942576', 'POL23432', '285 Elm St', 'assets/patient29.jpg', 'High blood pressure', '2024-09-07 02:31:23', '2024-10-08 06:30:47'),
(30, 'Olivia Moore', 'patient30@care.com', '1942158950', 'Group 1', 'Neurology', 'Quit', '2011-07-03', '46386038e79bc2fa20d9e9f917f14f0589ebcc195f725a059b25fbca9ba194d9', 'Emergency Contact 30', '1556393106', 'POL76469', '673 Elm St', 'assets/patient30.jpg', 'Diabetic', '2024-10-03 02:31:23', '2024-10-08 06:30:47'),
(31, 'Ethan Lewis', 'patient31@care.com', '1373256518', 'Group 2', 'Neurology', 'Quit', '1981-12-02', '9cec95530f416cc5c54abf5c96642ac880343a4d95f59f1d1d16ceeb9d912d1e', 'Emergency Contact 31', '1562057536', 'POL57703', '809 Elm St', 'assets/patient31.jpg', 'Diabetic', '2024-09-07 02:31:23', '2024-10-08 06:30:47'),
(32, 'David Martinez', 'patient32@care.com', '1584973606', 'Group 2', 'Oncology', 'Online', '2008-07-10', '244270ecffa53ea4d1a4260a5fb972c40c2f8636956cf8f45060b057fc5cf88d', 'Emergency Contact 32', '1167901709', 'POL88908', '117 Elm St', 'assets/patient32.jpg', 'Asthma patient', '2024-09-06 02:31:23', '2024-10-08 06:30:47'),
(33, 'Daniel Harris', 'patient33@care.com', '1991185694', 'Group 4', 'Oncology', 'Online', '2018-08-10', '24b7e7c3b34b9008e0411a415eddce5a7d778aed689d38319a0a32ebeaee9f12', 'Emergency Contact 33', '1159383123', 'POL53550', '779 Elm St', 'assets/patient33.jpg', 'No notes', '2024-09-28 02:31:23', '2024-10-08 06:30:47'),
(34, 'Ethan Johnson', 'patient34@care.com', '1473582006', 'Group 5', 'Pediatrics', 'Quit', '1981-05-04', 'd8841846cc382042bfc838fc66809fe1b505de5b0b7dbe6a86d4f0c3889ba817', 'Emergency Contact 34', '1411419823', 'POL34559', '803 Elm St', 'assets/patient34.jpg', 'High blood pressure', '2024-10-03 02:31:23', '2024-10-08 06:30:47'),
(35, 'James Brown', 'patient35@care.com', '1238524048', 'Group 1', 'Pediatrics', 'Online', '1998-03-05', 'ff0f1a5de4d372c53326f71a47b72de88681b47b40416c0330e46ead02f6c4bb', 'Emergency Contact 35', '1241924705', 'POL72224', '330 Elm St', 'assets/patient35.jpg', 'No known allergies', '2024-09-09 02:31:23', '2024-10-08 06:30:47'),
(36, 'Olivia White', 'patient36@care.com', '1665888264', 'Group 2', 'Oncology', 'Online', '2008-01-04', 'b26eaa6a23d7379b8f3f37fb56b8da1cf1dd91686b196b863de658635dc3b0e5', 'Emergency Contact 36', '1787616349', 'POL34370', '989 Elm St', 'assets/patient36.jpg', 'No known allergies', '2024-09-20 02:31:23', '2024-10-08 06:30:47'),
(37, 'Emily Taylor', 'patient37@care.com', '1345940351', 'Group 5', 'Dermatology', 'Rest', '1993-10-07', '9b629868bdb981eef105d72fab66c1131604294c97d7e62bcb31e55c094670e5', 'Emergency Contact 37', '1962541271', 'POL72165', '798 Elm St', 'assets/patient37.jpg', 'Asthma patient', '2024-09-27 02:31:23', '2024-10-08 06:30:47'),
(38, 'Mia Jackson', 'patient38@care.com', '1943753626', 'Group 5', 'Oncology', 'Rest', '2004-11-01', '42051e10613c1a153ddaa9ae79397bd68d39d9413de65fee8ee700296ce731a7', 'Emergency Contact 38', '1486833622', 'POL69245', '128 Elm St', 'assets/patient38.jpg', 'Diabetic', '2024-09-18 02:31:23', '2024-10-08 06:30:47'),
(39, 'Sophia Jackson', 'patient39@care.com', '1412700653', 'Group 1', 'Pediatrics', 'Rest', '1987-08-13', 'd2abe4802da700b666cdb65ec10017c937cd665e071572a0c6419ad94c857ea3', 'Emergency Contact 39', '1605364591', 'POL90598', '147 Elm St', 'assets/patient39.jpg', 'Diabetic', '2024-09-14 02:31:23', '2024-10-08 06:30:47'),
(40, 'David Garcia', 'patient40@care.com', '1527005596', 'Group 2', 'Neurology', 'Online', '1994-10-19', 'dfb283c23e3ff244bc2f27e16abbbf63a5c3dc28a94276e2f8f9a93f7bb700c4', 'Emergency Contact 40', '1718067838', 'POL42398', '270 Elm St', 'assets/patient40.jpg', 'Diabetic', '2024-09-21 02:31:23', '2024-10-08 06:30:47'),
(41, 'Benjamin Moore', 'patient41@care.com', '1936881118', 'Group 2', 'Orthopedics', 'Quit', '2009-06-12', 'feb302a77e3fe75ba950749c352efa56d2449a1a216fcda0c1412a198ceb7790', 'Emergency Contact 41', '1369184711', 'POL38094', '774 Elm St', 'assets/patient41.jpg', 'No notes', '2024-09-30 02:31:23', '2024-10-08 06:30:47'),
(42, 'Laura White', 'patient42@care.com', '1772558257', 'Group 5', 'Dermatology', 'Quit', '1981-08-18', '6fb92e1d3c15607f5fe3d04e0f9c4c410478aa7424f25b75f6b7c444c960207e', 'Emergency Contact 42', '1286094151', 'POL63163', '567 Elm St', 'assets/patient42.jpg', 'No notes', '2024-09-16 02:31:23', '2024-10-08 06:30:47'),
(43, 'Michael Lee', 'patient43@care.com', '1330680991', 'Group 5', 'Neurology', 'Rest', '1999-09-05', '361fdc2148ff43d0f681e44b0047aca835826f99d1242518ea96dcda37d9716b', 'Emergency Contact 43', '1188285394', 'POL86871', '154 Elm St', 'assets/patient43.jpg', 'No known allergies', '2024-09-22 02:31:23', '2024-10-08 06:30:47'),
(44, 'Ethan Davis', 'patient44@care.com', '1498463772', 'Group 5', 'Orthopedics', 'Quit', '2003-04-23', 'f1c6aa3a36b80b981b82e79cb6966e4fe9890119213211e55d2c0ea4829282c2', 'Emergency Contact 44', '1175922987', 'POL59937', '499 Elm St', 'assets/patient44.jpg', 'No known allergies', '2024-10-04 02:31:23', '2024-10-08 06:30:47'),
(45, 'Mia Lewis', 'patient45@care.com', '1101350804', 'Group 2', 'Dermatology', 'Online', '2007-03-24', '122d87937045505ca921baa966343d2a88383e68fdf708629bff3a7bfdf4e5de', 'Emergency Contact 45', '1581381887', 'POL29860', '438 Elm St', 'assets/patient45.jpg', 'No notes', '2024-09-22 02:31:23', '2024-10-08 06:30:47'),
(46, 'Grace Garcia', 'patient46@care.com', '1105764092', 'Group 5', 'Pediatrics', 'Online', '1987-08-06', 'ade3dbec85ba5f0c2620574f5973cbcfaccf1246bba0f18ee571f43ffe5a30fd', 'Emergency Contact 46', '1427513041', 'POL94545', '264 Elm St', 'assets/patient46.jpg', 'Asthma patient', '2024-09-17 02:31:23', '2024-10-08 06:30:47'),
(47, 'Daniel Martinez', 'patient47@care.com', '1279013974', 'Group 4', 'Neurology', 'Quit', '2008-09-26', '8b4956c218392f8ce8f27601c7ce06fe807cc4a05556289b3713979430a9c959', 'Emergency Contact 47', '1998175102', 'POL90008', '681 Elm St', 'assets/patient47.jpg', 'High blood pressure', '2024-09-18 02:31:23', '2024-10-08 06:30:47'),
(48, 'Lucas Jackson', 'patient48@care.com', '1124698251', 'Group 5', 'Oncology', 'Quit', '2005-02-11', '2c5cd4215e208e2cbe289b123a3224ca1421d7b99973703ec1d675b5ef323c46', 'Emergency Contact 48', '1582502574', 'POL44921', '633 Elm St', 'assets/patient48.jpg', 'Asthma patient', '2024-09-21 02:31:23', '2024-10-08 06:30:47'),
(49, 'Olivia White', 'patient49@care.com', '1458768647', 'Group 1', 'Dermatology', 'Quit', '2007-12-18', 'c935ae15b8f5dfb1c915543288542dd10996ea13aa4793ab268c4714369a2084', 'Emergency Contact 49', '1816972335', 'POL46571', '137 Elm St', 'assets/patient49.jpg', 'No known allergies', '2024-09-11 02:31:23', '2024-10-08 06:30:47'),
(50, 'Sophia Rodriguez', 'patient50@care.com', '1789717767', 'Group 1', 'Oncology', 'Rest', '1984-02-21', 'd61a2e118ed6e4fb51cda8f70712c313aeba248cf8b990b096d57d325c272e5e', 'Emergency Contact 50', '1170950512', 'POL50412', '726 Elm St', 'assets/patient50.jpg', 'Diabetic', '2024-09-23 02:31:23', '2024-10-08 06:30:47'),
(51, 'David Rodriguez', 'patient51@care.com', '1651632879', 'Group 5', 'Orthopedics', 'Quit', '2017-06-11', '637b70039d19134b9dfbeb578013b31f2f1946ff51936c3555018bbfe43fc49a', 'Emergency Contact 51', '1329072267', 'POL36894', '846 Elm St', 'assets/patient51.jpg', 'Diabetic', '2024-09-23 02:31:23', '2024-10-08 06:30:47'),
(52, 'James Davis', 'patient52@care.com', '1180795938', 'Group 3', 'Dermatology', 'Online', '1987-01-19', 'a31c7759c76b54d33ac0682fe779e0e7a6fbeca39c72f1acd30389a58b9f3f35', 'Emergency Contact 52', '1403487765', 'POL64778', '255 Elm St', 'assets/patient52.jpg', 'High blood pressure', '2024-09-10 02:31:23', '2024-10-08 06:30:47'),
(53, 'Emma Lee', 'patient53@care.com', '1468261770', 'Group 4', 'Dermatology', 'Rest', '2019-03-11', 'b8de5b5148624fb97d1a0435b56c80245f459508e47ce1f50463fa495f27c6bd', 'Emergency Contact 53', '1674917857', 'POL99073', '584 Elm St', 'assets/patient53.jpg', 'Asthma patient', '2024-09-10 02:31:23', '2024-10-08 06:30:47'),
(54, 'Emily Brown', 'patient54@care.com', '1216748204', 'Group 3', 'Oncology', 'Quit', '2012-02-07', '27b10e3eff95391abd8782e3e91482346c7dcf6c0182664d309ee01c323d9ba3', 'Emergency Contact 54', '1421025711', 'POL73096', '782 Elm St', 'assets/patient54.jpg', 'Asthma patient', '2024-09-23 02:31:23', '2024-10-08 06:30:47'),
(55, 'Sarah Rodriguez', 'patient55@care.com', '1431702419', 'Group 4', 'Pediatrics', 'Online', '1995-01-10', '50b008e7770ed516cc13a9d9fffb24df199e4c910f339d02627482832e26699e', 'Emergency Contact 55', '1942492763', 'POL12472', '502 Elm St', 'assets/patient55.jpg', 'Asthma patient', '2024-09-15 02:31:23', '2024-10-08 06:30:47'),
(56, 'Ethan Taylor', 'patient56@care.com', '1549098330', 'Group 1', 'Orthopedics', 'Quit', '1995-05-02', '00568ec3b118987c395daec3be38ca7cb0f6ab09af6d412e24c38dde2e9ff9da', 'Emergency Contact 56', '1113270547', 'POL63239', '304 Elm St', 'assets/patient56.jpg', 'Diabetic', '2024-09-21 02:31:23', '2024-10-08 06:30:47'),
(57, 'Michael Miller', 'patient57@care.com', '1439743618', 'Group 1', 'Orthopedics', 'Online', '2000-11-18', '680038ceebe84350cf9746e180ea307aeb2f1ab1e0a8658c95a0219056a88a28', 'Emergency Contact 57', '1992259116', 'POL15409', '848 Elm St', 'assets/patient57.jpg', 'No known allergies', '2024-09-28 02:31:23', '2024-10-08 06:30:47'),
(58, 'Olivia Miller', 'patient58@care.com', '1295805092', 'Group 2', 'Orthopedics', 'Online', '1987-07-04', '4a8b075e174fb0e2fc5bfd1d9b8fe276f8c74de6d0a6a8adb7ca440427287180', 'Emergency Contact 58', '1410934319', 'POL56603', '884 Elm St', 'assets/patient58.jpg', 'No notes', '2024-09-26 02:31:23', '2024-10-08 06:30:47'),
(59, 'James Brown', 'patient59@care.com', '1694138919', 'Group 4', 'Orthopedics', 'Online', '1988-02-07', '6f2febb63292f2e3ed0170bc6e6cc871a9bd19fa5a07a6b6c999db206ea5a496', 'Emergency Contact 59', '1908792209', 'POL54119', '424 Elm St', 'assets/patient59.jpg', 'Asthma patient', '2024-09-23 02:31:23', '2024-10-08 06:30:47'),
(60, 'Michael Anderson', 'patient60@care.com', '1807769485', 'Group 1', 'Neurology', 'Quit', '1999-02-07', 'c79a02f1338a151977762d12a722137dcd5d1fc8446739b6d3e5a0e766c46921', 'Emergency Contact 60', '1416956882', 'POL61371', '739 Elm St', 'assets/patient60.jpg', 'High blood pressure', '2024-09-30 02:31:23', '2024-10-08 06:30:47'),
(61, 'Emily Harris', 'patient61@care.com', '1763198967', 'Group 3', 'Dermatology', 'Quit', '1993-09-12', '9fa632f098771015189c4ea79f314cdbce76981bc13c6c8d10ca56bd84ae5975', 'Emergency Contact 61', '1140071324', 'POL52335', '707 Elm St', 'assets/patient61.jpg', 'High blood pressure', '2024-09-09 02:31:23', '2024-10-08 06:30:47'),
(62, 'Jane Jackson', 'patient62@care.com', '1335476582', 'Group 5', 'Pediatrics', 'Rest', '2012-10-13', 'e6b8aab3da560548bf863feef75b35dce158027e021f7f1429c28e587098094b', 'Emergency Contact 62', '1487506548', 'POL26163', '245 Elm St', 'assets/patient62.jpg', 'High blood pressure', '2024-10-02 02:31:23', '2024-10-08 06:30:47'),
(63, 'Emma Clark', 'patient63@care.com', '1944784326', 'Group 5', 'Neurology', 'Quit', '2000-09-21', 'e395fe2583f7d61b66b1735bd9af71282cc96598afa066b28f29bcb453e00e77', 'Emergency Contact 63', '1493209742', 'POL64715', '324 Elm St', 'assets/patient63.jpg', 'No known allergies', '2024-09-14 02:31:23', '2024-10-08 06:30:47'),
(64, 'Grace Clark', 'patient64@care.com', '1118754343', 'Group 5', 'Oncology', 'Quit', '1994-04-07', '6e1c22700b1ccd9bdf9f33791551a260ceb4590764bbc06438af4360996eaac1', 'Emergency Contact 64', '1693387015', 'POL17156', '205 Elm St', 'assets/patient64.jpg', 'Asthma patient', '2024-09-30 02:31:23', '2024-10-08 06:30:47'),
(65, 'Jane Thompson', 'patient65@care.com', '1584105446', 'Group 3', 'Dermatology', 'Rest', '2004-07-27', '11912b7f7d8d5dc3ee2220a7e7087512f420160c4653078bde70a6a28be2c1fe', 'Emergency Contact 65', '1697628766', 'POL50537', '645 Elm St', 'assets/patient65.jpg', 'Asthma patient', '2024-09-27 02:31:23', '2024-10-08 06:30:47'),
(66, 'John Clark', 'patient66@care.com', '1509535099', 'Group 4', 'Orthopedics', 'Rest', '2010-06-24', '2133417716a4d5665e6fc8f90e39471c3b0b54d329d8c5171652b429b77b15bb', 'Emergency Contact 66', '1433784280', 'POL24429', '976 Elm St', 'assets/patient66.jpg', 'High blood pressure', '2024-09-28 02:31:23', '2024-10-08 06:30:47'),
(67, 'John Anderson', 'patient67@care.com', '1422839588', 'Group 3', 'Oncology', 'Quit', '2008-08-21', 'cb0cc0e078f7bfa468f19045b51e3128f6d5fc72e8b1c242998074e309aa3d2e', 'Emergency Contact 67', '1774971953', 'POL33184', '435 Elm St', 'assets/patient67.jpg', 'No notes', '2024-09-10 02:31:23', '2024-10-08 06:30:47'),
(68, 'Emily Clark', 'patient68@care.com', '1244185315', 'Group 2', 'Pediatrics', 'Quit', '2013-12-19', '39001ab3e4263b0a4dd9494c0e2cb1f9e3679ad8daa3d474e7127579ba1dc18f', 'Emergency Contact 68', '1762368616', 'POL15573', '132 Elm St', 'assets/patient68.jpg', 'Diabetic', '2024-09-08 02:31:23', '2024-10-08 06:30:47'),
(69, 'Emily Martinez', 'patient69@care.com', '1996952655', 'Group 5', 'Oncology', 'Quit', '2019-08-23', 'f851f22a65d44d3ead8ba2c60b8d6427ec30a93536344fb7a7cd36d2838cd2d0', 'Emergency Contact 69', '1687648076', 'POL28248', '427 Elm St', 'assets/patient69.jpg', 'Diabetic', '2024-09-14 02:31:23', '2024-10-08 06:30:47'),
(70, 'Olivia Thompson', 'patient70@care.com', '1155569068', 'Group 1', 'Neurology', 'Online', '2015-08-12', 'eed04bfcf1e04736a06a5a521b118980b84bd0aef34a29e59c71bdf09b256472', 'Emergency Contact 70', '1135417792', 'POL27618', '361 Elm St', 'assets/patient70.jpg', 'No known allergies', '2024-09-29 02:31:23', '2024-10-08 06:30:47'),
(71, 'Olivia Martinez', 'patient71@care.com', '1541695108', 'Group 3', 'Orthopedics', 'Online', '1986-07-13', '926ecb68f1e9e7b117c646f951bd5ad4cb1fb8ae16d335bad9db7610f2732d46', 'Emergency Contact 71', '1347650154', 'POL65490', '573 Elm St', 'assets/patient71.jpg', 'Asthma patient', '2024-10-02 02:31:23', '2024-10-08 06:30:47'),
(72, 'Benjamin Lewis', 'patient72@care.com', '1593804941', 'Group 1', 'Dermatology', 'Online', '1988-07-12', '41b84d5f5214405308961b2d5bc614c604f46ba63e4a35c286c5910a529f66b6', 'Emergency Contact 72', '1476187273', 'POL88978', '226 Elm St', 'assets/patient72.jpg', 'No known allergies', '2024-09-15 02:31:23', '2024-10-08 06:30:47'),
(73, 'James Johnson', 'patient73@care.com', '1573211411', 'Group 3', 'Dermatology', 'Rest', '2019-01-18', '74d6df27afe55a74757d6971ae344759ee1b1b5d742c0512c73b957f9fe862ac', 'Emergency Contact 73', '1653156381', 'POL45308', '721 Elm St', 'assets/patient73.jpg', 'Diabetic', '2024-09-23 02:31:23', '2024-10-08 06:30:47'),
(74, 'Benjamin Martinez', 'patient74@care.com', '1856304651', 'Group 5', 'Neurology', 'Online', '1986-12-02', '7e1d6a637d80d635a744dced4f396dc27531275af7ccdc7a2d9f8a897ceac90e', 'Emergency Contact 74', '1336700078', 'POL50894', '458 Elm St', 'assets/patient74.jpg', 'Asthma patient', '2024-09-26 02:31:23', '2024-10-08 06:30:47'),
(75, 'Liam Davis', 'patient75@care.com', '1122874261', 'Group 4', 'Dermatology', 'Quit', '1987-01-19', '1b602f08834fb07ec8796b101cda2146b41171f8b8facd1b4621acc78c509b0e', 'Emergency Contact 75', '1193014898', 'POL53998', '485 Elm St', 'assets/patient75.jpg', 'No notes', '2024-09-20 02:31:23', '2024-10-08 06:30:47'),
(76, 'James Johnson', 'patient76@care.com', '1509153276', 'Group 3', 'Dermatology', 'Rest', '1991-06-13', '115256583e1f78f6437b478c5941355476d3275dc1b4fce61ad8970bc1d88f83', 'Emergency Contact 76', '1720836730', 'POL63610', '638 Elm St', 'assets/patient76.jpg', 'Asthma patient', '2024-09-15 02:31:23', '2024-10-08 06:30:47'),
(77, 'John Taylor', 'patient77@care.com', '1590634276', 'Group 2', 'Pediatrics', 'Quit', '2017-08-03', '2a69a8c2d1889d97bae6e746534d7a55032852b3485ef563fca91c193bd4cbd3', 'Emergency Contact 77', '1701934920', 'POL91771', '398 Elm St', 'assets/patient77.jpg', 'No known allergies', '2024-09-28 02:31:23', '2024-10-08 06:30:47'),
(78, 'Anna Lewis', 'patient78@care.com', '1123257814', 'Group 3', 'Oncology', 'Rest', '1989-11-11', '3c13751ee13afddf4347722f25d82194028011c743bcedd053a580cf17a66dd1', 'Emergency Contact 78', '1222429815', 'POL62727', '654 Elm St', 'assets/patient78.jpg', 'No known allergies', '2024-10-04 02:31:23', '2024-10-08 06:30:47'),
(79, 'Emily Jackson', 'patient79@care.com', '1348217075', 'Group 1', 'Dermatology', 'Online', '1994-10-03', '7b4239ab0b02db162ebed866423ae7863f280db16d68ac12d8389c3949df123a', 'Emergency Contact 79', '1119836207', 'POL30511', '386 Elm St', 'assets/patient79.jpg', 'Asthma patient', '2024-09-17 02:31:23', '2024-10-08 06:30:47'),
(80, 'Benjamin Lewis', 'patient80@care.com', '1418721693', 'Group 1', 'Orthopedics', 'Online', '1998-06-19', '545055762c27d5bb0185b65d3f2a647fd10f5fedd7b6163a1f755a107456e42d', 'Emergency Contact 80', '1403359612', 'POL30715', '206 Elm St', 'assets/patient80.jpg', 'No notes', '2024-09-27 02:31:23', '2024-10-08 06:30:47'),
(81, 'Jane Anderson', 'patient81@care.com', '1160089236', 'Group 4', 'Orthopedics', 'Online', '2003-11-02', '3ea67d2984825f3e988554d55696d7380ccb7394c7be194f208d97d960439816', 'Emergency Contact 81', '1592164260', 'POL61709', '635 Elm St', 'assets/patient81.jpg', 'Diabetic', '2024-09-23 02:31:23', '2024-10-08 06:30:47'),
(82, 'Mia Jackson', 'patient82@care.com', '1184978514', 'Group 2', 'Oncology', 'Quit', '1980-03-28', 'd5aaa4394aaa3f36e753f6a2becce024119bbe35c744d98821c3a75d66695e09', 'Emergency Contact 82', '1176671034', 'POL39416', '624 Elm St', 'assets/patient82.jpg', 'High blood pressure', '2024-09-28 02:31:23', '2024-10-08 06:30:47'),
(83, 'Liam Lewis', 'patient83@care.com', '1749552465', 'Group 5', 'Orthopedics', 'Online', '2000-12-04', 'd930d0fdb0917388c157471d6a928a3e3a863fcb27d2838b67d04653ec9a8fbb', 'Emergency Contact 83', '1874461247', 'POL92397', '615 Elm St', 'assets/patient83.jpg', 'No known allergies', '2024-09-13 02:31:23', '2024-10-08 06:30:47'),
(84, 'Mia Brown', 'patient84@care.com', '1594637125', 'Group 2', 'Pediatrics', 'Rest', '1982-06-07', '5de4e4e3202617b1d2c1e219774a33230a5d26a15ee9de566ea3d90593dc17a4', 'Emergency Contact 84', '1629856105', 'POL22894', '626 Elm St', 'assets/patient84.jpg', 'High blood pressure', '2024-09-14 02:31:23', '2024-10-08 06:30:47'),
(85, 'Jane Lewis', 'patient85@care.com', '1253531138', 'Group 3', 'Neurology', 'Quit', '2011-09-02', 'a0a632ae289d3dd163daba4650670d78ec1236ad684f9a04c2b87da5472495a7', 'Emergency Contact 85', '1293259547', 'POL89674', '362 Elm St', 'assets/patient85.jpg', 'No known allergies', '2024-09-16 02:31:23', '2024-10-08 06:30:47'),
(86, 'Olivia Rodriguez', 'patient86@care.com', '1409655591', 'Group 4', 'Oncology', 'Quit', '2000-05-17', 'c553d70ea9178380fbdd9a8b7b62490087aba6a1279cd89851a85ac371a0a676', 'Emergency Contact 86', '1978040349', 'POL60961', '940 Elm St', 'assets/patient86.jpg', 'Diabetic', '2024-09-23 02:31:23', '2024-10-08 06:30:47'),
(87, 'Mia Harris', 'patient87@care.com', '1158711446', 'Group 4', 'Dermatology', 'Rest', '1980-04-04', 'f8ecd4b60b1dde773633bda23647343238c34a8651b124b1220e9b3affc26e57', 'Emergency Contact 87', '1837876291', 'POL95256', '484 Elm St', 'assets/patient87.jpg', 'Diabetic', '2024-10-03 02:31:23', '2024-10-08 06:30:47'),
(88, 'Benjamin Smith', 'patient88@care.com', '1222096822', 'Group 2', 'Oncology', 'Quit', '1987-12-27', 'dd68d22c622350f2b9bd85ac9855a56d84d08d01bb7e6fdf7780281d28bb641d', 'Emergency Contact 88', '1672963472', 'POL92832', '609 Elm St', 'assets/patient88.jpg', 'Asthma patient', '2024-09-30 02:31:23', '2024-10-08 06:30:47'),
(89, 'Michael Miller', 'patient89@care.com', '1996461696', 'Group 3', 'Pediatrics', 'Online', '1991-04-10', '9fc03f415b5f7eb4b55f99f484dc7546d3e6c995ed644a68ba877265c6f9b75b', 'Emergency Contact 89', '1404015769', 'POL61138', '814 Elm St', 'assets/patient89.jpg', 'No notes', '2024-09-09 02:31:23', '2024-10-08 06:30:47'),
(90, 'Laura Miller', 'patient90@care.com', '1775000855', 'Group 1', 'Dermatology', 'Quit', '2007-09-03', '3e46a2ab98cf95ffd02b704f02bc771452ded3a08e50a41eee6b5c8d18dec361', 'Emergency Contact 90', '1252676112', 'POL68147', '362 Elm St', 'assets/patient90.jpg', 'High blood pressure', '2024-09-20 02:31:23', '2024-10-08 06:30:47'),
(91, 'Daniel Garcia', 'patient91@care.com', '1592235920', 'Group 2', 'Dermatology', 'Online', '1986-01-17', '6bdaaa896caaa680570df2a2540484f0990bb613fc2f914ee04a110895878d5f', 'Emergency Contact 91', '1445147931', 'POL12702', '827 Elm St', 'assets/patient91.jpg', 'No notes', '2024-09-24 02:31:23', '2024-10-08 06:30:47'),
(92, 'John Harris', 'patient92@care.com', '1767386096', 'Group 4', 'Orthopedics', 'Rest', '1986-10-13', '55cc6a22b5d96448f996e19154703a8b5f019771d3027ed77162c0075c8944e6', 'Emergency Contact 92', '1921892609', 'POL62606', '959 Elm St', 'assets/patient92.jpg', 'Asthma patient', '2024-09-27 02:31:23', '2024-10-08 06:30:47'),
(93, 'Benjamin Smith', 'patient93@care.com', '1354163732', 'Group 3', 'Neurology', 'Rest', '2005-09-20', '42c0ebcc9f551e2086ddbb4049a830f413ea9876419d76d9c63f40ca549c11a9', 'Emergency Contact 93', '1893586569', 'POL76221', '135 Elm St', 'assets/patient93.jpg', 'High blood pressure', '2024-09-15 02:31:23', '2024-10-08 06:30:47'),
(94, 'Liam Johnson', 'patient94@care.com', '1207004329', 'Group 5', 'Neurology', 'Rest', '1991-04-01', 'fbdc64c3d7e68e0f739e28b99a11bb2f53a3b64c4c7e139f27d1a2cb8fe67529', 'Emergency Contact 94', '1146219972', 'POL96506', '710 Elm St', 'assets/patient94.jpg', 'Diabetic', '2024-09-27 02:31:23', '2024-10-08 06:30:47'),
(95, 'James Jackson', 'patient95@care.com', '1510349915', 'Group 3', 'Oncology', 'Quit', '1999-10-07', '50116f996e5112e63b75d8fd29f06f02ece1f060411793390899836a37202198', 'Emergency Contact 95', '1772544096', 'POL39039', '889 Elm St', 'assets/patient95.jpg', 'Diabetic', '2024-10-01 02:31:23', '2024-10-08 06:30:47'),
(96, 'Grace Johnson', 'patient96@care.com', '1293843421', 'Group 1', 'Neurology', 'Quit', '2014-12-18', '4716996dc64a66308869ddae417bf4724188aa1cb7cf894adac841b8cfabada3', 'Emergency Contact 96', '1852247571', 'POL60519', '434 Elm St', 'assets/patient96.jpg', 'High blood pressure', '2024-09-26 02:31:23', '2024-10-08 06:30:47'),
(97, 'Ethan Moore', 'patient97@care.com', '1554144491', 'Group 2', 'Dermatology', 'Quit', '2009-04-01', '17cf65b93f1e289f395b5336c54f4d1f381b1b7e13e030e0975004f4755da06c', 'Emergency Contact 97', '1168648492', 'POL50218', '567 Elm St', 'assets/patient97.jpg', 'Diabetic', '2024-09-26 02:31:23', '2024-10-08 06:30:47'),
(98, 'Jane Lewis', 'patient98@care.com', '1548062338', 'Group 2', 'Pediatrics', 'Online', '2006-04-12', '5fc73ff762ee3e4ec15665b3bfbdb5e32c3ddf636bb83508cf39dd7498504866', 'Emergency Contact 98', '1196640445', 'POL96035', '552 Elm St', 'assets/patient98.jpg', 'No known allergies', '2024-09-12 02:31:23', '2024-10-08 06:30:47'),
(99, 'Liam Martinez', 'patient99@care.com', '1181948114', 'Group 2', 'Orthopedics', 'Quit', '1991-07-25', '04d5f4ad4b60fa31c0d48a28226fb08b713e900aeab64944005c35c60943e21e', 'Emergency Contact 99', '1236880237', 'POL18150', '529 Elm St', 'assets/patient99.jpg', 'No known allergies', '2024-09-12 02:31:23', '2024-10-08 06:30:47'),
(100, 'Liam Miller', 'patient100@care.com', '1275975426', 'Group 3', 'Pediatrics', 'Online', '2007-02-19', '2f7d8e6a615ea77d9e04f0e21da283320dfb9f23282cc7460e65fd1e454a4cb8', 'Emergency Contact 100', '1202573643', 'POL26926', '671 Elm St', 'assets/patient100.jpg', 'High blood pressure', '2024-09-26 02:31:23', '2024-10-08 06:30:47'),
(101, 'Robert Rodriguez', 'patient101@care.com', '1567120018', 'Group 1', 'Pediatrics', 'Quit', '1996-01-13', 'e5b5f966dd4d2a68cac1993020a375862d8a5890d2db3f3b41b3aba412d8f99d', 'Emergency Contact 101', '1105147477', 'POL33943', '572 Elm St', 'assets/patient101.jpg', 'High blood pressure', '2024-09-12 02:31:23', '2024-10-08 06:30:47'),
(102, 'David Taylor', 'patient102@care.com', '1573120822', 'Group 3', 'Dermatology', 'Quit', '1999-12-09', 'd2836e3f66fd7e8c4e586a56fcfa6dfbe423391116c65ad6882db627f7b07fa4', 'Emergency Contact 102', '1610688754', 'POL91714', '618 Elm St', 'assets/patient102.jpg', 'Asthma patient', '2024-09-10 02:31:23', '2024-10-08 06:30:47'),
(103, 'Lucas Rodriguez', 'patient103@care.com', '1684557687', 'Group 4', 'Neurology', 'Quit', '2002-01-24', '657d9afcd254c620c4315827427245881ed02297fc2dfa842cf88ed18b1ee143', 'Emergency Contact 103', '1440433340', 'POL18004', '887 Elm St', 'assets/patient103.jpg', 'No notes', '2024-09-12 02:31:23', '2024-10-08 06:30:47'),
(104, 'Benjamin Lewis', 'patient104@care.com', '1536844445', 'Group 1', 'Pediatrics', 'Online', '1998-06-15', '984b357b126c516bbbfb6381777138747417b9442db00e7f0c944d0b025c304d', 'Emergency Contact 104', '1397678389', 'POL79707', '653 Elm St', 'assets/patient104.jpg', 'No known allergies', '2024-10-04 02:31:23', '2024-10-08 06:30:47'),
(105, 'Benjamin Clark', 'patient105@care.com', '1206585769', 'Group 1', 'Dermatology', 'Rest', '2000-04-25', '655015a4baa4ae0759f9c8db8f537e1f04e5067aca3ba02c5ab23dca7a76c9db', 'Emergency Contact 105', '1984337542', 'POL72585', '116 Elm St', 'assets/patient105.jpg', 'No known allergies', '2024-09-24 02:31:23', '2024-10-08 06:30:47'),
(106, 'Grace Davis', 'patient106@care.com', '1581390662', 'Group 3', 'Dermatology', 'Rest', '2006-02-22', 'dbe035931d91e753f8f5e7389fb7598523eb7c3d334d02283f94351e4951b0e6', 'Emergency Contact 106', '1299606227', 'POL19419', '445 Elm St', 'assets/patient106.jpg', 'No notes', '2024-09-16 02:31:23', '2024-10-08 06:30:47'),
(107, 'David Brown', 'patient107@care.com', '1832995853', 'Group 3', 'Dermatology', 'Online', '2008-05-25', 'e5e2dc3d03cf4962aac3d21e986a80dbcd8cf51e72acc89498152a88890c0a57', 'Emergency Contact 107', '1487524682', 'POL75339', '166 Elm St', 'assets/patient107.jpg', 'No notes', '2024-09-11 02:31:23', '2024-10-08 06:30:47'),
(108, 'Liam Jackson', 'patient108@care.com', '1393558812', 'Group 3', 'Dermatology', 'Rest', '1995-09-28', '84b17d2e45bee1705652fa232a941ca2190d9f56d579d0ab76de7e341863f3b2', 'Emergency Contact 108', '1961378518', 'POL56317', '311 Elm St', 'assets/patient108.jpg', 'No known allergies', '2024-10-05 02:31:23', '2024-10-08 06:30:47'),
(109, 'Olivia Garcia', 'patient109@care.com', '1398668390', 'Group 3', 'Oncology', 'Quit', '1989-05-26', 'cfbbdaada04a3dce25fb58813f4ce151f0fdbba330142ffdd5b511f77327916e', 'Emergency Contact 109', '1297431670', 'POL96423', '680 Elm St', 'assets/patient109.jpg', 'Asthma patient', '2024-09-14 02:31:23', '2024-10-08 06:30:47'),
(110, 'Liam Martinez', 'patient110@care.com', '1715317354', 'Group 1', 'Neurology', 'Rest', '2000-03-04', '4b9b800464d5b0d86b391f313e88a9d2378549f881978ba085f8220edf831689', 'Emergency Contact 110', '1190506746', 'POL88917', '666 Elm St', 'assets/patient110.jpg', 'Asthma patient', '2024-10-05 02:31:23', '2024-10-08 06:30:47'),
(111, 'David Moore', 'patient111@care.com', '1803485056', 'Group 3', 'Oncology', 'Online', '2006-06-01', 'e4078a8a43c8323f20213130b877ddbe05bb267007713f9ee3b23eecc7979430', 'Emergency Contact 111', '1770093142', 'POL31623', '761 Elm St', 'assets/patient111.jpg', 'No known allergies', '2024-09-19 02:31:23', '2024-10-08 06:30:47'),
(112, 'Mia Moore', 'patient112@care.com', '1626270261', 'Group 3', 'Dermatology', 'Quit', '2010-12-22', '6b7c57f75fb72a250b90704f02814ff763f0e30687cb526e768d18ba8f20479b', 'Emergency Contact 112', '1479279302', 'POL39626', '366 Elm St', 'assets/patient112.jpg', 'High blood pressure', '2024-10-03 02:31:23', '2024-10-08 06:30:47'),
(113, 'Ethan Lewis', 'patient113@care.com', '1266686011', 'Group 5', 'Neurology', 'Rest', '1986-02-10', '9219f8c729ceb17892f3aac230345359674838bac1341eb17dd84e21f4b7badd', 'Emergency Contact 113', '1699722724', 'POL17114', '890 Elm St', 'assets/patient113.jpg', 'No known allergies', '2024-09-24 02:31:23', '2024-10-08 06:30:47'),
(114, 'Michael White', 'patient114@care.com', '1820115963', 'Group 5', 'Dermatology', 'Online', '1990-08-27', '411b8551d1fed826f5adb31a73a4a9a3e61734da3684313c21d88545b6b5f3d5', 'Emergency Contact 114', '1965914130', 'POL89712', '490 Elm St', 'assets/patient114.jpg', 'Asthma patient', '2024-09-06 02:31:23', '2024-10-08 06:30:47'),
(115, 'Benjamin Martinez', 'patient115@care.com', '1219286388', 'Group 4', 'Neurology', 'Online', '2000-09-16', '8157d7f5f8746c4252bbf0a5181a767d047e8cdb76b8e0015ca8f6619a8bb376', 'Emergency Contact 115', '1358483671', 'POL38847', '910 Elm St', 'assets/patient115.jpg', 'No notes', '2024-09-25 02:31:23', '2024-10-08 06:30:47'),
(116, 'David Wilson', 'patient116@care.com', '1639166065', 'Group 3', 'Pediatrics', 'Rest', '1986-04-05', 'fa7fadaaad3e589fc28635daa5754e5c43649ca2ad49daeb1a3703b49263d121', 'Emergency Contact 116', '1238768620', 'POL44010', '840 Elm St', 'assets/patient116.jpg', 'Diabetic', '2024-09-14 02:31:23', '2024-10-08 06:30:47'),
(117, 'Mia Garcia', 'patient117@care.com', '1310290676', 'Group 2', 'Orthopedics', 'Online', '2018-03-17', '61ebe9bc76b2c8b122700f675280959d21052e6130a516bd75b4c3acf7763146', 'Emergency Contact 117', '1907948120', 'POL40020', '850 Elm St', 'assets/patient117.jpg', 'No known allergies', '2024-10-05 02:31:23', '2024-10-08 06:30:47'),
(118, 'Mia Walker', 'patient118@care.com', '1980998015', 'Group 3', 'Oncology', 'Quit', '2002-03-04', '2db36280c01eced031d48f16bc670f90052f63a3015057396919d36364e68345', 'Emergency Contact 118', '1548934775', 'POL87050', '108 Elm St', 'assets/patient118.jpg', 'High blood pressure', '2024-09-09 02:31:23', '2024-10-08 06:30:47'),
(119, 'Sarah Brown', 'patient119@care.com', '1920121754', 'Group 2', 'Pediatrics', 'Quit', '1986-03-20', 'b3b45a2929c292b12d2839ed4ff525236443a394ca2ed38469ab4abcd9919326', 'Emergency Contact 119', '1238689907', 'POL95776', '474 Elm St', 'assets/patient119.jpg', 'No notes', '2024-09-21 02:31:23', '2024-10-08 06:30:47'),
(120, 'Olivia Clark', 'patient120@care.com', '1424950185', 'Group 2', 'Pediatrics', 'Rest', '2002-06-21', 'ff2eb5ea8addbd21666fe01880b4e153a54bdfde83a926a34d2713ff7962b311', 'Emergency Contact 120', '1669916354', 'POL46768', '867 Elm St', 'assets/patient120.jpg', 'High blood pressure', '2024-10-04 02:31:23', '2024-10-08 06:30:47'),
(121, 'James Harris', 'patient121@care.com', '1988120666', 'Group 5', 'Dermatology', 'Rest', '1995-04-24', 'afaa7c7d8662bd19e5fec019a1b3ae47ddcb64de4ac2e4d1712ef088b7ca1b68', 'Emergency Contact 121', '1143824673', 'POL52338', '911 Elm St', 'assets/patient121.jpg', 'Diabetic', '2024-09-25 02:31:23', '2024-10-08 06:30:47'),
(122, 'Sarah Wilson', 'patient122@care.com', '1812079590', 'Group 4', 'Orthopedics', 'Quit', '2013-12-07', 'a9dba4ecf67949ad387b0db002a1f003102cb9e55ce94238b43edce4c00ec39e', 'Emergency Contact 122', '1854273557', 'POL72770', '427 Elm St', 'assets/patient122.jpg', 'Diabetic', '2024-09-18 02:31:23', '2024-10-08 06:30:47'),
(123, 'Olivia Brown', 'patient123@care.com', '1371571906', 'Group 1', 'Pediatrics', 'Rest', '2004-09-06', '1fa2b09bac2ff72e74606e352a8b32bc6fa36a65db64736bf1dc861f097563aa', 'Emergency Contact 123', '1637726270', 'POL99386', '164 Elm St', 'assets/patient123.jpg', 'High blood pressure', '2024-09-15 02:31:23', '2024-10-08 06:30:47'),
(124, 'Laura Martinez', 'patient124@care.com', '1612901078', 'Group 1', 'Pediatrics', 'Online', '2007-05-02', '3fdd0a49947267792ad04cbc6306b6a80393f1d04192d112c773e8395a6782f6', 'Emergency Contact 124', '1994152321', 'POL15317', '413 Elm St', 'assets/patient124.jpg', 'No known allergies', '2024-09-12 02:31:23', '2024-10-08 06:30:47'),
(125, 'Benjamin Harris', 'patient125@care.com', '1933527771', 'Group 1', 'Dermatology', 'Rest', '2014-01-09', '6cad584af8a6a596316cbeaed6c0d3a927a6887b312bb3ff52b6cddbfa7fae74', 'Emergency Contact 125', '1326725102', 'POL48380', '448 Elm St', 'assets/patient125.jpg', 'Diabetic', '2024-09-21 02:31:23', '2024-10-08 06:30:47'),
(126, 'Mia Martinez', 'patient126@care.com', '1874763268', 'Group 1', 'Neurology', 'Quit', '1999-07-24', '79b7c6b8f9f8f6fecbb981909e8ce191d3fa634090b15cff58130475bcf0d682', 'Emergency Contact 126', '1930501888', 'POL71561', '715 Elm St', 'assets/patient126.jpg', 'Asthma patient', '2024-09-28 02:31:23', '2024-10-08 06:30:47'),
(127, 'John Wilson', 'patient127@care.com', '1759458162', 'Group 5', 'Oncology', 'Online', '1983-06-21', 'a4c4dcb9cc08018fa319fe0e673f3eaaff88ba257b6e4662380d369acd83d6c4', 'Emergency Contact 127', '1100486428', 'POL62223', '527 Elm St', 'assets/patient127.jpg', 'No notes', '2024-10-01 02:31:23', '2024-10-08 06:30:47'),
(128, 'David Harris', 'patient128@care.com', '1970600979', 'Group 5', 'Neurology', 'Rest', '2013-10-24', 'ab6ad06b4c3fcd4fd424b4b82d05ee0e72ea6e916d42d90396da8658fc544489', 'Emergency Contact 128', '1352678177', 'POL98867', '238 Elm St', 'assets/patient128.jpg', 'No known allergies', '2024-09-20 02:31:23', '2024-10-08 06:30:47'),
(129, 'Daniel Brown', 'patient129@care.com', '1100532112', 'Group 1', 'Neurology', 'Quit', '1995-05-20', '9fa795ece4a9f07f8cde9d7d5383b8272e189c38da1a95fc73a0ef73a61fb8e2', 'Emergency Contact 129', '1271842249', 'POL97659', '702 Elm St', 'assets/patient129.jpg', 'Asthma patient', '2024-09-15 02:31:23', '2024-10-08 06:30:47'),
(130, 'Benjamin Davis', 'patient130@care.com', '1205488794', 'Group 2', 'Orthopedics', 'Online', '2008-06-26', 'ff944e9113a0ee41345e5334232630b00a4d2bda390107cf325f8673f526733f', 'Emergency Contact 130', '1455056554', 'POL93926', '341 Elm St', 'assets/patient130.jpg', 'Diabetic', '2024-09-18 02:31:23', '2024-10-08 06:30:47'),
(131, 'Liam Harris', 'patient131@care.com', '1387835691', 'Group 5', 'Oncology', 'Quit', '1995-07-01', '6599f930e573d6b142b9dcaf521031c145a42f67dca4d1aa52c18dd049c70f17', 'Emergency Contact 131', '1835017138', 'POL38591', '864 Elm St', 'assets/patient131.jpg', 'High blood pressure', '2024-09-26 02:31:23', '2024-10-08 06:30:47'),
(132, 'James Moore', 'patient132@care.com', '1518464796', 'Group 3', 'Dermatology', 'Rest', '1980-07-20', '88d5ed80a20372a611344f2f53dfa3eb1e5fcfbfebdfc53d5ea3bb33d08452e3', 'Emergency Contact 132', '1380227376', 'POL82262', '872 Elm St', 'assets/patient132.jpg', 'No known allergies', '2024-09-21 02:31:23', '2024-10-08 06:30:47'),
(133, 'Sophia White', 'patient133@care.com', '1748984679', 'Group 3', 'Neurology', 'Quit', '1995-03-26', '0f2287d7ff143fb181091719f609407c79df5a1a8ced6d3a5d9975d944d147e7', 'Emergency Contact 133', '1558297182', 'POL65780', '538 Elm St', 'assets/patient133.jpg', 'Asthma patient', '2024-09-21 02:31:23', '2024-10-08 06:30:47'),
(134, 'Grace Taylor', 'patient134@care.com', '1461759681', 'Group 5', 'Pediatrics', 'Rest', '2006-03-09', '9318a8ffe201bfc8dc397b0526d47a93b6929aaa35fa5bc3603a3dc03a1cd325', 'Emergency Contact 134', '1490983358', 'POL42392', '922 Elm St', 'assets/patient134.jpg', 'High blood pressure', '2024-09-21 02:31:23', '2024-10-08 06:30:47'),
(135, 'Robert Martinez', 'patient135@care.com', '1204738124', 'Group 1', 'Oncology', 'Rest', '2003-12-24', '2d1f5b62d12a11a236f1fc8fef92d57466e3da077f8e111cfc96bf37f0c166e6', 'Emergency Contact 135', '1824833398', 'POL66181', '526 Elm St', 'assets/patient135.jpg', 'No known allergies', '2024-10-02 02:31:23', '2024-10-08 06:30:47'),
(136, 'Michael Davis', 'patient136@care.com', '1646254025', 'Group 5', 'Orthopedics', 'Rest', '1992-03-22', 'cd3998188df822394e6267f24a59e1f8179016715c9c056db4c8c1d1db1e0b5b', 'Emergency Contact 136', '1741632392', 'POL94467', '142 Elm St', 'assets/patient136.jpg', 'Asthma patient', '2024-09-10 02:31:23', '2024-10-08 06:30:47'),
(137, 'Ethan Smith', 'patient137@care.com', '1172931609', 'Group 2', 'Dermatology', 'Online', '1987-07-05', 'f57094f1aa11fc54cf4f190d7aa220cad6521bb57bf325ff2e5c704a4403f840', 'Emergency Contact 137', '1334408322', 'POL38030', '582 Elm St', 'assets/patient137.jpg', 'High blood pressure', '2024-09-07 02:31:23', '2024-10-08 06:30:47'),
(138, 'Ethan Garcia', 'patient138@care.com', '1569992961', 'Group 1', 'Oncology', 'Rest', '1989-02-26', 'f0b0620fa014b95946cd842c9c6afa9df5a133e624cf9f44b6369f47ef0b9860', 'Emergency Contact 138', '1884543045', 'POL38444', '150 Elm St', 'assets/patient138.jpg', 'No notes', '2024-09-09 02:31:23', '2024-10-08 06:30:47'),
(139, 'Jane Brown', 'patient139@care.com', '1643545745', 'Group 5', 'Oncology', 'Quit', '2003-04-28', '85d18fbb95bcd762ee50d6c69d5d36fedc7a71d25e7958b673bc97412dae6e18', 'Emergency Contact 139', '1141643624', 'POL26613', '318 Elm St', 'assets/patient139.jpg', 'No known allergies', '2024-09-24 02:31:23', '2024-10-08 06:30:47'),
(140, 'James Jackson', 'patient140@care.com', '1661040833', 'Group 1', 'Orthopedics', 'Rest', '2004-03-14', '255f5a0fad8e466edbf8da45d286b3ff7efc4fbd8ce19b57ec2d838dfd619116', 'Emergency Contact 140', '1488138948', 'POL45404', '162 Elm St', 'assets/patient140.jpg', 'Diabetic', '2024-09-24 02:31:23', '2024-10-08 06:30:47'),
(141, 'Robert Brown', 'patient141@care.com', '1924677313', 'Group 2', 'Neurology', 'Rest', '2001-02-28', '756d83eb323e0ee4727a0a69c40f58b35a7dfab05a540e66ef57cbaa11fbeba0', 'Emergency Contact 141', '1753943304', 'POL26951', '544 Elm St', 'assets/patient141.jpg', 'No known allergies', '2024-09-06 02:31:23', '2024-10-08 06:30:47'),
(142, 'Robert Moore', 'patient142@care.com', '1355021462', 'Group 5', 'Pediatrics', 'Rest', '2005-12-21', '7fcc570b3ebb368657ac30eb394437317092c49c963ce5c3c8677fa8845905db', 'Emergency Contact 142', '1362809602', 'POL60937', '126 Elm St', 'assets/patient142.jpg', 'No known allergies', '2024-09-14 02:31:23', '2024-10-08 06:30:47'),
(143, 'Sarah Jackson', 'patient143@care.com', '1159282900', 'Group 1', 'Pediatrics', 'Quit', '2011-11-12', '48181fe366586ac299ef7ea20f941991e227a07b80748df6557d26d157d61994', 'Emergency Contact 143', '1950093364', 'POL78996', '719 Elm St', 'assets/patient143.jpg', 'No known allergies', '2024-09-12 02:31:23', '2024-10-08 06:30:47'),
(144, 'Sophia Miller', 'patient144@care.com', '1146694980', 'Group 3', 'Dermatology', 'Rest', '1989-09-08', '3fb2a24c30ff17fceb6b1dd633d033d269f5625a380d4737bb4d8d579273b368', 'Emergency Contact 144', '1880935906', 'POL86875', '112 Elm St', 'assets/patient144.jpg', 'Asthma patient', '2024-09-24 02:31:23', '2024-10-08 06:30:47'),
(145, 'Anna Smith', 'patient145@care.com', '1173488590', 'Group 1', 'Dermatology', 'Quit', '1981-09-24', 'd6400ec2d0262f2bfd48f36da57020105d5d683fd52859fe15a407cd0ca6211d', 'Emergency Contact 145', '1238542029', 'POL65271', '102 Elm St', 'assets/patient145.jpg', 'Asthma patient', '2024-09-13 02:31:23', '2024-10-08 06:30:47'),
(146, 'Anna Brown', 'patient146@care.com', '1369215357', 'Group 5', 'Neurology', 'Online', '1986-01-26', '09cbabdc2491d81468e18b0ed87bc3e0af6700dadb289bca89fdf5b402c6830a', 'Emergency Contact 146', '1479706008', 'POL34600', '732 Elm St', 'assets/patient146.jpg', 'High blood pressure', '2024-09-13 02:31:23', '2024-10-08 06:30:47'),
(147, 'Daniel Smith', 'patient147@care.com', '1470984278', 'Group 5', 'Dermatology', 'Quit', '1997-07-06', '8ac6fa6af4e3104d9fcceaa1d13611a14e1a8f492e40bd06f92f5988de8f90e2', 'Emergency Contact 147', '1219802217', 'POL82257', '248 Elm St', 'assets/patient147.jpg', 'Asthma patient', '2024-09-16 02:31:23', '2024-10-08 06:30:47'),
(148, 'Anna Smith', 'patient148@care.com', '1789709614', 'Group 4', 'Dermatology', 'Rest', '2006-02-22', 'a4084104544e4f70daf0be459d8174927ae74b756293ecd32a36f2a2297ef971', 'Emergency Contact 148', '1808564528', 'POL73961', '561 Elm St', 'assets/patient148.jpg', 'No known allergies', '2024-09-19 02:31:23', '2024-10-08 06:30:47'),
(149, 'David Miller', 'patient149@care.com', '1778155969', 'Group 1', 'Dermatology', 'Rest', '2003-09-14', '21b4031a4affd4851311f92cb9fa759784fa1a759d448e15b6e0907f3a710ca4', 'Emergency Contact 149', '1859437023', 'POL76298', '705 Elm St', 'assets/patient149.jpg', 'High blood pressure', '2024-09-25 02:31:23', '2024-10-08 06:30:47'),
(150, 'Olivia Brown', 'patient150@care.com', '1181881611', 'Group 4', 'Neurology', 'Quit', '1982-01-04', 'd29aa406fbba50c3381a985c6a527b55c213ac00f55c4384cb5f9c76ce0caf34', 'Emergency Contact 150', '1890035859', 'POL13906', '357 Elm St', 'assets/patient150.jpg', 'Diabetic', '2024-10-05 02:31:23', '2024-10-08 06:30:47'),
(151, 'Mia Walker', 'patient151@care.com', '1128498399', 'Group 5', 'Neurology', 'Rest', '2003-08-28', '450592aa5b8673a1d0cff797186780641e68f510340fd28e6bc1933533a74763', 'Emergency Contact 151', '1473130788', 'POL47025', '236 Elm St', 'assets/patient151.jpg', 'High blood pressure', '2024-09-08 02:31:23', '2024-10-08 06:30:47'),
(152, 'Ethan Rodriguez', 'patient152@care.com', '1199626371', 'Group 2', 'Orthopedics', 'Online', '1994-03-11', '5bdad2e06ba9795917c0a49b70e57701bfdaf3d958d77baa2dc4124f6e5c0b1a', 'Emergency Contact 152', '1606048941', 'POL72268', '625 Elm St', 'assets/patient152.jpg', 'High blood pressure', '2024-09-22 02:31:23', '2024-10-08 06:30:47'),
(153, 'James Harris', 'patient153@care.com', '1584205023', 'Group 4', 'Pediatrics', 'Online', '2003-02-02', '56321dc45ff00cb49b881c65abe8250e3458d9741e0b00781867b4548b9e4852', 'Emergency Contact 153', '1291999940', 'POL59718', '722 Elm St', 'assets/patient153.jpg', 'Asthma patient', '2024-09-10 02:31:23', '2024-10-08 06:30:47');
INSERT INTO `patients` (`id`, `name`, `email`, `phone_number`, `group_name`, `field`, `status`, `date_of_birth`, `password`, `emergency_contact_name`, `emergency_contact_phone`, `insurance_policy_number`, `address`, `photo`, `notes`, `created_at`, `updated_at`) VALUES
(154, 'Sarah Moore', 'patient154@care.com', '1726682362', 'Group 3', 'Neurology', 'Quit', '1983-12-26', 'bebf2a2a66daec42d9cf5c77eaeee6c4d3cb750f72adb1fdd1da5163344bab83', 'Emergency Contact 154', '1599170212', 'POL69519', '467 Elm St', 'assets/patient154.jpg', 'Diabetic', '2024-09-11 02:31:23', '2024-10-08 06:30:47'),
(155, 'Ethan Jackson', 'patient155@care.com', '1468483392', 'Group 1', 'Neurology', 'Rest', '2017-08-06', '626fa03e9bb560520ccf825fd5aa75a1f1de91467642d61b24fdae8077e8fdde', 'Emergency Contact 155', '1989694668', 'POL79641', '508 Elm St', 'assets/patient155.jpg', 'High blood pressure', '2024-09-25 02:31:23', '2024-10-08 06:30:47'),
(156, 'Emily Harris', 'patient156@care.com', '1249794822', 'Group 1', 'Dermatology', 'Rest', '2002-07-01', 'd9696dbbac3ac7b995f58616ef82e79f38b609809cb0a6831cad86b260aa36fa', 'Emergency Contact 156', '1487444223', 'POL34865', '259 Elm St', 'assets/patient156.jpg', 'No notes', '2024-09-28 02:31:23', '2024-10-08 06:30:47'),
(157, 'James Miller', 'patient157@care.com', '1132150549', 'Group 3', 'Pediatrics', 'Rest', '1993-10-21', '48047a5f042d8cfdf8578827d80fa22e2146c729650795b0af1f4a326041e181', 'Emergency Contact 157', '1173401054', 'POL97969', '263 Elm St', 'assets/patient157.jpg', 'Diabetic', '2024-09-20 02:31:23', '2024-10-08 06:30:47'),
(158, 'Olivia Johnson', 'patient158@care.com', '1190666579', 'Group 2', 'Pediatrics', 'Quit', '1987-07-01', '52fa39da5609465a4a7f395473d9c37b7ff78b100fcb700b7e1471b88b9b36e1', 'Emergency Contact 158', '1384425602', 'POL44213', '147 Elm St', 'assets/patient158.jpg', 'High blood pressure', '2024-10-01 02:31:23', '2024-10-08 06:30:47'),
(159, 'Laura Moore', 'patient159@care.com', '1685746987', 'Group 5', 'Orthopedics', 'Rest', '1986-08-19', 'a67803d73dd28464e7461a5e780f5299e8532a4de588f827e640816eb37f5c26', 'Emergency Contact 159', '1460420482', 'POL44351', '929 Elm St', 'assets/patient159.jpg', 'Diabetic', '2024-09-24 02:31:23', '2024-10-08 06:30:47'),
(160, 'Robert Martinez', 'patient160@care.com', '1946721324', 'Group 1', 'Oncology', 'Online', '2014-08-09', '4785bc4f3b42460fbe1664e285c10911b1f44188fcd2f4e4bb14eb1601a3aeec', 'Emergency Contact 160', '1139960716', 'POL13348', '289 Elm St', 'assets/patient160.jpg', 'No known allergies', '2024-09-29 02:31:23', '2024-10-08 06:30:47'),
(161, 'David Clark', 'patient161@care.com', '1428826824', 'Group 4', 'Orthopedics', 'Online', '1982-07-02', '405b5b2b2ff785bb71e5d41c479ac36518c6e7ba7e67bb35b348192dd40c0633', 'Emergency Contact 161', '1130659209', 'POL85383', '811 Elm St', 'assets/patient161.jpg', 'Asthma patient', '2024-09-29 02:31:23', '2024-10-08 06:30:47'),
(162, 'Lucas Lee', 'patient162@care.com', '1362469095', 'Group 4', 'Orthopedics', 'Quit', '2010-10-07', '5ecd8b8b333ae5aabb230f52f4c8093f1289703622ae3e95d58ad63b5b530d63', 'Emergency Contact 162', '1310944559', 'POL34798', '490 Elm St', 'assets/patient162.jpg', 'Diabetic', '2024-09-22 02:31:23', '2024-10-08 06:30:47'),
(163, 'Sophia Clark', 'patient163@care.com', '1413900785', 'Group 2', 'Pediatrics', 'Rest', '1993-06-05', '3cc7972ec0502d00812cf0df51516e927277343e207a5273adb55b4e7d5674ef', 'Emergency Contact 163', '1266053360', 'POL96534', '407 Elm St', 'assets/patient163.jpg', 'Diabetic', '2024-10-01 02:31:23', '2024-10-08 06:30:47'),
(164, 'Laura Clark', 'patient164@care.com', '1602725397', 'Group 5', 'Orthopedics', 'Online', '2013-11-27', '143b184d6e9edeca2549cea3083e6d2e274569698b699b5e0f76748899b746e2', 'Emergency Contact 164', '1142765587', 'POL96650', '902 Elm St', 'assets/patient164.jpg', 'No known allergies', '2024-09-09 02:31:23', '2024-10-08 06:30:47'),
(165, 'Daniel Wilson', 'patient165@care.com', '1932388981', 'Group 5', 'Dermatology', 'Rest', '1984-02-15', 'dc4831cad7c9ad2cc564235929973392b2a905f3e83ba7c28001aa3c07b9c3de', 'Emergency Contact 165', '1898618413', 'POL62058', '693 Elm St', 'assets/patient165.jpg', 'High blood pressure', '2024-09-09 02:31:23', '2024-10-08 06:30:47'),
(166, 'Lucas Smith', 'patient166@care.com', '1928223573', 'Group 1', 'Pediatrics', 'Quit', '1988-02-16', '29390a61298a7c98ed3faad99857a14d781c657c5b448e3e04ad67367021479f', 'Emergency Contact 166', '1579952444', 'POL38885', '433 Elm St', 'assets/patient166.jpg', 'High blood pressure', '2024-09-19 02:31:23', '2024-10-08 06:30:47'),
(167, 'John Davis', 'patient167@care.com', '1955556095', 'Group 4', 'Neurology', 'Online', '1998-12-18', 'f3a8483e379e55ef54e52d51716e913972191176575f63a5b0c25129bf5a6149', 'Emergency Contact 167', '1212252642', 'POL64349', '994 Elm St', 'assets/patient167.jpg', 'No known allergies', '2024-09-08 02:31:23', '2024-10-08 06:30:47'),
(168, 'Emma Miller', 'patient168@care.com', '1771800772', 'Group 3', 'Pediatrics', 'Online', '2017-03-12', 'e1f681e24b4fea0916bec586585d3acb2041410f8f87d20a5f4329d969765daf', 'Emergency Contact 168', '1352630840', 'POL71341', '331 Elm St', 'assets/patient168.jpg', 'No notes', '2024-09-20 02:31:23', '2024-10-08 06:30:47'),
(169, 'James Walker', 'patient169@care.com', '1678311393', 'Group 4', 'Neurology', 'Quit', '2012-07-26', '528d9d4c03607ee5f1aa12c59441a52f3342c4b0a44fa6636b9db2a0f5b6e403', 'Emergency Contact 169', '1223798895', 'POL36094', '455 Elm St', 'assets/patient169.jpg', 'Diabetic', '2024-09-25 02:31:23', '2024-10-08 06:30:47'),
(170, 'Olivia Clark', 'patient170@care.com', '1829580985', 'Group 4', 'Oncology', 'Online', '2000-02-21', 'c942dbe12e6b223eb9b5bcaaf6cb2a822cb1ff98e438f819adc1d5076a53f811', 'Emergency Contact 170', '1366754690', 'POL40010', '802 Elm St', 'assets/patient170.jpg', 'Asthma patient', '2024-09-06 02:31:23', '2024-10-08 06:30:47'),
(171, 'Ethan Wilson', 'patient171@care.com', '1199183044', 'Group 4', 'Neurology', 'Rest', '1981-03-19', '16601c07e552f7238b5c46b52656315c1c52c2472ff0c76d68e3488719f6fb60', 'Emergency Contact 171', '1161549028', 'POL84151', '592 Elm St', 'assets/patient171.jpg', 'Diabetic', '2024-09-16 02:31:23', '2024-10-08 06:30:47'),
(172, 'Olivia Lewis', 'patient172@care.com', '1329979397', 'Group 5', 'Orthopedics', 'Quit', '1984-10-17', 'ebecc41414aa4ef4eb3162c13e2a1336a64c01a0b17c4c68ea4dd06b64f5ff66', 'Emergency Contact 172', '1305130772', 'POL92563', '791 Elm St', 'assets/patient172.jpg', 'No known allergies', '2024-09-09 02:31:23', '2024-10-08 06:30:47'),
(173, 'Jane Johnson', 'patient173@care.com', '1553083961', 'Group 2', 'Neurology', 'Online', '1985-10-16', 'cdd34a0dbdf26eb93c2bc1a0217776bed2ebee3dc795df46bf9413b30d17c7db', 'Emergency Contact 173', '1281624330', 'POL89374', '615 Elm St', 'assets/patient173.jpg', 'Diabetic', '2024-10-04 02:31:23', '2024-10-08 06:30:47'),
(174, 'Olivia Anderson', 'patient174@care.com', '1294824793', 'Group 5', 'Oncology', 'Rest', '2018-10-13', '5fc2fd60833e81a75687a0da42cddb5a77dc02ab12eb48adc59822c5210078ef', 'Emergency Contact 174', '1661693432', 'POL42446', '551 Elm St', 'assets/patient174.jpg', 'No notes', '2024-09-28 02:31:23', '2024-10-08 06:30:47'),
(175, 'Liam White', 'patient175@care.com', '1715615314', 'Group 4', 'Dermatology', 'Online', '1996-05-11', 'd0eba0252094b4f48b15c38977d1c9d9ef9d53198ab6603bfd4930a48a631c99', 'Emergency Contact 175', '1803189244', 'POL84675', '909 Elm St', 'assets/patient175.jpg', 'Diabetic', '2024-09-27 02:31:23', '2024-10-08 06:30:47'),
(176, 'Emily Taylor', 'patient176@care.com', '1602536726', 'Group 4', 'Dermatology', 'Online', '2005-08-12', 'fb29abde9d7aaba167a4b2dfdffe5bc1b6f78634c766e08c82c4f3204d83da42', 'Emergency Contact 176', '1479840022', 'POL41844', '603 Elm St', 'assets/patient176.jpg', 'Diabetic', '2024-09-23 02:31:23', '2024-10-08 06:30:47'),
(177, 'Daniel Garcia', 'patient177@care.com', '1561099769', 'Group 5', 'Orthopedics', 'Rest', '2006-06-02', '93adf8f53e27ce7096c7cc4a641f68c8a1a7fd952017f6a1bdc33315e208da79', 'Emergency Contact 177', '1684692686', 'POL20340', '261 Elm St', 'assets/patient177.jpg', 'Diabetic', '2024-09-09 02:31:23', '2024-10-08 06:30:47'),
(178, 'Emily Rodriguez', 'patient178@care.com', '1951028985', 'Group 1', 'Dermatology', 'Rest', '2015-10-20', 'e4d43cbce944362b9ddd3549f2d65f109b1a8c15e695fbc4884e691ea44a55f1', 'Emergency Contact 178', '1888718110', 'POL52298', '678 Elm St', 'assets/patient178.jpg', 'Diabetic', '2024-09-30 02:31:23', '2024-10-08 06:30:47'),
(179, 'Grace Anderson', 'patient179@care.com', '1816777980', 'Group 3', 'Neurology', 'Quit', '2012-10-07', '3cacbb5ab1e6322e2956f24ec4779f49d923d781af99a5a1cfffed4a024e926b', 'Emergency Contact 179', '1243347639', 'POL65445', '350 Elm St', 'assets/patient179.jpg', 'Diabetic', '2024-09-08 02:31:23', '2024-10-08 06:30:47'),
(180, 'Daniel Thompson', 'patient180@care.com', '1238541972', 'Group 4', 'Pediatrics', 'Online', '1982-04-03', 'f6643fb7327a6ea3aefd398f6c78d5a52e692ce2450fa0c1ff9e9fb0b47d3c51', 'Emergency Contact 180', '1629057875', 'POL29902', '810 Elm St', 'assets/patient180.jpg', 'No notes', '2024-09-15 02:31:23', '2024-10-08 06:30:47'),
(181, 'Mia Anderson', 'patient181@care.com', '1691018780', 'Group 3', 'Pediatrics', 'Online', '1981-04-05', 'e467db0e2b2e9613adf7339057cf1d31107a103639d4d24ed5e97285eddbdf5f', 'Emergency Contact 181', '1536507101', 'POL13538', '271 Elm St', 'assets/patient181.jpg', 'Diabetic', '2024-09-11 02:31:23', '2024-10-08 06:30:47'),
(182, 'Emma Walker', 'patient182@care.com', '1636036958', 'Group 2', 'Pediatrics', 'Online', '1982-06-26', '560c2e96f6faba34987f41b1c77223fa0727d7d67dfbfb3f66bed9d8d4a67d91', 'Emergency Contact 182', '1130908651', 'POL46610', '563 Elm St', 'assets/patient182.jpg', 'No known allergies', '2024-09-24 02:31:23', '2024-10-08 06:30:47'),
(183, 'John Brown', 'patient183@care.com', '1206742609', 'Group 5', 'Dermatology', 'Quit', '1993-02-08', '36f516ddc43d957422461537d6de619eb496615f38d7fc7c363aa4bfaca905c7', 'Emergency Contact 183', '1928696875', 'POL35393', '913 Elm St', 'assets/patient183.jpg', 'Asthma patient', '2024-09-16 02:31:23', '2024-10-08 06:30:47'),
(184, 'Jane Jackson', 'patient184@care.com', '1160218444', 'Group 4', 'Neurology', 'Rest', '2018-11-15', 'a923ca501bb855ac6f5e656dd852d57a835511e0c6472ccbdfb9c43f465e3ce3', 'Emergency Contact 184', '1541206984', 'POL57721', '898 Elm St', 'assets/patient184.jpg', 'Asthma patient', '2024-09-26 02:31:23', '2024-10-08 06:30:47'),
(185, 'Daniel Anderson', 'patient185@care.com', '1468835202', 'Group 1', 'Dermatology', 'Quit', '1993-08-08', 'b6982dcb9c1378ef46a75d81b5352abaf4d8623f6f1d15e6f70c152644ae285d', 'Emergency Contact 185', '1386299049', 'POL45338', '141 Elm St', 'assets/patient185.jpg', 'Asthma patient', '2024-09-08 02:31:23', '2024-10-08 06:30:47'),
(186, 'Michael Anderson', 'patient186@care.com', '1620951818', 'Group 4', 'Neurology', 'Rest', '2007-11-01', '3860417fa3cfd7339aca271608dc011ec3d05f382797f4c1f03801b25ab46a13', 'Emergency Contact 186', '1975312857', 'POL31125', '329 Elm St', 'assets/patient186.jpg', 'High blood pressure', '2024-09-14 02:31:23', '2024-10-08 06:30:47'),
(187, 'Lucas Davis', 'patient187@care.com', '1958420941', 'Group 1', 'Dermatology', 'Rest', '2002-09-28', '5e0be70ee6187c14ba00d42baf92c43e82f99e8aeab7f14704f533001358ad33', 'Emergency Contact 187', '1836264507', 'POL81318', '341 Elm St', 'assets/patient187.jpg', 'No notes', '2024-09-10 02:31:23', '2024-10-08 06:30:47'),
(188, 'Emma Brown', 'patient188@care.com', '1949134936', 'Group 4', 'Orthopedics', 'Online', '1981-11-10', 'f2dd789b257413839d900f153a5f62e98b5654f20585cdc6b719d94fff326593', 'Emergency Contact 188', '1318757909', 'POL63809', '550 Elm St', 'assets/patient188.jpg', 'Asthma patient', '2024-10-03 02:31:23', '2024-10-08 06:30:47'),
(189, 'John Smith', 'patient189@care.com', '1538251439', 'Group 2', 'Oncology', 'Rest', '2000-06-28', '5e1a4f63c9d8a6caa67b6be891fbbedff156d20374966a986cbd7c2e36174195', 'Emergency Contact 189', '1719599105', 'POL26583', '380 Elm St', 'assets/patient189.jpg', 'No known allergies', '2024-09-27 02:31:23', '2024-10-08 06:30:47'),
(190, 'Anna Lee', 'patient190@care.com', '1269620079', 'Group 2', 'Orthopedics', 'Online', '2002-03-06', 'e13d707466bb60a60fbeaf1c1ee6b6dca97ee0e23d6f5d669161bf0a563b9fa9', 'Emergency Contact 190', '1890416086', 'POL74294', '611 Elm St', 'assets/patient190.jpg', 'No known allergies', '2024-09-15 02:31:23', '2024-10-08 06:30:47'),
(191, 'Michael Garcia', 'patient191@care.com', '1443104421', 'Group 4', 'Neurology', 'Quit', '2011-05-18', '680a3230ee3e6b21a1ff03a141361ef44f2fc865d5bb2c83834eec28cca86c1f', 'Emergency Contact 191', '1595812821', 'POL26968', '518 Elm St', 'assets/patient191.jpg', 'High blood pressure', '2024-09-25 02:31:23', '2024-10-08 06:30:47'),
(192, 'Emma White', 'patient192@care.com', '1586443901', 'Group 3', 'Oncology', 'Quit', '1995-01-05', 'fe032a7e116619c2d6f183d863e66da094a68a4381ec5385493d5103dd952b20', 'Emergency Contact 192', '1623558472', 'POL47246', '552 Elm St', 'assets/patient192.jpg', 'No notes', '2024-09-29 02:31:23', '2024-10-08 06:30:47'),
(193, 'Ethan Miller', 'patient193@care.com', '1903991623', 'Group 1', 'Orthopedics', 'Quit', '1994-12-20', 'e12b0a3ef7d4b1a90babd0696b1109be86a32988372cb99332dc41f26f1c977a', 'Emergency Contact 193', '1143600194', 'POL26872', '524 Elm St', 'assets/patient193.jpg', 'No known allergies', '2024-09-15 02:31:23', '2024-10-08 06:30:47'),
(194, 'Anna Brown', 'patient194@care.com', '1866316201', 'Group 5', 'Orthopedics', 'Quit', '2009-01-11', 'a1c6e7d7318d5e2ca90d4ce1383bd980890a78269ca0a2ee185a790ad76abeab', 'Emergency Contact 194', '1553557340', 'POL38934', '663 Elm St', 'assets/patient194.jpg', 'Asthma patient', '2024-09-22 02:31:23', '2024-10-08 06:30:47'),
(195, 'Ethan Walker', 'patient195@care.com', '1718967213', 'Group 5', 'Dermatology', 'Online', '1995-06-26', '54690960fd2fd3ffec22139205e3cadb4f7294d41dc19691a58977c5a5567367', 'Emergency Contact 195', '1106453564', 'POL26315', '798 Elm St', 'assets/patient195.jpg', 'High blood pressure', '2024-09-29 02:31:23', '2024-10-08 06:30:47'),
(196, 'Ethan Walker', 'patient196@care.com', '1508206499', 'Group 1', 'Pediatrics', 'Online', '2008-09-18', '941b587fdcba03eb477c2f4f759dfdffe32ce82af1c1e71e988ba7336c196654', 'Emergency Contact 196', '1975654425', 'POL13866', '649 Elm St', 'assets/patient196.jpg', 'No known allergies', '2024-10-03 02:31:23', '2024-10-08 06:30:47'),
(197, 'Robert Jackson', 'patient197@care.com', '1863168099', 'Group 3', 'Pediatrics', 'Online', '2003-07-17', 'b67cd9c6d30c39ec728e41441bd63f91bd9970d68c7e20d73caf366c069526ef', 'Emergency Contact 197', '1608594163', 'POL88085', '704 Elm St', 'assets/patient197.jpg', 'No known allergies', '2024-09-27 02:31:23', '2024-10-08 06:30:47'),
(198, 'David Wilson', 'patient198@care.com', '1722688962', 'Group 3', 'Oncology', 'Online', '1997-03-23', 'c69c354dc59c95231debd8c767496de071cdb66c9a29a604b45574fb55c9813f', 'Emergency Contact 198', '1534907588', 'POL93482', '784 Elm St', 'assets/patient198.jpg', 'Diabetic', '2024-09-30 02:31:23', '2024-10-08 06:30:47'),
(199, 'Sarah Johnson', 'patient199@care.com', '1114092021', 'Group 1', 'Orthopedics', 'Rest', '2006-09-16', '964f2541cc4d2d6413e98c8967a21fc4e27a0be0bd7d19e84c1ea60608aac2c0', 'Emergency Contact 199', '1905198274', 'POL56148', '416 Elm St', 'assets/patient199.jpg', 'Diabetic', '2024-09-22 02:31:23', '2024-10-08 06:30:47'),
(200, 'John White', 'patient200@care.com', '1394829463', 'Group 3', 'Pediatrics', 'Online', '1982-05-15', 'd11aa2bde461d377b64aeebf6b1bac1cac2bb36f1567c10c327fcba119550c57', 'Emergency Contact 200', '1469416968', 'POL22391', '502 Elm St', 'assets/patient200.jpg', 'No known allergies', '2024-09-16 02:31:23', '2024-10-08 06:30:47'),
(201, 'Lucas Taylor', 'patient201@care.com', '1230092141', 'Group 4', 'Orthopedics', 'Rest', '1996-05-04', 'b4dc392686f27067dc2d8fb6c85dd59b0face6dd5a45cc51ada25ef2954d9c05', 'Emergency Contact 201', '1900916901', 'POL39450', '455 Elm St', 'assets/patient201.jpg', 'Diabetic', '2024-10-04 02:31:23', '2024-10-08 06:30:47'),
(202, 'Robert Lee', 'patient202@care.com', '1745834092', 'Group 5', 'Pediatrics', 'Rest', '2017-09-18', '4d2873969d468c5afe24ca41a7ddbfd046c59dbd4d393c1877ec27477f568d14', 'Emergency Contact 202', '1168858528', 'POL97115', '675 Elm St', 'assets/patient202.jpg', 'No notes', '2024-10-05 02:31:23', '2024-10-08 06:30:47'),
(203, 'Mia Davis', 'patient203@care.com', '1615781938', 'Group 2', 'Orthopedics', 'Quit', '2015-06-03', '493d31922a9ffa483e1dfea6d83bfa40d3d339ab4f1c831368ea918ad5af8ef6', 'Emergency Contact 203', '1767146907', 'POL31931', '298 Elm St', 'assets/patient203.jpg', 'High blood pressure', '2024-10-02 02:31:23', '2024-10-08 06:30:47'),
(204, 'Emma White', 'patient204@care.com', '1204066966', 'Group 4', 'Pediatrics', 'Online', '2007-06-22', '4f9660e0a7166ac4857a4091fdbaa29828259307573d524bb9751808327f6df6', 'Emergency Contact 204', '1833135527', 'POL91130', '335 Elm St', 'assets/patient204.jpg', 'Asthma patient', '2024-10-05 02:31:23', '2024-10-08 06:30:47'),
(205, 'Emma Taylor', 'patient205@care.com', '1709574823', 'Group 4', 'Neurology', 'Online', '2009-09-22', '978e887b94cb518cbfc40a8507b6d6503cc2892df988660c91760bd1153da77b', 'Emergency Contact 205', '1996768968', 'POL96045', '256 Elm St', 'assets/patient205.jpg', 'High blood pressure', '2024-10-01 02:31:23', '2024-10-08 06:30:47'),
(206, 'Anna White', 'patient206@care.com', '1757260348', 'Group 2', 'Oncology', 'Rest', '2019-02-26', 'a98777a5f7fd02c483b34c76c0448d284bf058209cdb474a47c33617a29ae9bf', 'Emergency Contact 206', '1650588462', 'POL31120', '294 Elm St', 'assets/patient206.jpg', 'No notes', '2024-10-04 02:31:23', '2024-10-08 06:30:47'),
(207, 'Benjamin Thompson', 'patient207@care.com', '1606370588', 'Group 5', 'Pediatrics', 'Quit', '1991-02-21', '721e156cefaacabfcef6ddcbfa25660bb200fd0adaba71d9bcf7778419ff4544', 'Emergency Contact 207', '1156658828', 'POL28441', '216 Elm St', 'assets/patient207.jpg', 'Asthma patient', '2024-10-04 02:31:23', '2024-10-08 06:30:47'),
(208, 'Emily Harris', 'patient208@care.com', '1389736564', 'Group 5', 'Oncology', 'Quit', '2003-06-26', '94c00217c0d17d4cee3e2b17f1b23152ce598031300d2813a62db0abdb38b5d2', 'Emergency Contact 208', '1131969958', 'POL13041', '459 Elm St', 'assets/patient208.jpg', 'High blood pressure', '2024-10-05 02:31:23', '2024-10-08 06:30:47'),
(209, 'Sophia Miller', 'patient209@care.com', '1259732079', 'Group 5', 'Neurology', 'Rest', '2003-07-10', '9d932a0e920711e9f273611a3a5e604e939ab5b4fae2d076b4e73bfa2ee89d41', 'Emergency Contact 209', '1889334654', 'POL10367', '961 Elm St', 'assets/patient209.jpg', 'No notes', '2024-10-02 02:31:23', '2024-10-08 06:30:47'),
(210, 'Lucas Harris', 'patient210@care.com', '1708236545', 'Group 5', 'Dermatology', 'Quit', '1998-12-14', '37731614a484f978e5eb110da9c7ff8cce399f857146053af7b2836f57cc3b9a', 'Emergency Contact 210', '1522185382', 'POL49849', '225 Elm St', 'assets/patient210.jpg', 'Asthma patient', '2024-10-01 02:31:23', '2024-10-08 06:30:47'),
(211, 'Jane Johnson', 'patient211@care.com', '1513332748', 'Group 3', 'Dermatology', 'Rest', '1980-12-19', '4d971c433d68509977c462c3a416fdd90fb008c32b49d8521699969dd7bb5119', 'Emergency Contact 211', '1672455817', 'POL69409', '509 Elm St', 'assets/patient211.jpg', 'No known allergies', '2024-10-04 02:31:23', '2024-10-08 06:30:47'),
(212, 'Jane Lee', 'patient212@care.com', '1911768631', 'Group 2', 'Orthopedics', 'Rest', '2004-09-06', '5bec5f858bbe9022f64c50969c01905774d8aeffd6817eef7dc791386774429e', 'Emergency Contact 212', '1242040850', 'POL92125', '344 Elm St', 'assets/patient212.jpg', 'Asthma patient', '2024-10-05 02:31:23', '2024-10-08 06:30:47'),
(213, 'Anna White', 'patient213@care.com', '1338455632', 'Group 3', 'Neurology', 'Rest', '1985-12-14', 'ffc3c52aa3c3878b835a9539c163078cdaf1c3e48d3b34e3948722638d751618', 'Emergency Contact 213', '1804238467', 'POL66796', '852 Elm St', 'assets/patient213.jpg', 'Asthma patient', '2024-10-04 02:31:23', '2024-10-08 06:30:47'),
(214, 'Benjamin Lewis', 'patient214@care.com', '1707303900', 'Group 4', 'Neurology', 'Online', '1998-03-07', '66166aa5b02cd548d4cda42508607c5d1ec0c00e3de9183f6164c3c1047d43d7', 'Emergency Contact 214', '1550290274', 'POL36734', '652 Elm St', 'assets/patient214.jpg', 'No known allergies', '2024-10-04 02:31:23', '2024-10-08 06:30:47'),
(215, 'Ethan Davis', 'patient215@care.com', '1898366279', 'Group 1', 'Oncology', 'Quit', '2007-03-20', 'c0777b8f1cf3700bffaf72e4719e7df1ded870fdb37fb5e6e2c6b964b9682e0a', 'Emergency Contact 215', '1582054546', 'POL31815', '382 Elm St', 'assets/patient215.jpg', 'Diabetic', '2024-09-30 02:31:23', '2024-10-08 06:30:47'),
(216, 'James Harris', 'patient216@care.com', '1805227279', 'Group 2', 'Neurology', 'Quit', '1982-06-03', '3f393dc0700dd30c0c8831e353a10b207a1b054f26c213923323239ae1d3c37f', 'Emergency Contact 216', '1679621698', 'POL66493', '400 Elm St', 'assets/patient216.jpg', 'High blood pressure', '2024-09-30 02:31:23', '2024-10-08 06:30:47'),
(217, 'Mia White', 'patient217@care.com', '1616766891', 'Group 1', 'Oncology', 'Online', '1993-01-04', '26261b84915b7309d33b26ecde0e5fb591181a0cbfbad74918a4fae743ee13bd', 'Emergency Contact 217', '1315424308', 'POL27068', '344 Elm St', 'assets/patient217.jpg', 'No notes', '2024-10-04 02:31:23', '2024-10-08 06:30:47'),
(218, 'Olivia Miller', 'patient218@care.com', '1836678604', 'Group 3', 'Dermatology', 'Quit', '2011-05-14', '2d32ac121eac73ac2dab96da6025d1dabd6458c13135f881b8d5508a86eec366', 'Emergency Contact 218', '1903951570', 'POL23665', '388 Elm St', 'assets/patient218.jpg', 'Diabetic', '2024-09-30 02:31:23', '2024-10-08 06:30:47'),
(219, 'Liam Harris', 'patient219@care.com', '1547562855', 'Group 5', 'Dermatology', 'Online', '1983-08-14', 'd37b67f4b1ae1443bab1a0b9281939aac867ce6548c67d7280f022fd71a6d049', 'Emergency Contact 219', '1447010957', 'POL88462', '614 Elm St', 'assets/patient219.jpg', 'Diabetic', '2024-10-04 02:31:23', '2024-10-08 06:30:47'),
(220, 'Emily Jackson', 'patient220@care.com', '1475525656', 'Group 2', 'Oncology', 'Online', '1984-07-14', '32b648b200be2fe093ca92720e7282a65bccad1e0133c93e30b1c3a49b5f61ae', 'Emergency Contact 220', '1793101396', 'POL53978', '451 Elm St', 'assets/patient220.jpg', 'No known allergies', '2024-10-05 02:31:23', '2024-10-08 06:30:47'),
(221, 'Mia Martinez', 'patient221@care.com', '1656036229', 'Group 3', 'Orthopedics', 'Quit', '2011-10-22', '7d593c33ede01fd74f2f8db2adc870dd45c26dfa19d16a05a14c70121034356d', 'Emergency Contact 221', '1540064819', 'POL53150', '802 Elm St', 'assets/patient221.jpg', 'Diabetic', '2024-09-30 02:31:23', '2024-10-08 06:30:47'),
(222, 'Robert Harris', 'patient222@care.com', '1937862493', 'Group 1', 'Pediatrics', 'Online', '1984-06-28', 'a2b9b4d8b7d27dfd64cbf73789f82b9ef1127d7309827721b8022b3cd452d601', 'Emergency Contact 222', '1175528164', 'POL70866', '676 Elm St', 'assets/patient222.jpg', 'No known allergies', '2024-10-05 02:31:23', '2024-10-08 06:30:47'),
(223, 'John Moore', 'patient223@care.com', '1258946452', 'Group 1', 'Neurology', 'Quit', '2010-02-26', '2cbb990ce217f5702de0ac2db91093e2b271b2a370c55bfb1aa2266655f11e02', 'Emergency Contact 223', '1795571814', 'POL82051', '432 Elm St', 'assets/patient223.jpg', 'High blood pressure', '2024-10-05 02:31:23', '2024-10-08 06:30:47'),
(224, 'Liam Taylor', 'patient224@care.com', '1669337202', 'Group 3', 'Orthopedics', 'Rest', '1982-08-10', '7423dd925068e2b4d9fffc06043318501224d08889bb66caed65276b50380425', 'Emergency Contact 224', '1756347327', 'POL60141', '353 Elm St', 'assets/patient224.jpg', 'High blood pressure', '2024-09-30 02:31:23', '2024-10-08 06:30:47'),
(225, 'John Brown', 'patient225@care.com', '1996119246', 'Group 1', 'Pediatrics', 'Online', '2012-07-18', 'fb4ab26e93634aff814237f37d55b1736994f6ab8bcb66094a92e397a7a75c65', 'Emergency Contact 225', '1394369892', 'POL38735', '442 Elm St', 'assets/patient225.jpg', 'High blood pressure', '2024-10-03 02:31:23', '2024-10-08 06:30:47'),
(226, 'Emily Smith', 'patient226@care.com', '1185058540', 'Group 2', 'Oncology', 'Rest', '2005-06-20', '8e67e3757bb3b5490e7dedf82ff8d1b7280a464972f184729136c2d2a31d9139', 'Emergency Contact 226', '1528952025', 'POL45278', '465 Elm St', 'assets/patient226.jpg', 'No known allergies', '2024-09-29 02:31:23', '2024-10-08 06:30:47'),
(227, 'Robert Davis', 'patient227@care.com', '1958461979', 'Group 5', 'Pediatrics', 'Online', '1998-08-02', 'cc2871c232b07d1c43c31f74e3c50c6d29f930bfe93221e7b6cf7b165697d11c', 'Emergency Contact 227', '1200573025', 'POL36043', '331 Elm St', 'assets/patient227.jpg', 'Diabetic', '2024-09-30 02:31:23', '2024-10-08 06:30:47'),
(228, 'Emily Martinez', 'patient228@care.com', '1532048517', 'Group 4', 'Oncology', 'Online', '1996-08-12', 'b6dd53a881e089232a90306d0aef324cd332dba658f80c72518c548eb97caea4', 'Emergency Contact 228', '1791766508', 'POL55267', '955 Elm St', 'assets/patient228.jpg', 'High blood pressure', '2024-10-05 02:31:23', '2024-10-08 06:30:47'),
(229, 'Grace Taylor', 'patient229@care.com', '1347238356', 'Group 3', 'Neurology', 'Online', '2001-03-10', '06ee0f0b70a8f5567e0b9dc8eefa43841ad7e987b67b949d8c295be2ff3cf4bb', 'Emergency Contact 229', '1816021042', 'POL56695', '446 Elm St', 'assets/patient229.jpg', 'No known allergies', '2024-10-02 02:31:23', '2024-10-08 06:30:47'),
(230, 'Grace Smith', 'patient230@care.com', '1757557714', 'Group 3', 'Orthopedics', 'Rest', '2013-07-11', '8f00733fb2a30e4156a1808d1f7326fb4eb8b2051f532554636433d65d89523b', 'Emergency Contact 230', '1708504968', 'POL29359', '544 Elm St', 'assets/patient230.jpg', 'No notes', '2024-10-04 02:31:23', '2024-10-08 06:30:47'),
(231, 'Liam Smith', 'patient231@care.com', '1477809827', 'Group 4', 'Neurology', 'Online', '2008-03-08', '4cd7b9fdf18ab4b3c2ac549b9e297d041b694ec2c4fa62eca88c3b8f1e02f461', 'Emergency Contact 231', '1110887244', 'POL32624', '392 Elm St', 'assets/patient231.jpg', 'No notes', '2024-10-05 02:31:23', '2024-10-08 06:30:47'),
(232, 'Anna Walker', 'patient232@care.com', '1268420152', 'Group 5', 'Dermatology', 'Rest', '2009-03-21', 'ad946ec3183950a40a1d7c0a4fe03b8efc0bb9d0a160326a1669ed628d8ba4b3', 'Emergency Contact 232', '1898878939', 'POL43976', '735 Elm St', 'assets/patient232.jpg', 'No notes', '2024-09-29 02:31:23', '2024-10-08 06:30:47'),
(233, 'Michael Clark', 'patient233@care.com', '1120018996', 'Group 4', 'Orthopedics', 'Quit', '1980-01-20', 'c19b93c5c0189b5b1d536c3468fc69ec1c8ba3ca136d9e12a900b5ed0f4259eb', 'Emergency Contact 233', '1163356853', 'POL81824', '148 Elm St', 'assets/patient233.jpg', 'Asthma patient', '2024-10-05 02:31:23', '2024-10-08 06:30:47'),
(234, 'Robert Davis', 'patient234@care.com', '1220149175', 'Group 3', 'Pediatrics', 'Quit', '2017-11-27', 'bff08f568653c28a66f72743c0bcb221b1ae35146586e34f023455ca21cade18', 'Emergency Contact 234', '1382054283', 'POL54545', '162 Elm St', 'assets/patient234.jpg', 'High blood pressure', '2024-10-03 02:31:23', '2024-10-08 06:30:47'),
(235, 'Grace Harris', 'patient235@care.com', '1587403287', 'Group 1', 'Neurology', 'Rest', '2010-01-27', '905aa17457e94cc76da9280aae82a1a28eeb812f2ab189b2b590a110e0e70379', 'Emergency Contact 235', '1581749897', 'POL52590', '397 Elm St', 'assets/patient235.jpg', 'High blood pressure', '2024-10-03 02:31:23', '2024-10-08 06:30:47'),
(236, 'David Wilson', 'patient236@care.com', '1852664828', 'Group 1', 'Oncology', 'Online', '1982-02-28', '98ab0f8f22dd8d553d5d876b27709eff5217fd3bc96fb622d5b5881b20ca4722', 'Emergency Contact 236', '1708544030', 'POL54625', '323 Elm St', 'assets/patient236.jpg', 'Diabetic', '2024-09-30 02:31:23', '2024-10-08 06:30:47'),
(237, 'James Davis', 'patient237@care.com', '1218129049', 'Group 2', 'Dermatology', 'Rest', '2009-05-22', '5071d68b1ce4f5a9440baeacb1d6603186d9d4b99f7a6b181a9775d5c02bf647', 'Emergency Contact 237', '1280277884', 'POL70303', '970 Elm St', 'assets/patient237.jpg', 'Asthma patient', '2024-09-29 02:31:23', '2024-10-08 06:30:47'),
(238, 'Mia Lee', 'patient238@care.com', '1803687368', 'Group 1', 'Orthopedics', 'Rest', '1985-08-15', '854686fdf3bc1d3c4402bc14c4f1124cd9e7dc2bb5514fc8132c639cda9a1119', 'Emergency Contact 238', '1248941570', 'POL27796', '417 Elm St', 'assets/patient238.jpg', 'No known allergies', '2024-10-05 02:31:23', '2024-10-08 06:30:47'),
(239, 'Lucas Clark', 'patient239@care.com', '1566263077', 'Group 4', 'Neurology', 'Online', '1985-08-22', '62f64b7c4a801ec48fb27d81feccc580ab3b91c750662a7481097666c1eb9514', 'Emergency Contact 239', '1732488686', 'POL24266', '407 Elm St', 'assets/patient239.jpg', 'Asthma patient', '2024-10-04 02:31:23', '2024-10-08 06:30:47'),
(240, 'David Lee', 'patient240@care.com', '1324821967', 'Group 5', 'Dermatology', 'Quit', '2012-09-22', '36eadb92e9bb80880a6319ee5378f3bc09b725fa5861d88fc6f2f6986059e13b', 'Emergency Contact 240', '1548908670', 'POL91509', '254 Elm St', 'assets/patient240.jpg', 'Asthma patient', '2024-10-05 02:31:23', '2024-10-08 06:30:47'),
(241, 'Emma Rodriguez', 'patient241@care.com', '1533344592', 'Group 5', 'Dermatology', 'Rest', '1996-06-12', '84e0130fe93bfe156ef35df26f67a4ed0fd6363ae97d296d84a6e61cce05c4cf', 'Emergency Contact 241', '1963892413', 'POL34318', '627 Elm St', 'assets/patient241.jpg', 'High blood pressure', '2024-09-29 02:31:23', '2024-10-08 06:30:47'),
(242, 'David Walker', 'patient242@care.com', '1127922404', 'Group 2', 'Oncology', 'Online', '1991-06-24', 'ae8361c1bf2ef281acd85fc5a64a5c7a7d968a39b3b8fe5264e4fce9da29d739', 'Emergency Contact 242', '1662568991', 'POL64058', '786 Elm St', 'assets/patient242.jpg', 'No known allergies', '2024-09-29 02:31:23', '2024-10-08 06:30:47'),
(243, 'Benjamin Harris', 'patient243@care.com', '1120864266', 'Group 3', 'Neurology', 'Rest', '1997-12-11', 'ddf4931c72a133432591872e848ab581cacf56dfe6ffadb52d13fce28e672192', 'Emergency Contact 243', '1627766804', 'POL32008', '696 Elm St', 'assets/patient243.jpg', 'High blood pressure', '2024-10-04 02:31:23', '2024-10-08 06:30:47'),
(244, 'Grace Rodriguez', 'patient244@care.com', '1189432301', 'Group 3', 'Neurology', 'Quit', '2002-05-14', '7367862d999792137d437f43b135edb00c2b5ff13923646442cdf842e359bf4e', 'Emergency Contact 244', '1827897006', 'POL81337', '311 Elm St', 'assets/patient244.jpg', 'No known allergies', '2024-10-01 02:31:23', '2024-10-08 06:30:47'),
(245, 'Emily Brown', 'patient245@care.com', '1205469946', 'Group 5', 'Dermatology', 'Quit', '2016-07-21', 'ebdf59e9ba5eebbf5432ca4e718cca2634ae9dffdde46e9fecce0371445ede41', 'Emergency Contact 245', '1881570160', 'POL21741', '708 Elm St', 'assets/patient245.jpg', 'No known allergies', '2024-10-04 02:31:23', '2024-10-08 06:30:47'),
(246, 'Sophia Smith', 'patient246@care.com', '1511964666', 'Group 1', 'Orthopedics', 'Online', '1993-11-04', '137416b029683b4c47216ddfcc46119ea6cb157022c9d1da4cf5852a5114e78e', 'Emergency Contact 246', '1857835957', 'POL19486', '730 Elm St', 'assets/patient246.jpg', 'No known allergies', '2024-10-05 02:31:23', '2024-10-08 06:30:47'),
(247, 'Jane Rodriguez', 'patient247@care.com', '1767817517', 'Group 2', 'Dermatology', 'Online', '2002-12-24', '8370935cd9b57b4d1f88f05d0c6607f5b2303359c56b1b6114a4b3ce4f6a4082', 'Emergency Contact 247', '1908559069', 'POL81671', '967 Elm St', 'assets/patient247.jpg', 'Diabetic', '2024-09-29 02:31:23', '2024-10-08 06:30:47'),
(248, 'Lucas Thompson', 'patient248@care.com', '1139999703', 'Group 1', 'Oncology', 'Rest', '2008-08-05', 'e6c5ba115f48842f50df0b31ab100fd52592acfc760f444ca8b7d6b3e210d27d', 'Emergency Contact 248', '1735882989', 'POL19607', '116 Elm St', 'assets/patient248.jpg', 'Asthma patient', '2024-10-03 02:31:23', '2024-10-08 06:30:47'),
(249, 'Ethan Smith', 'patient249@care.com', '1176951164', 'Group 2', 'Neurology', 'Quit', '1988-01-13', '16fcbae2f84ad7845ed33ef4a78f3df5889f41f2448077977d6c5157ef6e01ee', 'Emergency Contact 249', '1612002148', 'POL62248', '814 Elm St', 'assets/patient249.jpg', 'Diabetic', '2024-10-01 02:31:23', '2024-10-08 06:30:47'),
(250, 'Michael Johnson', 'patient250@care.com', '1923337081', 'Group 1', 'Dermatology', 'Quit', '1998-06-11', '7fe120c5387146c8f2a938bb5194001362bd13bd5fcc642f5e5d40f0d7c71e3d', 'Emergency Contact 250', '1400525372', 'POL60793', '918 Elm St', 'assets/patient250.jpg', 'High blood pressure', '2024-10-04 02:31:23', '2024-10-08 06:30:47'),
(251, 'Mia Smith', 'patient251@care.com', '1321224577', 'Group 4', 'Dermatology', 'Online', '1996-09-25', 'af2d0939675fd5d3311aade883e313ffa9cd15fe812b84ea27b7c22910581d04', 'Emergency Contact 251', '1515648538', 'POL32577', '956 Elm St', 'assets/patient251.jpg', 'High blood pressure', '2024-09-06 02:31:23', '2024-10-08 06:30:47'),
(252, 'Anna Walker', 'patient252@care.com', '1974521199', 'Group 5', 'Dermatology', 'Online', '1988-03-10', 'a7e9f2018f157a409c842a0a2c93e36365c36d92b056fbd2bbeb52b9dbe17e5f', 'Emergency Contact 252', '1506376239', 'POL27176', '340 Elm St', 'assets/patient252.jpg', 'Asthma patient', '2024-02-09 00:31:23', '2024-10-08 06:30:47'),
(253, 'Sophia Harris', 'patient253@care.com', '1986444174', 'Group 3', 'Pediatrics', 'Rest', '1999-12-13', 'd4f6403d4da368c557e480b113ebf5aa71fab21a45a02754221ae87fa33d8b63', 'Emergency Contact 253', '1878039772', 'POL19128', '688 Elm St', 'assets/patient253.jpg', 'No notes', '2024-04-04 00:31:23', '2024-10-08 06:30:47'),
(254, 'James Brown', 'patient254@care.com', '1245830912', 'Group 3', 'Oncology', 'Online', '2018-05-27', '34438d4fc74301c146cb2e65784e91a3a0ae65cf5e68a8ba99f948a68f15ab39', 'Emergency Contact 254', '1937641463', 'POL36325', '100 Elm St', 'assets/patient254.jpg', 'Asthma patient', '2023-12-07 00:31:23', '2024-10-08 06:30:47'),
(255, 'Michael Jackson', 'patient255@care.com', '1509592292', 'Group 5', 'Oncology', 'Quit', '1986-02-10', '47e7566dc5e528b3ec237e4edfbd9b53e1d771830e8e7c05d9b1b8da0026253c', 'Emergency Contact 255', '1867108728', 'POL47415', '781 Elm St', 'assets/patient255.jpg', 'No known allergies', '2024-02-04 00:31:23', '2024-10-08 06:30:47'),
(256, 'Benjamin Wilson', 'patient256@care.com', '1632944020', 'Group 5', 'Oncology', 'Quit', '1981-10-20', '40dd0cc4d7ceed4ffac5615b61508cf652b692605f5187ccbcf9395b3766ed77', 'Emergency Contact 256', '1704237295', 'POL92986', '562 Elm St', 'assets/patient256.jpg', 'Asthma patient', '2024-03-31 00:31:23', '2024-10-08 06:30:47'),
(257, 'Anna White', 'patient257@care.com', '1153892740', 'Group 3', 'Dermatology', 'Quit', '1999-05-17', '6af4d21f884a2a9a52f03ec70118bbdba628ef4f504230470e684c026cbeb410', 'Emergency Contact 257', '1930191876', 'POL20461', '219 Elm St', 'assets/patient257.jpg', 'No known allergies', '2024-02-08 00:31:23', '2024-10-08 06:30:47'),
(258, 'Anna Taylor', 'patient258@care.com', '1233540337', 'Group 5', 'Pediatrics', 'Online', '2017-01-15', 'cd54b51cffea5a5323573babd29710b9a6ed33114c94885cae3c0446c9b0e74f', 'Emergency Contact 258', '1550727630', 'POL74980', '287 Elm St', 'assets/patient258.jpg', 'No notes', '2023-11-24 00:31:23', '2024-10-08 06:30:47'),
(259, 'Liam White', 'patient259@care.com', '1640180977', 'Group 3', 'Neurology', 'Rest', '1985-11-12', '69e7cc71d7dc921fa5bc8fae73e13da7d0b99ed0901263c72c805bfddb7f83f4', 'Emergency Contact 259', '1411614205', 'POL14990', '519 Elm St', 'assets/patient259.jpg', 'Asthma patient', '2024-09-13 02:31:23', '2024-10-08 06:30:47'),
(260, 'David Jackson', 'patient260@care.com', '1383173205', 'Group 3', 'Dermatology', 'Quit', '2009-08-02', '7ca465e2f3a0a7bb21e85098017af65e7016a8628e1c80b79f042d2895678b82', 'Emergency Contact 260', '1700676851', 'POL49682', '322 Elm St', 'assets/patient260.jpg', 'Diabetic', '2024-01-25 00:31:23', '2024-10-08 06:30:47'),
(261, 'Michael Wilson', 'patient261@care.com', '1798693966', 'Group 5', 'Oncology', 'Quit', '2017-07-15', '3bc42acd904a0bbbc76bd86f0a7ad34fbc49130abf8c22896f95d130d24b013f', 'Emergency Contact 261', '1741127620', 'POL99720', '148 Elm St', 'assets/patient261.jpg', 'High blood pressure', '2024-07-28 02:31:23', '2024-10-08 06:30:47'),
(262, 'David Moore', 'patient262@care.com', '1655694659', 'Group 1', 'Neurology', 'Quit', '1981-11-10', '24ebeb76b2895628a473cfb3f79d69b908010fa11d2095b30af7acb59e4648fe', 'Emergency Contact 262', '1397426609', 'POL58302', '923 Elm St', 'assets/patient262.jpg', 'No notes', '2024-01-15 00:31:23', '2024-10-08 06:30:47'),
(263, 'Laura Johnson', 'patient263@care.com', '1265039139', 'Group 4', 'Pediatrics', 'Online', '2003-08-19', 'fa614d4156646db07057a8aa90a355acb363871d1f8a2e01170d421b66bd8d88', 'Emergency Contact 263', '1349416932', 'POL47193', '296 Elm St', 'assets/patient263.jpg', 'Asthma patient', '2023-12-03 00:31:23', '2024-10-08 06:30:47'),
(264, 'Emily Garcia', 'patient264@care.com', '1857075961', 'Group 2', 'Dermatology', 'Rest', '2012-12-16', 'f21060717d92fbf442ada9296cd0b9d92af102b24eb3207864653e436956f326', 'Emergency Contact 264', '1789562329', 'POL43225', '858 Elm St', 'assets/patient264.jpg', 'Diabetic', '2024-04-08 02:31:23', '2024-10-08 06:30:47'),
(265, 'Olivia White', 'patient265@care.com', '1963023788', 'Group 5', 'Orthopedics', 'Quit', '1990-03-09', '6c4ae4b2c1aa00ac2c2bd8d4452bc3fe624b984d818a17f110ca0b6c430e3085', 'Emergency Contact 265', '1158197223', 'POL39997', '152 Elm St', 'assets/patient265.jpg', 'Asthma patient', '2024-01-07 00:31:23', '2024-10-08 06:30:47'),
(266, 'Sophia Walker', 'patient266@care.com', '1262004709', 'Group 1', 'Orthopedics', 'Online', '2001-12-02', 'fd3ad5082841667ce7d3cee40a1311fc43bf241075f80420f7a092141736ec01', 'Emergency Contact 266', '1557420110', 'POL13554', '161 Elm St', 'assets/patient266.jpg', 'High blood pressure', '2024-02-11 00:31:23', '2024-10-08 06:30:47'),
(267, 'Emily Harris', 'patient267@care.com', '1140136341', 'Group 3', 'Oncology', 'Rest', '1999-02-24', 'a8d79fd7cbee06d96e4dc506d39815dbd106f660b94ca9494964a0e62a0a2d84', 'Emergency Contact 267', '1441889120', 'POL53580', '652 Elm St', 'assets/patient267.jpg', 'No notes', '2024-06-26 02:31:23', '2024-10-08 06:30:47'),
(268, 'Jane Wilson', 'patient268@care.com', '1458814046', 'Group 3', 'Pediatrics', 'Rest', '2012-10-09', 'da605a6fa3dfe27c806f2f735c6415416f82317bba0a682c2fb965ba4f41638e', 'Emergency Contact 268', '1836812722', 'POL15493', '490 Elm St', 'assets/patient268.jpg', 'No known allergies', '2024-06-20 02:31:23', '2024-10-08 06:30:47'),
(269, 'Grace Harris', 'patient269@care.com', '1739966158', 'Group 5', 'Orthopedics', 'Online', '1986-06-11', '07f273d6b91594228bd2a06b415acbc1e4843058ff591b778b68bde5074b3964', 'Emergency Contact 269', '1464096064', 'POL19109', '550 Elm St', 'assets/patient269.jpg', 'Asthma patient', '2023-10-21 00:31:23', '2024-10-08 06:30:47'),
(270, 'David Johnson', 'patient270@care.com', '1494389994', 'Group 2', 'Oncology', 'Online', '1996-03-27', '2a22b627689aad2dfa9d16acfaeb8516395cd7d6395d4e446804c95707f06d09', 'Emergency Contact 270', '1960147434', 'POL81637', '503 Elm St', 'assets/patient270.jpg', 'No notes', '2023-11-27 00:31:23', '2024-10-08 06:30:47'),
(271, 'Michael Clark', 'patient271@care.com', '1660424186', 'Group 1', 'Dermatology', 'Online', '1981-03-10', '6658fe240cf8e288a1b5c3c56605ab48501c2fc12103995f810a5c0dc601ba8d', 'Emergency Contact 271', '1191050099', 'POL53732', '551 Elm St', 'assets/patient271.jpg', 'No known allergies', '2024-01-13 00:31:23', '2024-10-08 06:30:47'),
(272, 'Jane Clark', 'patient272@care.com', '1715639499', 'Group 2', 'Orthopedics', 'Online', '2006-12-23', 'c65a8d1760d93ad245f3c244d3190bdb607ff403dd018f6bf5c441be71ce4876', 'Emergency Contact 272', '1365434563', 'POL80206', '386 Elm St', 'assets/patient272.jpg', 'Asthma patient', '2023-12-26 00:31:23', '2024-10-08 06:30:47'),
(273, 'Sophia Lee', 'patient273@care.com', '1269269741', 'Group 4', 'Dermatology', 'Online', '1989-09-09', '2006e3cdac475ac7b395a7dd4cedb926ded85fcd0cb5dddb221a0a7488cbd00f', 'Emergency Contact 273', '1297657856', 'POL58166', '488 Elm St', 'assets/patient273.jpg', 'No known allergies', '2024-03-13 00:31:23', '2024-10-08 06:30:47'),
(274, 'John Garcia', 'patient274@care.com', '1287353005', 'Group 3', 'Neurology', 'Rest', '1985-11-08', '5a7517b10d6622b4c7e2b000ac5cb811cf6c9c76a3af26af5de09ee911d4dbbf', 'Emergency Contact 274', '1345368250', 'POL35901', '967 Elm St', 'assets/patient274.jpg', 'Asthma patient', '2023-12-20 00:31:23', '2024-10-08 06:30:47'),
(275, 'Benjamin Wilson', 'patient275@care.com', '1512234998', 'Group 5', 'Neurology', 'Rest', '2019-05-19', '77726fa65ac1aa751c0dbbdebac725ee724203017b9b07799b609d8fdd576c87', 'Emergency Contact 275', '1852409853', 'POL20438', '239 Elm St', 'assets/patient275.jpg', 'Diabetic', '2023-11-24 00:31:23', '2024-10-08 06:30:47'),
(276, 'Sarah Walker', 'patient276@care.com', '1659992165', 'Group 3', 'Dermatology', 'Quit', '1982-02-11', 'dccf6217a91fed615e7e941d404fe11e215f46e2b9749cd5b7390edde4d07ad1', 'Emergency Contact 276', '1765577611', 'POL11212', '705 Elm St', 'assets/patient276.jpg', 'Diabetic', '2023-12-26 00:31:23', '2024-10-08 06:30:47'),
(277, 'Ethan Garcia', 'patient277@care.com', '1687107849', 'Group 1', 'Pediatrics', 'Online', '1982-03-11', '871d845e03ccba4cf8d681f3a0156628e4476f44f3433a30466fe9c6495a97c9', 'Emergency Contact 277', '1360463311', 'POL10876', '557 Elm St', 'assets/patient277.jpg', 'Diabetic', '2024-09-19 02:31:23', '2024-10-08 06:30:47'),
(278, 'Daniel Lewis', 'patient278@care.com', '1318686679', 'Group 2', 'Dermatology', 'Quit', '2017-06-17', 'f6169bb50e0a1245823797fc8c42c97e0c574330e26a4a2448c61c540eac27e3', 'Emergency Contact 278', '1605801367', 'POL48706', '823 Elm St', 'assets/patient278.jpg', 'Diabetic', '2024-09-25 02:31:23', '2024-10-08 06:30:47'),
(279, 'Olivia Anderson', 'patient279@care.com', '1983972564', 'Group 4', 'Pediatrics', 'Quit', '2009-01-24', '749586782881f4d92f242e95e1256db11f4b09ad14af8a93c296d73fa03a8b79', 'Emergency Contact 279', '1899912964', 'POL84931', '911 Elm St', 'assets/patient279.jpg', 'No known allergies', '2024-08-23 02:31:23', '2024-10-08 06:30:47'),
(280, 'Emily Taylor', 'patient280@care.com', '1973987156', 'Group 1', 'Pediatrics', 'Quit', '2018-12-05', '7bfc88e00db70f60bc25e3069a85c3fff032a21584a1ce1933eb98099be2e243', 'Emergency Contact 280', '1143878347', 'POL66525', '872 Elm St', 'assets/patient280.jpg', 'Diabetic', '2024-06-13 02:31:23', '2024-10-08 06:30:47'),
(281, 'Laura Lee', 'patient281@care.com', '1147184104', 'Group 3', 'Oncology', 'Quit', '2010-01-07', '09087c1ea3e18111952de7a56e6686970c9b0dd105d525657e4dd6284c290c15', 'Emergency Contact 281', '1872362245', 'POL48121', '769 Elm St', 'assets/patient281.jpg', 'Asthma patient', '2024-06-14 02:31:23', '2024-10-08 06:30:47'),
(282, 'Jane Walker', 'patient282@care.com', '1465319073', 'Group 4', 'Dermatology', 'Online', '1995-05-06', 'a1e39e0bc07f545a6ea02aebda5ac7f678dd199c7178ad0f97a28d401f55b42e', 'Emergency Contact 282', '1803530507', 'POL52369', '862 Elm St', 'assets/patient282.jpg', 'Diabetic', '2024-03-16 00:31:23', '2024-10-08 06:30:47'),
(283, 'Ethan Smith', 'patient283@care.com', '1411805680', 'Group 4', 'Pediatrics', 'Online', '2000-03-11', 'abd685bf97375cb81185f9c07632a79e085f4163d95eb7c99c5b7497219a39d6', 'Emergency Contact 283', '1480350995', 'POL50419', '501 Elm St', 'assets/patient283.jpg', 'Diabetic', '2023-11-19 00:31:23', '2024-10-08 06:30:47'),
(284, 'Grace Taylor', 'patient284@care.com', '1527679892', 'Group 2', 'Dermatology', 'Online', '1993-07-08', 'ceba25177dea28552d2ce0ad7d66ad8738510aa79fe5911baf9efe6d0f6d24b6', 'Emergency Contact 284', '1883510386', 'POL43274', '452 Elm St', 'assets/patient284.jpg', 'No known allergies', '2024-06-03 02:31:23', '2024-10-08 06:30:47'),
(285, 'James Rodriguez', 'patient285@care.com', '1665690856', 'Group 5', 'Dermatology', 'Rest', '2005-05-28', '127d2d2c9aff67af50ed98f7ac8f5eef60f94b0193d66fac0cac366bae14288b', 'Emergency Contact 285', '1402308772', 'POL60664', '203 Elm St', 'assets/patient285.jpg', 'No known allergies', '2023-11-20 00:31:23', '2024-10-08 06:30:47'),
(286, 'Sarah Walker', 'patient286@care.com', '1709525181', 'Group 4', 'Orthopedics', 'Rest', '2001-07-25', 'a1499acfab7122283a6dc4edf8b63d3f87e53ac97db1d780cce4e0126629df25', 'Emergency Contact 286', '1450569355', 'POL28385', '114 Elm St', 'assets/patient286.jpg', 'Asthma patient', '2024-02-01 00:31:23', '2024-10-08 06:30:47'),
(287, 'Sarah Brown', 'patient287@care.com', '1419020684', 'Group 2', 'Pediatrics', 'Rest', '1983-08-23', '83c704f62a7a81e8a04b4955d6c0c23b2af43d8c7063328b7a1552920c2c8e59', 'Emergency Contact 287', '1416816541', 'POL73737', '760 Elm St', 'assets/patient287.jpg', 'High blood pressure', '2023-10-20 00:31:23', '2024-10-08 06:30:47'),
(288, 'David Martinez', 'patient288@care.com', '1776513508', 'Group 5', 'Dermatology', 'Quit', '1982-02-04', '670f0cc4b4e5e7a1cb54e745ef5118a84d8e8c4ab5c4f48ac1edea058464ec49', 'Emergency Contact 288', '1802587674', 'POL61573', '914 Elm St', 'assets/patient288.jpg', 'No known allergies', '2024-08-12 02:31:23', '2024-10-08 06:30:47'),
(289, 'Emily White', 'patient289@care.com', '1126255913', 'Group 4', 'Orthopedics', 'Rest', '1993-07-26', '7068fe6127673cabfa225c7f2e5bf2ce4257e169f33742864878fbb7f8d328d3', 'Emergency Contact 289', '1963403036', 'POL10473', '358 Elm St', 'assets/patient289.jpg', 'No known allergies', '2024-07-12 02:31:23', '2024-10-08 06:30:47'),
(290, 'Liam Wilson', 'patient290@care.com', '1693915235', 'Group 5', 'Dermatology', 'Online', '2017-05-11', '026461ab1d3a34d209492cf3abb627c54521c360cdf4d43a1e08d9ac20ef2c39', 'Emergency Contact 290', '1404750908', 'POL24070', '890 Elm St', 'assets/patient290.jpg', 'Asthma patient', '2023-12-07 00:31:23', '2024-10-08 06:30:47'),
(291, 'Michael Johnson', 'patient291@care.com', '1832076968', 'Group 3', 'Orthopedics', 'Quit', '2018-06-03', '5af1341f0cb95ab0772d1046aa9cece69ba87782d2632e5076722c3e4ee3efaf', 'Emergency Contact 291', '1846673745', 'POL76003', '280 Elm St', 'assets/patient291.jpg', 'No notes', '2024-02-22 00:31:23', '2024-10-08 06:30:47'),
(292, 'Michael Brown', 'patient292@care.com', '1426313413', 'Group 2', 'Neurology', 'Online', '1984-04-07', '4aa60785f38243c19b3a53f7bf159232cbcd6a10edad9ef97ca5ef4804534fa0', 'Emergency Contact 292', '1552413445', 'POL97501', '482 Elm St', 'assets/patient292.jpg', 'Asthma patient', '2024-08-08 02:31:23', '2024-10-08 06:30:47'),
(293, 'David Harris', 'patient293@care.com', '1420407129', 'Group 1', 'Oncology', 'Quit', '2011-12-13', 'f00fd41bbe0a36a8fad65bd5daa7478f81decc0cafac96b6df9bf364bffe8529', 'Emergency Contact 293', '1871810582', 'POL11571', '881 Elm St', 'assets/patient293.jpg', 'Asthma patient', '2023-12-14 00:31:23', '2024-10-08 06:30:47'),
(294, 'David Johnson', 'patient294@care.com', '1442703820', 'Group 3', 'Orthopedics', 'Rest', '1986-10-22', '318b95170c753fa5de063c50d436625f0bc333026f01af9de357e6957b079d38', 'Emergency Contact 294', '1313649663', 'POL83596', '736 Elm St', 'assets/patient294.jpg', 'Asthma patient', '2024-01-08 00:31:23', '2024-10-08 06:30:47'),
(295, 'Olivia Harris', 'patient295@care.com', '1743413719', 'Group 3', 'Dermatology', 'Rest', '1988-09-03', 'd63da2708077722f9aeeed58722a7e94958d2152b0b85939f4232e1fca1d1882', 'Emergency Contact 295', '1679680622', 'POL38456', '173 Elm St', 'assets/patient295.jpg', 'Asthma patient', '2024-09-06 02:31:23', '2024-10-08 06:30:47'),
(296, 'Anna Wilson', 'patient296@care.com', '1629936899', 'Group 5', 'Orthopedics', 'Quit', '1999-07-28', '54a1243fdfbc040fa2c0cf963f15320684de6c315029e15d03d3a4112d707673', 'Emergency Contact 296', '1199458720', 'POL85925', '259 Elm St', 'assets/patient296.jpg', 'Diabetic', '2024-08-05 02:31:23', '2024-10-08 06:30:47'),
(297, 'Robert Wilson', 'patient297@care.com', '1151348465', 'Group 3', 'Pediatrics', 'Online', '1994-07-28', '3057389a94663baf6069f0f63e85b5d5534f582961b7bc5bb1788bc66ee2529a', 'Emergency Contact 297', '1116961911', 'POL43597', '458 Elm St', 'assets/patient297.jpg', 'No notes', '2024-01-10 00:31:23', '2024-10-08 06:30:47'),
(298, 'Olivia White', 'patient298@care.com', '1343752402', 'Group 1', 'Dermatology', 'Rest', '2009-05-14', 'febc30fe3931e6fa7ede774111748ad70c843a84c88d312e0478c80de3edf49e', 'Emergency Contact 298', '1590667930', 'POL87419', '143 Elm St', 'assets/patient298.jpg', 'Diabetic', '2024-06-17 02:31:23', '2024-10-08 06:30:47'),
(299, 'Sarah Brown', 'patient299@care.com', '1596899240', 'Group 2', 'Dermatology', 'Online', '1983-09-25', 'e1aa9579a70cdb9e864dcacf95dcc8dd3be3f42518be5fa1ba53044d60f8cb01', 'Emergency Contact 299', '1973636311', 'POL70943', '403 Elm St', 'assets/patient299.jpg', 'High blood pressure', '2024-08-16 02:31:23', '2024-10-08 06:30:47'),
(300, 'Emma Walker', 'patient300@care.com', '1674151798', 'Group 5', 'Oncology', 'Online', '1991-06-04', 'b86242f414767c9146c07849e9629d4f2c5caca93fcea0dd53018d1e16d0d890', 'Emergency Contact 300', '1926442203', 'POL32293', '708 Elm St', 'assets/patient300.jpg', 'No known allergies', '2024-04-12 02:31:23', '2024-10-08 06:30:47'),
(301, 'geor', '228579@you5788.com', NULL, NULL, NULL, 'Online', NULL, '5994471abb01112afcc18159f6cc74b4f511b99806da59b3caf5a9c173cacfc5', NULL, NULL, NULL, NULL, NULL, NULL, '2024-10-10 11:59:12', '2024-10-10 11:59:12'),
(302, 'Mei Chao Feng', 'meichaofeng@care.com', NULL, NULL, NULL, 'Online', NULL, '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', NULL, NULL, NULL, NULL, 'uploads/head.png', NULL, '2024-10-10 11:59:42', '2024-10-10 12:18:29');

-- --------------------------------------------------------

--
-- 表的结构 `patienttherapistdisease`
--

CREATE TABLE `patienttherapistdisease` (
  `patient_id` int(11) NOT NULL,
  `therapist_id` int(11) NOT NULL,
  `disease_id` int(11) NOT NULL,
  `diagnosed_date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- 转存表中的数据 `patienttherapistdisease`
--

INSERT INTO `patienttherapistdisease` (`patient_id`, `therapist_id`, `disease_id`, `diagnosed_date`) VALUES
(1, 1, 7, '2024-09-20'),
(1, 2, 7, '2024-09-22'),
(1, 8, 3, '2024-09-10'),
(2, 2, 2, '2024-09-28'),
(2, 4, 4, '2024-09-09'),
(2, 6, 3, '2024-09-23'),
(2, 6, 10, '2024-09-20'),
(3, 7, 3, '2024-09-22'),
(3, 10, 3, '2024-09-24'),
(4, 5, 1, '2024-09-13'),
(4, 7, 8, '2024-09-12'),
(4, 9, 10, '2024-09-26'),
(5, 1, 7, '2024-09-30'),
(5, 1, 10, '2024-09-13'),
(5, 5, 3, '2024-09-20'),
(5, 8, 3, '2024-09-14'),
(5, 8, 5, '2024-09-09'),
(5, 9, 6, '2024-09-16'),
(6, 3, 6, '2024-10-01'),
(6, 5, 2, '2024-09-18'),
(6, 9, 7, '2024-09-23'),
(7, 7, 5, '2024-09-21'),
(7, 7, 7, '2024-09-26'),
(7, 8, 3, '2024-09-15'),
(8, 2, 5, '2024-09-18'),
(8, 2, 10, '2024-10-04'),
(8, 4, 3, '2024-09-14'),
(8, 9, 9, '2024-09-26'),
(8, 9, 10, '2024-09-27'),
(9, 5, 6, '2024-09-06'),
(9, 6, 10, '2024-09-10'),
(10, 2, 9, '2024-09-11'),
(10, 4, 2, '2024-10-04'),
(10, 5, 2, '2024-09-21'),
(11, 4, 8, '2024-09-13'),
(11, 6, 1, '2024-09-26'),
(11, 7, 1, '2024-10-03'),
(11, 9, 9, '2024-09-14'),
(12, 2, 6, '2024-10-01'),
(13, 4, 5, '2024-09-06'),
(13, 8, 5, '2024-10-05'),
(13, 9, 6, '2024-09-19'),
(14, 7, 7, '2024-09-29'),
(14, 9, 10, '2024-09-18'),
(15, 7, 2, '2024-09-16'),
(15, 8, 6, '2024-09-09'),
(15, 9, 2, '2024-09-25'),
(15, 9, 5, '2024-10-06'),
(15, 10, 7, '2024-09-14'),
(16, 4, 5, '2024-10-04'),
(16, 7, 3, '2024-09-19'),
(17, 1, 5, '2024-09-24'),
(17, 1, 7, '2024-09-29'),
(17, 4, 2, '2024-10-03'),
(17, 4, 4, '2024-09-14'),
(17, 5, 4, '2024-09-19'),
(17, 5, 7, '2024-09-22'),
(17, 6, 10, '2024-09-20'),
(18, 2, 5, '2024-09-16'),
(19, 6, 1, '2024-09-09'),
(19, 8, 7, '2024-09-08'),
(19, 9, 1, '2024-09-22'),
(19, 9, 7, '2024-10-06'),
(20, 1, 4, '2024-09-30'),
(20, 3, 1, '2024-09-29'),
(20, 5, 4, '2024-09-27'),
(20, 5, 5, '2024-09-08'),
(20, 6, 2, '2024-09-15'),
(21, 2, 8, '2024-09-10'),
(21, 7, 7, '2024-09-27'),
(21, 9, 2, '2024-09-07'),
(22, 2, 6, '2024-09-20'),
(22, 8, 2, '2024-09-27'),
(23, 3, 2, '2024-09-19'),
(23, 4, 1, '2024-10-01'),
(23, 6, 5, '2024-10-05'),
(23, 9, 2, '2024-09-20'),
(24, 8, 8, '2024-10-03'),
(24, 9, 2, '2024-09-08'),
(25, 1, 2, '2024-09-25'),
(25, 2, 2, '2024-09-15'),
(25, 7, 1, '2024-09-29'),
(25, 7, 4, '2024-09-17'),
(25, 8, 1, '2024-09-22'),
(26, 1, 6, '2024-09-14'),
(26, 5, 9, '2024-09-13'),
(26, 7, 1, '2024-09-27'),
(26, 9, 6, '2024-10-05'),
(26, 9, 10, '2024-09-30'),
(27, 1, 5, '2024-09-28'),
(27, 3, 3, '2024-09-24'),
(28, 6, 7, '2024-09-22'),
(29, 1, 10, '2024-09-26'),
(29, 5, 5, '2024-10-03'),
(29, 5, 9, '2024-09-25'),
(29, 6, 2, '2024-09-28'),
(29, 7, 9, '2024-09-13'),
(29, 9, 2, '2024-09-21'),
(30, 5, 9, '2024-10-02'),
(30, 8, 2, '2024-09-25'),
(30, 8, 5, '2024-09-14'),
(30, 8, 9, '2024-09-28'),
(32, 1, 3, '2024-09-29'),
(32, 2, 2, '2024-10-01'),
(32, 3, 7, '2024-09-25'),
(32, 9, 1, '2024-09-23'),
(32, 9, 7, '2024-09-29'),
(33, 4, 3, '2024-09-21'),
(33, 7, 2, '2024-09-11'),
(33, 9, 7, '2024-09-16'),
(34, 3, 6, '2024-10-04'),
(34, 10, 1, '2024-09-13'),
(35, 1, 2, '2024-10-05'),
(36, 1, 4, '2024-09-23'),
(36, 4, 2, '2024-09-11'),
(36, 10, 9, '2024-09-24'),
(37, 2, 3, '2024-10-02'),
(37, 2, 5, '2024-09-28'),
(37, 2, 10, '2024-10-03'),
(37, 9, 7, '2024-09-20'),
(38, 1, 8, '2024-10-04'),
(38, 4, 2, '2024-10-02'),
(38, 7, 1, '2024-10-01'),
(38, 7, 6, '2024-09-08'),
(38, 9, 8, '2024-09-24'),
(39, 1, 8, '2024-09-22'),
(39, 4, 4, '2024-09-10'),
(39, 6, 10, '2024-09-12'),
(39, 8, 8, '2024-09-26'),
(42, 3, 6, '2024-09-17'),
(43, 1, 1, '2024-09-13'),
(43, 3, 3, '2024-09-13'),
(43, 7, 1, '2024-09-21'),
(43, 7, 7, '2024-09-24'),
(43, 8, 2, '2024-10-03'),
(43, 8, 9, '2024-09-11'),
(44, 2, 1, '2024-10-03'),
(44, 3, 6, '2024-09-26'),
(44, 10, 9, '2024-09-27'),
(45, 7, 7, '2024-09-08'),
(46, 2, 7, '2024-09-21'),
(46, 5, 10, '2024-09-29'),
(46, 6, 1, '2024-10-04'),
(46, 7, 4, '2024-10-05'),
(46, 7, 7, '2024-09-09'),
(46, 8, 1, '2024-09-30'),
(47, 2, 1, '2024-09-25'),
(47, 3, 2, '2024-09-18'),
(47, 9, 2, '2024-09-29'),
(48, 8, 6, '2024-09-09'),
(49, 2, 1, '2024-09-17'),
(49, 2, 6, '2024-09-15'),
(49, 3, 7, '2024-09-16'),
(49, 5, 3, '2024-09-10'),
(49, 9, 5, '2024-10-02'),
(50, 1, 5, '2024-09-25'),
(50, 2, 9, '2024-10-01'),
(50, 3, 7, '2024-09-29'),
(51, 4, 7, '2024-09-07'),
(51, 8, 5, '2024-10-01'),
(52, 2, 1, '2024-09-06'),
(52, 2, 10, '2024-09-08'),
(52, 3, 10, '2024-09-13'),
(52, 4, 6, '2024-10-03'),
(52, 8, 2, '2024-09-23'),
(53, 2, 6, '2024-09-07'),
(53, 4, 10, '2024-10-03'),
(53, 5, 9, '2024-09-16'),
(53, 7, 10, '2024-09-17'),
(53, 8, 4, '2024-10-06'),
(54, 3, 9, '2024-09-16'),
(54, 4, 9, '2024-09-30'),
(54, 10, 9, '2024-10-01'),
(55, 5, 9, '2024-10-01'),
(55, 6, 6, '2024-10-06'),
(56, 3, 10, '2024-09-09'),
(56, 8, 5, '2024-09-08'),
(56, 8, 6, '2024-09-09'),
(56, 8, 7, '2024-09-21'),
(57, 7, 1, '2024-09-20'),
(57, 7, 3, '2024-09-10'),
(57, 9, 5, '2024-09-16'),
(58, 4, 3, '2024-10-06'),
(58, 5, 2, '2024-09-14'),
(59, 1, 5, '2024-09-30'),
(59, 4, 1, '2024-10-02'),
(59, 4, 6, '2024-09-26'),
(59, 9, 1, '2024-09-14'),
(60, 2, 2, '2024-09-07'),
(60, 5, 7, '2024-09-30'),
(60, 8, 9, '2024-09-22'),
(60, 10, 4, '2024-09-20'),
(60, 10, 5, '2024-09-29'),
(61, 3, 6, '2024-09-14'),
(62, 1, 3, '2024-09-13'),
(62, 4, 2, '2024-09-27'),
(62, 5, 8, '2024-09-07'),
(62, 7, 3, '2024-09-27'),
(62, 10, 7, '2024-09-12'),
(63, 8, 10, '2024-09-12'),
(64, 1, 2, '2024-10-05'),
(64, 2, 4, '2024-09-12'),
(64, 3, 3, '2024-09-17'),
(64, 3, 5, '2024-09-12'),
(64, 8, 1, '2024-09-12'),
(64, 9, 2, '2024-09-22'),
(64, 9, 8, '2024-09-07'),
(64, 10, 1, '2024-09-21'),
(65, 10, 10, '2024-09-30'),
(66, 2, 6, '2024-09-17'),
(66, 4, 2, '2024-09-16'),
(66, 5, 2, '2024-09-19'),
(67, 2, 3, '2024-09-20'),
(67, 4, 2, '2024-10-03'),
(67, 5, 1, '2024-09-18'),
(67, 7, 9, '2024-09-07'),
(67, 9, 8, '2024-09-19'),
(68, 3, 9, '2024-09-19'),
(68, 5, 9, '2024-09-22'),
(68, 5, 10, '2024-09-24'),
(69, 2, 1, '2024-10-06'),
(69, 4, 2, '2024-09-09'),
(70, 3, 4, '2024-09-17'),
(70, 3, 6, '2024-09-11'),
(70, 5, 9, '2024-09-20'),
(70, 6, 4, '2024-09-25'),
(71, 5, 2, '2024-09-14'),
(71, 5, 4, '2024-09-30'),
(72, 1, 6, '2024-09-25'),
(72, 7, 5, '2024-10-06'),
(72, 7, 7, '2024-09-11'),
(72, 7, 10, '2024-10-01'),
(72, 9, 4, '2024-09-10'),
(72, 9, 8, '2024-09-27'),
(73, 5, 7, '2024-09-24'),
(74, 4, 8, '2024-09-11'),
(74, 6, 10, '2024-09-13'),
(74, 7, 5, '2024-09-14'),
(74, 9, 2, '2024-09-10'),
(74, 10, 8, '2024-10-04'),
(75, 2, 5, '2024-09-26'),
(76, 6, 5, '2024-09-24'),
(76, 8, 4, '2024-09-09'),
(76, 8, 5, '2024-09-12'),
(76, 9, 4, '2024-09-25'),
(76, 9, 7, '2024-09-18'),
(76, 10, 7, '2024-10-03'),
(77, 2, 8, '2024-10-04'),
(77, 9, 1, '2024-09-27'),
(78, 2, 6, '2024-09-13'),
(78, 7, 4, '2024-10-03'),
(78, 8, 5, '2024-10-03'),
(78, 9, 9, '2024-09-21'),
(79, 3, 9, '2024-09-09'),
(79, 9, 1, '2024-09-28'),
(79, 10, 10, '2024-09-18'),
(80, 3, 9, '2024-09-14'),
(80, 5, 1, '2024-10-06'),
(81, 6, 7, '2024-09-25'),
(81, 7, 5, '2024-09-18'),
(82, 3, 6, '2024-09-22'),
(82, 7, 9, '2024-09-21'),
(82, 9, 7, '2024-09-18'),
(83, 5, 6, '2024-09-26'),
(84, 2, 9, '2024-09-30'),
(84, 3, 8, '2024-09-11'),
(84, 4, 5, '2024-09-06'),
(84, 7, 10, '2024-09-21'),
(85, 2, 7, '2024-09-10'),
(85, 4, 2, '2024-09-18'),
(85, 10, 3, '2024-09-24'),
(86, 2, 5, '2024-10-01'),
(86, 3, 6, '2024-09-14'),
(87, 2, 2, '2024-10-01'),
(87, 3, 9, '2024-10-01'),
(87, 9, 6, '2024-10-05'),
(87, 10, 2, '2024-09-13'),
(88, 2, 6, '2024-09-16'),
(88, 4, 6, '2024-09-17'),
(88, 5, 2, '2024-09-10'),
(88, 8, 1, '2024-09-27'),
(88, 8, 5, '2024-09-26'),
(89, 2, 1, '2024-09-26'),
(89, 9, 2, '2024-09-10'),
(90, 2, 8, '2024-10-02'),
(90, 5, 6, '2024-09-20'),
(90, 6, 4, '2024-09-19'),
(90, 6, 5, '2024-09-28'),
(90, 6, 8, '2024-09-09'),
(90, 6, 9, '2024-09-19'),
(90, 9, 7, '2024-09-19'),
(91, 1, 6, '2024-09-26'),
(91, 7, 7, '2024-09-21'),
(92, 6, 2, '2024-09-19'),
(92, 6, 6, '2024-09-07'),
(92, 7, 4, '2024-09-22'),
(92, 9, 7, '2024-09-20'),
(92, 10, 3, '2024-09-13'),
(92, 10, 7, '2024-10-03'),
(93, 3, 5, '2024-09-21'),
(93, 5, 4, '2024-09-30'),
(93, 8, 6, '2024-09-23'),
(94, 2, 9, '2024-09-28'),
(94, 2, 10, '2024-09-30'),
(94, 5, 4, '2024-09-11'),
(94, 5, 8, '2024-09-13'),
(94, 6, 8, '2024-09-12'),
(95, 1, 8, '2024-09-06'),
(95, 3, 8, '2024-10-03'),
(95, 10, 6, '2024-09-20'),
(96, 1, 4, '2024-10-06'),
(96, 6, 1, '2024-09-13'),
(96, 8, 5, '2024-09-30'),
(97, 7, 10, '2024-10-01'),
(98, 3, 7, '2024-09-27'),
(98, 3, 9, '2024-09-06'),
(98, 6, 10, '2024-09-11'),
(98, 9, 3, '2024-09-13'),
(99, 3, 10, '2024-09-13'),
(99, 8, 10, '2024-09-14'),
(100, 2, 7, '2024-09-15'),
(100, 5, 10, '2024-09-17'),
(100, 9, 9, '2024-09-19'),
(101, 2, 3, '2024-10-03'),
(101, 5, 5, '2024-09-14'),
(101, 5, 7, '2024-09-18'),
(101, 6, 3, '2024-09-09'),
(101, 8, 7, '2024-09-07'),
(102, 9, 3, '2024-09-17'),
(102, 9, 6, '2024-09-26'),
(102, 10, 2, '2024-09-25'),
(103, 7, 9, '2024-09-09'),
(103, 8, 7, '2024-09-10'),
(104, 2, 4, '2024-09-15'),
(104, 5, 9, '2024-09-11'),
(104, 8, 5, '2024-09-08'),
(104, 8, 10, '2024-10-02'),
(104, 9, 6, '2024-09-07'),
(105, 2, 5, '2024-09-08'),
(105, 8, 2, '2024-09-21'),
(106, 3, 1, '2024-09-09'),
(106, 7, 9, '2024-10-04'),
(106, 10, 4, '2024-10-03'),
(107, 2, 1, '2024-09-13'),
(107, 3, 9, '2024-10-05'),
(107, 6, 9, '2024-10-02'),
(108, 6, 2, '2024-09-13'),
(108, 9, 2, '2024-09-21'),
(109, 4, 10, '2024-09-28'),
(109, 5, 6, '2024-09-13'),
(110, 4, 3, '2024-09-24'),
(110, 6, 3, '2024-09-16'),
(110, 7, 6, '2024-09-19'),
(110, 8, 5, '2024-09-22'),
(111, 6, 3, '2024-09-18'),
(111, 6, 4, '2024-09-26'),
(112, 7, 5, '2024-09-10'),
(112, 9, 5, '2024-09-12'),
(113, 5, 6, '2024-10-04'),
(113, 5, 7, '2024-10-01'),
(113, 6, 10, '2024-09-18'),
(114, 2, 6, '2024-10-02'),
(114, 4, 6, '2024-09-12'),
(115, 5, 6, '2024-09-24'),
(115, 10, 3, '2024-09-15'),
(116, 2, 2, '2024-09-21'),
(116, 3, 1, '2024-09-17'),
(116, 6, 6, '2024-09-27'),
(116, 10, 1, '2024-09-27'),
(117, 6, 4, '2024-09-08'),
(118, 3, 10, '2024-09-22'),
(119, 1, 1, '2024-09-16'),
(119, 4, 7, '2024-09-09'),
(119, 8, 9, '2024-10-04'),
(119, 9, 10, '2024-09-11'),
(120, 3, 1, '2024-09-06'),
(120, 4, 10, '2024-09-09'),
(120, 8, 5, '2024-09-25'),
(120, 9, 6, '2024-10-05'),
(121, 3, 8, '2024-09-21'),
(121, 4, 10, '2024-09-23'),
(121, 7, 4, '2024-09-20'),
(121, 8, 1, '2024-09-17'),
(121, 9, 8, '2024-09-17'),
(122, 4, 8, '2024-10-06'),
(123, 1, 8, '2024-09-21'),
(123, 2, 3, '2024-09-11'),
(123, 2, 5, '2024-09-25'),
(123, 2, 9, '2024-10-02'),
(123, 4, 4, '2024-10-04'),
(123, 8, 3, '2024-09-21'),
(124, 3, 4, '2024-10-01'),
(124, 5, 7, '2024-09-25'),
(124, 6, 1, '2024-09-12'),
(125, 3, 5, '2024-10-02'),
(125, 3, 7, '2024-09-21'),
(125, 3, 8, '2024-09-30'),
(125, 7, 9, '2024-09-20'),
(126, 3, 4, '2024-09-07'),
(126, 3, 6, '2024-09-25'),
(126, 3, 10, '2024-09-11'),
(126, 4, 1, '2024-09-15'),
(126, 4, 10, '2024-10-06'),
(126, 10, 5, '2024-09-21'),
(127, 3, 1, '2024-09-16'),
(127, 5, 7, '2024-10-02'),
(128, 3, 1, '2024-09-14'),
(128, 4, 2, '2024-10-01'),
(128, 4, 8, '2024-09-28'),
(128, 6, 6, '2024-09-09'),
(129, 2, 10, '2024-10-02'),
(129, 3, 8, '2024-09-24'),
(129, 6, 1, '2024-09-12'),
(129, 7, 6, '2024-10-01'),
(129, 8, 9, '2024-09-18'),
(129, 9, 7, '2024-09-13'),
(130, 6, 6, '2024-09-13'),
(130, 7, 5, '2024-10-06'),
(130, 8, 1, '2024-09-15'),
(131, 4, 3, '2024-09-28'),
(131, 5, 6, '2024-09-23'),
(131, 7, 9, '2024-09-18'),
(131, 8, 3, '2024-09-27'),
(132, 2, 10, '2024-09-20'),
(132, 3, 4, '2024-09-14'),
(132, 7, 1, '2024-09-29'),
(132, 8, 6, '2024-09-24'),
(133, 4, 4, '2024-09-16'),
(133, 5, 9, '2024-09-11'),
(134, 6, 2, '2024-09-12'),
(135, 2, 4, '2024-09-11'),
(135, 3, 7, '2024-09-18'),
(135, 7, 8, '2024-09-22'),
(135, 10, 5, '2024-09-24'),
(136, 4, 10, '2024-09-12'),
(136, 6, 3, '2024-09-06'),
(137, 2, 3, '2024-09-29'),
(137, 2, 4, '2024-09-22'),
(137, 4, 2, '2024-09-16'),
(137, 5, 3, '2024-09-30'),
(137, 9, 7, '2024-09-30'),
(137, 10, 5, '2024-09-08'),
(137, 10, 7, '2024-09-22'),
(138, 1, 6, '2024-09-22'),
(138, 1, 8, '2024-09-09'),
(138, 3, 10, '2024-09-15'),
(138, 4, 4, '2024-09-16'),
(138, 4, 7, '2024-09-07'),
(138, 6, 8, '2024-09-19'),
(139, 1, 1, '2024-09-28'),
(139, 2, 6, '2024-09-09'),
(139, 4, 2, '2024-10-05'),
(139, 7, 3, '2024-09-20'),
(139, 7, 5, '2024-09-15'),
(139, 10, 5, '2024-09-06'),
(140, 2, 9, '2024-09-20'),
(140, 8, 1, '2024-10-01'),
(140, 8, 3, '2024-10-02'),
(140, 9, 5, '2024-10-05'),
(141, 8, 7, '2024-09-28'),
(141, 9, 9, '2024-10-06'),
(141, 10, 7, '2024-09-15'),
(142, 6, 8, '2024-09-17'),
(142, 7, 8, '2024-10-05'),
(143, 1, 9, '2024-09-16'),
(143, 2, 4, '2024-09-21'),
(143, 4, 5, '2024-09-15'),
(143, 8, 1, '2024-09-27'),
(143, 9, 9, '2024-09-19'),
(143, 10, 6, '2024-10-03'),
(144, 5, 5, '2024-09-29'),
(145, 5, 5, '2024-09-24'),
(145, 7, 2, '2024-10-03'),
(145, 10, 6, '2024-09-15'),
(146, 1, 2, '2024-09-30'),
(146, 2, 10, '2024-10-01'),
(146, 4, 10, '2024-09-26'),
(146, 5, 1, '2024-09-18'),
(146, 5, 9, '2024-09-06'),
(146, 5, 10, '2024-10-06'),
(146, 10, 8, '2024-09-15'),
(147, 2, 8, '2024-09-30'),
(147, 3, 10, '2024-09-10'),
(147, 4, 8, '2024-09-07'),
(147, 9, 6, '2024-09-22'),
(148, 3, 10, '2024-09-07'),
(148, 4, 5, '2024-09-28'),
(148, 5, 5, '2024-09-08'),
(148, 5, 6, '2024-10-04'),
(148, 6, 2, '2024-09-08'),
(149, 1, 8, '2024-10-03'),
(149, 6, 10, '2024-10-02'),
(149, 9, 10, '2024-09-20'),
(150, 4, 9, '2024-09-11'),
(150, 5, 7, '2024-09-10'),
(151, 2, 8, '2024-09-23'),
(151, 8, 5, '2024-09-24'),
(151, 10, 4, '2024-09-06'),
(152, 3, 1, '2024-10-03'),
(152, 6, 4, '2024-09-30'),
(152, 6, 7, '2024-10-02'),
(153, 7, 7, '2024-10-05'),
(153, 10, 6, '2024-09-15'),
(154, 6, 8, '2024-09-22'),
(155, 3, 2, '2024-10-03'),
(155, 3, 4, '2024-09-25'),
(155, 8, 1, '2024-09-10'),
(155, 10, 6, '2024-09-21'),
(156, 3, 5, '2024-09-23'),
(156, 6, 9, '2024-09-15'),
(156, 7, 7, '2024-09-27'),
(156, 9, 7, '2024-09-17'),
(156, 9, 8, '2024-09-14'),
(157, 7, 10, '2024-09-08'),
(157, 8, 6, '2024-09-28'),
(157, 8, 10, '2024-10-06'),
(158, 5, 1, '2024-09-24'),
(158, 5, 2, '2024-09-30'),
(158, 6, 9, '2024-09-13'),
(158, 7, 5, '2024-09-13'),
(158, 7, 8, '2024-10-04'),
(158, 10, 3, '2024-09-08'),
(159, 2, 4, '2024-09-24'),
(159, 5, 7, '2024-09-26'),
(159, 6, 4, '2024-09-18'),
(159, 7, 3, '2024-09-30'),
(159, 10, 10, '2024-09-27'),
(160, 2, 9, '2024-09-14'),
(160, 3, 5, '2024-09-28'),
(160, 4, 10, '2024-09-24'),
(161, 1, 1, '2024-09-08'),
(161, 4, 8, '2024-10-01'),
(161, 6, 2, '2024-09-08'),
(162, 1, 4, '2024-09-25'),
(162, 3, 8, '2024-10-05'),
(162, 4, 1, '2024-09-23'),
(162, 4, 8, '2024-09-14'),
(162, 5, 5, '2024-09-23'),
(162, 6, 3, '2024-09-29'),
(162, 7, 7, '2024-09-17'),
(162, 7, 8, '2024-09-13'),
(162, 9, 4, '2024-09-25'),
(163, 5, 6, '2024-10-03'),
(164, 2, 9, '2024-10-03'),
(164, 5, 6, '2024-09-17'),
(164, 8, 10, '2024-09-28'),
(165, 1, 7, '2024-09-20'),
(165, 6, 9, '2024-09-24'),
(165, 8, 1, '2024-09-14'),
(166, 3, 9, '2024-09-23'),
(166, 4, 7, '2024-09-15'),
(166, 7, 5, '2024-09-18'),
(166, 8, 2, '2024-09-20'),
(168, 2, 10, '2024-09-17'),
(168, 5, 3, '2024-10-05'),
(168, 6, 2, '2024-09-07'),
(168, 7, 8, '2024-09-17'),
(169, 5, 2, '2024-09-17'),
(170, 4, 10, '2024-10-03'),
(171, 1, 1, '2024-09-21'),
(171, 7, 4, '2024-09-20'),
(171, 10, 1, '2024-09-24'),
(172, 2, 6, '2024-09-25'),
(172, 9, 1, '2024-09-26'),
(172, 10, 10, '2024-09-16'),
(173, 5, 10, '2024-10-03'),
(173, 8, 4, '2024-09-25'),
(173, 9, 9, '2024-09-25'),
(173, 10, 4, '2024-09-21'),
(174, 3, 3, '2024-09-26'),
(174, 4, 5, '2024-10-03'),
(174, 9, 4, '2024-09-23'),
(174, 9, 5, '2024-09-06'),
(174, 9, 8, '2024-10-02'),
(175, 2, 8, '2024-09-26'),
(175, 3, 6, '2024-09-17'),
(175, 4, 2, '2024-09-23'),
(176, 4, 8, '2024-09-12'),
(176, 6, 6, '2024-10-01'),
(176, 9, 6, '2024-09-25'),
(177, 2, 4, '2024-10-06'),
(177, 6, 4, '2024-09-22'),
(177, 9, 10, '2024-09-06'),
(178, 4, 8, '2024-10-02'),
(178, 9, 7, '2024-09-09'),
(178, 10, 6, '2024-10-04'),
(179, 1, 6, '2024-09-28'),
(179, 4, 2, '2024-10-06'),
(179, 6, 1, '2024-09-16'),
(179, 7, 2, '2024-09-29'),
(179, 9, 2, '2024-09-14'),
(180, 7, 10, '2024-09-13'),
(180, 8, 10, '2024-09-26'),
(180, 10, 3, '2024-09-20'),
(181, 7, 1, '2024-09-26'),
(181, 8, 7, '2024-09-07'),
(181, 9, 1, '2024-09-10'),
(182, 4, 8, '2024-10-05'),
(182, 6, 9, '2024-09-15'),
(183, 6, 4, '2024-10-03'),
(183, 6, 6, '2024-10-04'),
(183, 8, 8, '2024-09-08'),
(183, 9, 5, '2024-09-28'),
(184, 5, 2, '2024-09-25'),
(184, 9, 7, '2024-09-17'),
(184, 9, 8, '2024-09-10'),
(185, 4, 1, '2024-09-07'),
(185, 5, 2, '2024-09-15'),
(185, 5, 7, '2024-09-12'),
(185, 5, 9, '2024-09-23'),
(185, 10, 1, '2024-09-15'),
(186, 6, 10, '2024-09-07'),
(186, 7, 8, '2024-09-11'),
(186, 9, 1, '2024-10-06'),
(187, 1, 3, '2024-09-23'),
(187, 3, 7, '2024-09-17'),
(187, 5, 5, '2024-09-13'),
(188, 1, 3, '2024-09-15'),
(188, 1, 6, '2024-09-10'),
(188, 3, 1, '2024-09-24'),
(188, 9, 1, '2024-09-21'),
(189, 2, 1, '2024-09-13'),
(189, 2, 6, '2024-09-22'),
(189, 4, 5, '2024-09-25'),
(190, 1, 5, '2024-09-16'),
(190, 5, 5, '2024-09-07'),
(190, 5, 7, '2024-09-17'),
(190, 6, 3, '2024-09-22'),
(190, 8, 4, '2024-09-25'),
(190, 10, 9, '2024-09-26'),
(191, 1, 4, '2024-10-01'),
(191, 3, 1, '2024-09-21'),
(191, 10, 8, '2024-09-10'),
(192, 1, 7, '2024-09-08'),
(192, 2, 10, '2024-09-14'),
(192, 3, 3, '2024-09-14'),
(192, 4, 1, '2024-09-23'),
(192, 9, 8, '2024-09-24'),
(194, 2, 10, '2024-09-28'),
(194, 6, 2, '2024-09-10'),
(195, 2, 10, '2024-09-23'),
(195, 9, 6, '2024-10-02'),
(197, 4, 5, '2024-10-02'),
(198, 6, 3, '2024-09-14'),
(198, 10, 6, '2024-09-14'),
(199, 3, 3, '2024-09-09'),
(199, 3, 4, '2024-09-24'),
(200, 1, 1, '2024-09-28'),
(200, 4, 7, '2024-10-06'),
(200, 7, 1, '2024-09-16'),
(200, 8, 2, '2024-09-18'),
(200, 10, 6, '2024-09-22'),
(200, 10, 10, '2024-09-15'),
(201, 8, 3, '2024-09-19'),
(201, 9, 2, '2024-09-20'),
(201, 10, 5, '2024-09-30'),
(202, 6, 2, '2024-09-29'),
(202, 10, 2, '2024-09-24'),
(203, 4, 6, '2024-10-01'),
(203, 6, 4, '2024-09-25'),
(204, 5, 2, '2024-09-11'),
(205, 1, 6, '2024-09-26'),
(205, 2, 10, '2024-09-16'),
(205, 5, 9, '2024-09-09'),
(206, 1, 5, '2024-09-15'),
(206, 2, 2, '2024-09-16'),
(206, 8, 10, '2024-09-18'),
(206, 9, 10, '2024-09-12'),
(206, 10, 6, '2024-09-07'),
(207, 2, 3, '2024-10-04'),
(207, 7, 8, '2024-09-10'),
(207, 8, 9, '2024-09-24'),
(208, 2, 1, '2024-10-05'),
(209, 4, 10, '2024-09-23'),
(210, 5, 4, '2024-09-28'),
(210, 10, 1, '2024-10-03'),
(211, 2, 2, '2024-09-25'),
(211, 2, 9, '2024-09-15'),
(211, 4, 6, '2024-09-12'),
(211, 8, 1, '2024-09-15'),
(211, 10, 8, '2024-09-12'),
(212, 7, 2, '2024-09-17'),
(212, 10, 7, '2024-10-04'),
(213, 3, 5, '2024-09-26'),
(213, 7, 10, '2024-09-24'),
(213, 8, 9, '2024-09-11'),
(214, 2, 4, '2024-09-17'),
(214, 8, 10, '2024-09-07'),
(214, 9, 9, '2024-09-07'),
(215, 3, 9, '2024-09-15'),
(215, 4, 8, '2024-09-15'),
(215, 5, 3, '2024-09-13'),
(215, 7, 4, '2024-09-12'),
(215, 7, 9, '2024-09-11'),
(216, 3, 2, '2024-09-27'),
(216, 7, 7, '2024-09-13'),
(217, 2, 1, '2024-09-16'),
(217, 3, 1, '2024-09-30'),
(217, 7, 1, '2024-09-08'),
(217, 8, 9, '2024-09-24'),
(218, 2, 9, '2024-10-04'),
(218, 6, 8, '2024-09-10'),
(218, 10, 5, '2024-09-11'),
(219, 1, 6, '2024-09-28'),
(220, 5, 9, '2024-09-12'),
(220, 10, 2, '2024-09-27'),
(221, 1, 9, '2024-09-18'),
(221, 3, 5, '2024-09-14'),
(221, 4, 3, '2024-09-15'),
(221, 8, 4, '2024-09-18'),
(222, 1, 2, '2024-09-22'),
(222, 3, 7, '2024-09-13'),
(222, 5, 1, '2024-09-26'),
(222, 6, 6, '2024-09-10'),
(222, 8, 10, '2024-09-21'),
(223, 2, 4, '2024-09-24'),
(223, 6, 5, '2024-09-22'),
(223, 7, 3, '2024-09-20'),
(223, 9, 8, '2024-09-18'),
(224, 2, 9, '2024-10-02'),
(224, 3, 3, '2024-10-01'),
(224, 4, 7, '2024-09-09'),
(224, 4, 10, '2024-09-14'),
(224, 6, 7, '2024-09-28'),
(225, 3, 2, '2024-09-10'),
(225, 4, 3, '2024-09-15'),
(225, 6, 10, '2024-09-27'),
(225, 8, 2, '2024-09-25'),
(225, 9, 6, '2024-09-26'),
(226, 3, 6, '2024-09-27'),
(226, 3, 7, '2024-09-23'),
(226, 9, 5, '2024-09-18'),
(226, 9, 6, '2024-09-29'),
(226, 10, 3, '2024-09-27'),
(226, 10, 4, '2024-09-28'),
(227, 2, 4, '2024-10-01'),
(227, 3, 3, '2024-10-03'),
(227, 8, 9, '2024-09-20'),
(227, 9, 3, '2024-09-30'),
(227, 9, 8, '2024-09-08'),
(228, 1, 2, '2024-10-01'),
(228, 4, 3, '2024-09-18'),
(228, 4, 9, '2024-10-05'),
(228, 7, 3, '2024-09-25'),
(229, 1, 6, '2024-09-20'),
(229, 2, 2, '2024-09-20'),
(229, 6, 9, '2024-09-20'),
(229, 10, 9, '2024-10-03'),
(230, 1, 3, '2024-10-05'),
(230, 5, 6, '2024-09-21'),
(230, 7, 4, '2024-10-04'),
(230, 7, 8, '2024-10-01'),
(230, 10, 1, '2024-09-15'),
(231, 3, 6, '2024-09-15'),
(231, 5, 9, '2024-09-21'),
(232, 3, 10, '2024-09-25'),
(232, 7, 3, '2024-09-14'),
(232, 9, 10, '2024-09-20'),
(233, 1, 3, '2024-09-12'),
(233, 4, 5, '2024-09-06'),
(233, 5, 5, '2024-10-01'),
(233, 6, 6, '2024-09-23'),
(233, 6, 9, '2024-10-02'),
(233, 7, 8, '2024-10-01'),
(233, 7, 9, '2024-09-22'),
(233, 8, 6, '2024-09-30'),
(233, 10, 6, '2024-09-22'),
(234, 1, 7, '2024-09-26'),
(234, 5, 9, '2024-09-16'),
(235, 1, 2, '2024-09-21'),
(235, 6, 9, '2024-09-09'),
(236, 7, 9, '2024-10-02'),
(236, 8, 10, '2024-09-27'),
(236, 9, 4, '2024-09-20'),
(236, 10, 6, '2024-09-29'),
(237, 3, 9, '2024-09-07'),
(237, 5, 3, '2024-09-18'),
(237, 6, 10, '2024-09-19'),
(237, 7, 1, '2024-09-29'),
(237, 9, 5, '2024-09-26'),
(237, 10, 7, '2024-09-30'),
(238, 8, 8, '2024-10-04'),
(239, 3, 2, '2024-09-30'),
(239, 4, 5, '2024-09-07'),
(240, 2, 9, '2024-09-28'),
(240, 4, 5, '2024-09-23'),
(240, 6, 1, '2024-09-27'),
(241, 2, 5, '2024-09-21'),
(241, 4, 9, '2024-09-26'),
(241, 5, 1, '2024-10-04'),
(241, 9, 3, '2024-09-08'),
(241, 9, 9, '2024-09-23'),
(241, 10, 7, '2024-09-15'),
(242, 2, 3, '2024-09-28'),
(242, 5, 2, '2024-09-25'),
(242, 6, 3, '2024-09-25'),
(242, 10, 5, '2024-09-15'),
(243, 5, 10, '2024-10-06'),
(244, 3, 5, '2024-09-25'),
(244, 5, 6, '2024-10-01'),
(244, 8, 1, '2024-09-22'),
(245, 2, 8, '2024-10-03'),
(245, 4, 2, '2024-09-12'),
(245, 4, 3, '2024-09-07'),
(245, 6, 7, '2024-09-21'),
(245, 10, 10, '2024-09-23'),
(246, 2, 9, '2024-09-28'),
(247, 2, 3, '2024-09-11'),
(247, 8, 4, '2024-10-01'),
(247, 8, 5, '2024-09-13'),
(248, 2, 3, '2024-09-10'),
(248, 3, 5, '2024-09-29'),
(248, 4, 2, '2024-09-09'),
(248, 4, 5, '2024-09-12'),
(248, 5, 10, '2024-09-11'),
(248, 8, 1, '2024-09-23'),
(249, 1, 6, '2024-09-19'),
(249, 3, 6, '2024-09-20'),
(249, 4, 8, '2024-09-12'),
(249, 7, 3, '2024-09-27'),
(250, 1, 1, '2024-10-05'),
(250, 1, 5, '2024-09-21'),
(250, 4, 5, '2024-09-23'),
(250, 4, 7, '2024-09-24'),
(251, 3, 10, '2024-09-27'),
(251, 4, 7, '2024-09-13'),
(251, 5, 4, '2024-09-30'),
(251, 6, 7, '2024-09-18'),
(251, 10, 1, '2024-09-08'),
(252, 8, 7, '2024-09-23'),
(252, 9, 5, '2024-09-24'),
(253, 8, 3, '2024-09-23'),
(253, 9, 5, '2024-10-02'),
(253, 9, 10, '2024-09-24'),
(254, 8, 7, '2024-09-25'),
(254, 8, 10, '2024-10-03'),
(255, 2, 7, '2024-09-09'),
(255, 2, 8, '2024-09-17'),
(255, 3, 9, '2024-09-28'),
(255, 4, 5, '2024-09-23'),
(255, 8, 10, '2024-09-12'),
(256, 2, 1, '2024-09-21'),
(256, 2, 7, '2024-09-15'),
(256, 3, 5, '2024-09-09'),
(256, 3, 8, '2024-09-09'),
(256, 4, 9, '2024-09-15'),
(256, 9, 4, '2024-09-30'),
(256, 9, 6, '2024-09-27'),
(257, 3, 9, '2024-09-11'),
(257, 5, 8, '2024-09-18'),
(257, 7, 9, '2024-09-20'),
(257, 8, 2, '2024-09-20'),
(257, 8, 6, '2024-09-25'),
(258, 1, 8, '2024-09-25'),
(258, 6, 9, '2024-09-21'),
(259, 1, 9, '2024-09-27'),
(259, 7, 7, '2024-09-27'),
(259, 7, 8, '2024-09-07'),
(259, 8, 2, '2024-10-02'),
(259, 8, 10, '2024-09-09'),
(259, 9, 8, '2024-09-21'),
(260, 8, 6, '2024-09-23'),
(260, 9, 4, '2024-09-20'),
(261, 2, 10, '2024-09-18'),
(261, 5, 2, '2024-09-17'),
(261, 6, 2, '2024-09-23'),
(261, 6, 10, '2024-09-16'),
(261, 10, 4, '2024-10-05'),
(262, 1, 8, '2024-09-08'),
(262, 4, 8, '2024-09-21'),
(262, 7, 3, '2024-09-25'),
(262, 9, 8, '2024-09-24'),
(263, 1, 10, '2024-09-29'),
(263, 2, 3, '2024-09-15'),
(263, 6, 8, '2024-09-12'),
(263, 9, 4, '2024-09-26'),
(265, 5, 1, '2024-09-29'),
(265, 9, 6, '2024-09-17'),
(265, 10, 7, '2024-09-23'),
(266, 1, 2, '2024-09-19'),
(266, 4, 8, '2024-09-16'),
(266, 6, 6, '2024-09-14'),
(267, 6, 7, '2024-09-07'),
(268, 7, 2, '2024-09-08'),
(268, 9, 4, '2024-09-24'),
(268, 10, 6, '2024-10-04'),
(269, 1, 6, '2024-09-30'),
(269, 4, 2, '2024-09-15'),
(269, 4, 6, '2024-09-30'),
(270, 2, 2, '2024-09-17'),
(270, 2, 7, '2024-09-28'),
(270, 3, 2, '2024-09-30'),
(270, 3, 8, '2024-09-11'),
(271, 6, 4, '2024-09-21'),
(271, 6, 10, '2024-09-17'),
(271, 8, 6, '2024-09-10'),
(271, 9, 1, '2024-09-18'),
(272, 4, 4, '2024-09-26'),
(272, 8, 4, '2024-09-15'),
(273, 3, 10, '2024-09-22'),
(273, 10, 6, '2024-09-09'),
(274, 3, 9, '2024-09-30'),
(274, 9, 1, '2024-09-12'),
(275, 1, 5, '2024-09-29'),
(275, 5, 4, '2024-09-28'),
(275, 6, 1, '2024-09-11'),
(275, 8, 2, '2024-09-22'),
(275, 9, 3, '2024-10-02'),
(276, 1, 5, '2024-09-26'),
(276, 4, 10, '2024-09-20'),
(276, 7, 1, '2024-09-18'),
(277, 3, 8, '2024-10-05'),
(277, 8, 7, '2024-09-17'),
(278, 2, 10, '2024-09-09'),
(278, 4, 1, '2024-10-05'),
(278, 4, 5, '2024-09-28'),
(279, 1, 1, '2024-09-27'),
(279, 3, 10, '2024-09-21'),
(279, 4, 8, '2024-09-08'),
(279, 8, 2, '2024-10-04'),
(279, 9, 5, '2024-09-24'),
(281, 1, 8, '2024-09-07'),
(281, 5, 3, '2024-09-29'),
(281, 9, 5, '2024-10-02'),
(281, 9, 6, '2024-10-05'),
(282, 3, 3, '2024-09-20'),
(282, 5, 7, '2024-09-18'),
(282, 8, 10, '2024-09-10'),
(283, 2, 2, '2024-10-02'),
(283, 2, 3, '2024-09-12'),
(283, 3, 3, '2024-09-21'),
(283, 6, 9, '2024-09-13'),
(283, 7, 4, '2024-09-12'),
(283, 9, 2, '2024-09-07'),
(283, 9, 5, '2024-09-23'),
(284, 1, 5, '2024-09-18'),
(284, 2, 4, '2024-09-18'),
(284, 6, 4, '2024-10-02'),
(284, 7, 1, '2024-09-07'),
(285, 6, 3, '2024-09-27'),
(286, 1, 9, '2024-10-04'),
(286, 2, 1, '2024-10-01'),
(286, 2, 10, '2024-10-03'),
(286, 7, 4, '2024-10-06'),
(286, 7, 8, '2024-09-21'),
(286, 10, 3, '2024-10-03'),
(287, 2, 3, '2024-09-11'),
(287, 2, 8, '2024-09-21'),
(287, 7, 7, '2024-09-19'),
(288, 3, 1, '2024-09-10'),
(288, 4, 7, '2024-09-25'),
(288, 4, 9, '2024-09-11'),
(288, 7, 7, '2024-09-30'),
(288, 10, 2, '2024-09-07'),
(289, 2, 1, '2024-09-29'),
(289, 2, 7, '2024-09-23'),
(289, 5, 8, '2024-09-10'),
(289, 7, 1, '2024-10-01'),
(289, 9, 2, '2024-09-12'),
(290, 3, 1, '2024-10-02'),
(290, 10, 1, '2024-10-04'),
(291, 3, 10, '2024-10-04'),
(291, 4, 5, '2024-09-23'),
(291, 4, 7, '2024-09-19'),
(291, 5, 4, '2024-09-21'),
(291, 6, 2, '2024-09-10'),
(291, 9, 5, '2024-09-08'),
(292, 3, 8, '2024-09-09'),
(292, 6, 6, '2024-10-05'),
(292, 7, 3, '2024-09-08'),
(292, 9, 4, '2024-09-13'),
(292, 10, 7, '2024-09-18'),
(293, 9, 3, '2024-09-27'),
(293, 10, 10, '2024-09-22'),
(294, 3, 10, '2024-09-30'),
(294, 6, 1, '2024-09-27'),
(294, 10, 9, '2024-09-29'),
(295, 4, 6, '2024-09-27'),
(295, 6, 1, '2024-10-05'),
(295, 7, 10, '2024-09-29'),
(295, 8, 1, '2024-09-07'),
(296, 8, 8, '2024-09-29'),
(296, 10, 1, '2024-09-29'),
(297, 1, 4, '2024-09-18'),
(297, 3, 2, '2024-09-21'),
(297, 9, 7, '2024-09-10'),
(298, 1, 3, '2024-09-22'),
(298, 1, 4, '2024-10-02'),
(298, 4, 5, '2024-09-13'),
(298, 5, 10, '2024-10-05'),
(298, 7, 10, '2024-09-13'),
(298, 9, 7, '2024-09-18'),
(298, 9, 10, '2024-09-11'),
(299, 9, 6, '2024-09-13'),
(299, 9, 10, '2024-09-22'),
(299, 10, 6, '2024-09-16'),
(300, 5, 6, '2024-09-26'),
(300, 7, 2, '2024-09-08'),
(300, 7, 5, '2024-09-29'),
(300, 10, 10, '2024-09-30');

-- --------------------------------------------------------

--
-- 表的结构 `therapists`
--

CREATE TABLE `therapists` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `field` varchar(255) DEFAULT NULL,
  `phone_number` varchar(20) DEFAULT NULL,
  `specialty` varchar(255) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `appointment_color` varchar(7) NOT NULL,
  `photo` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `brief` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- 转存表中的数据 `therapists`
--

INSERT INTO `therapists` (`id`, `name`, `email`, `field`, `phone_number`, `specialty`, `password`, `appointment_color`, `photo`, `created_at`, `updated_at`, `brief`) VALUES
(1, 'Dr. John Smith', 'johnsmith@care.com', 'Psychodynamic Therapy', '1111111111', 'Psychiatry', '29618d60acd075fc93cac898b8e4a1231e97aaabcb851566756b171448f92ef5', '#ff5733', 'assets/therapist1.jpg', '2024-10-05 02:08:33', '2024-10-11 01:26:38', NULL),
(2, 'Dr. Alice Johnson', 'alicejohnson@care.com', 'Personality Disorders Therapy', '2222222222', 'Pediatrics', '6cf615d5bcaac778352a8f1f3360d23f02f34ec182e259897fd6ce485d7870d4', '#33ff57', 'assets/therapist2.jpg', '2024-10-05 02:08:33', '2024-10-10 08:16:51', NULL),
(3, 'Dr. Robert Brown', 'robertbrown@care.com', 'Eating Disorders Counseling', '3333333333', 'Neurology', '5906ac361a137e2d286465cd6588ebb5ac3f5ae955001100bc41577c3d751764', '#3357ff', 'assets/therapist3.jpg', '2024-10-05 02:08:33', '2024-10-10 08:16:51', NULL),
(4, 'Dr. Maria Lee', 'marialee@care.com', 'Personality Disorders Therapy', '4444444444', 'Dermatology', 'b97873a40f73abedd8d685a7cd5e5f85e4a9cfb83eac26886640a0813850122b', '#ff33a1', 'assets/therapist4.jpg', '2024-10-05 02:08:33', '2024-10-10 08:16:51', NULL),
(5, 'Dr. David Garcia', 'davidgarcia@care.com', 'Personality Disorders Therapy', '5555555555', 'General Medicine', '8b2c86ea9cf2ea4eb517fd1e06b74f399e7fec0fef92e3b482a6cf2e2b092023', '#a133ff', 'assets/therapist5.jpg', '2024-10-05 02:08:33', '2024-10-10 08:16:51', NULL),
(6, 'Dr. Emily Wilson', 'emilywilson@care.com', 'Child and Adolescent Therapy', '6666666666', 'Psychiatry', '598a1a400c1dfdf36974e69d7e1bc98593f2e15015eed8e9b7e47a83b31693d5', '#33ffaa', 'assets/therapist6.jpg', '2024-10-05 02:08:33', '2024-10-10 08:16:51', NULL),
(7, 'Dr. Michael Martinez', 'michaelmartinez@care.com', 'Art Therapy', '7777777777', 'Cardiology', '5860836e8f13fc9837539a597d4086bfc0299e54ad92148d54538b5c3feefb7c', '#ffaa33', 'assets/therapist7.jpg', '2024-10-05 02:08:33', '2024-10-10 08:16:51', NULL),
(8, 'Dr. Sarah Davis', 'sarahdavis@care.com', 'Personality Disorders Therapy', '8888888888', 'Oncology', '57f3ebab63f156fd8f776ba645a55d96360a15eeffc8b0e4afe4c05fa88219aa', '#ff3333', 'assets/therapist8.jpg', '2024-10-05 02:08:33', '2024-10-10 08:16:51', NULL),
(9, 'Dr. Anthony Lopez', 'anthonylopez@care.com', 'Personality Disorders Therapy', '9999999999', 'Orthopedics', '9323dd6786ebcbf3ac87357cc78ba1abfda6cf5e55cd01097b90d4a286cac90e', '#33ff33', 'assets/therapist9.jpg', '2024-10-05 02:08:33', '2024-10-10 08:16:51', NULL),
(10, 'Dr. Jessica White', 'jessicawhite@care.com', 'Mindfulness-Based Therapy', '1010101010', 'Pediatrics', 'aa4a9ea03fcac15b5fc63c949ac34e7b0fd17906716ac3b8e58c599cdc5a52f0', '#3333ff', 'assets/therapist10.jpg', '2024-10-05 02:08:33', '2024-10-10 08:16:51', NULL),
(11, '', '', 'Psychodynamic Therapy', NULL, NULL, '', '', NULL, '2024-10-10 09:28:00', '2024-10-10 09:28:00', ''),
(14, '1', '2@care.com', 'Personality Disorders Therapy', NULL, NULL, '', '', NULL, '2024-10-10 09:37:17', '2024-10-10 09:37:17', '1111'),
(15, '1', '23@care.com', 'Personality Disorders Therapy', NULL, NULL, '', '', NULL, '2024-10-10 09:38:24', '2024-10-10 09:38:24', '111'),
(16, '123', '123@care.com', 'Personality Disorders Therapy', NULL, NULL, '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', '', NULL, '2024-10-10 09:41:59', '2024-10-10 09:41:59', 'ddddd');

-- --------------------------------------------------------

--
-- 表的结构 `therapist_assigned_patients`
--

CREATE TABLE `therapist_assigned_patients` (
  `id` int(11) NOT NULL,
  `therapist_id` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `assignment_type` enum('Primary','Consultant') DEFAULT 'Primary',
  `assigned_date` date NOT NULL DEFAULT curdate(),
  `status` enum('Active','Completed','On hold') DEFAULT 'Active'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- 转存表中的数据 `therapist_assigned_patients`
--

INSERT INTO `therapist_assigned_patients` (`id`, `therapist_id`, `patient_id`, `assignment_type`, `assigned_date`, `status`) VALUES
(1, 1, 1, 'Primary', '2023-01-10', 'Active'),
(2, 1, 4, 'Consultant', '2023-01-20', 'Completed'),
(3, 2, 2, 'Primary', '2023-02-05', 'Active'),
(4, 3, 3, 'Consultant', '2023-03-15', 'Active'),
(5, 4, 5, 'Primary', '2023-04-10', 'On hold'),
(6, 5, 1, 'Consultant', '2023-05-12', 'Completed'),
(7, 14, 2, 'Primary', '2024-10-10', 'Active'),
(8, 14, 3, 'Primary', '2024-10-10', 'Active');

--
-- 转储表的索引
--

--
-- 表的索引 `appointments`
--
ALTER TABLE `appointments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `therapist_id` (`therapist_id`),
  ADD KEY `patient_id` (`patient_id`);

--
-- 表的索引 `auditors`
--
ALTER TABLE `auditors`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- 表的索引 `certification`
--
ALTER TABLE `certification`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `groupmeetings`
--
ALTER TABLE `groupmeetings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `group_id` (`group_id`);

--
-- 表的索引 `groupnotes`
--
ALTER TABLE `groupnotes`
  ADD PRIMARY KEY (`note_id`),
  ADD KEY `group_id` (`group_id`);

--
-- 表的索引 `grouppatient`
--
ALTER TABLE `grouppatient`
  ADD PRIMARY KEY (`group_id`,`patient_id`),
  ADD KEY `patient_id` (`patient_id`);

--
-- 表的索引 `groups`
--
ALTER TABLE `groups`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `mentaldiseases`
--
ALTER TABLE `mentaldiseases`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `patientdailyrecords`
--
ALTER TABLE `patientdailyrecords`
  ADD PRIMARY KEY (`id`),
  ADD KEY `patient_id` (`patient_id`);

--
-- 表的索引 `patientnotes`
--
ALTER TABLE `patientnotes`
  ADD PRIMARY KEY (`note_id`),
  ADD KEY `patient_id` (`patient_id`),
  ADD KEY `therapist_id` (`therapist_id`);

--
-- 表的索引 `patients`
--
ALTER TABLE `patients`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- 表的索引 `patienttherapistdisease`
--
ALTER TABLE `patienttherapistdisease`
  ADD PRIMARY KEY (`patient_id`,`therapist_id`,`disease_id`),
  ADD KEY `therapist_id` (`therapist_id`),
  ADD KEY `disease_id` (`disease_id`);

--
-- 表的索引 `therapists`
--
ALTER TABLE `therapists`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- 表的索引 `therapist_assigned_patients`
--
ALTER TABLE `therapist_assigned_patients`
  ADD PRIMARY KEY (`id`),
  ADD KEY `therapist_id` (`therapist_id`),
  ADD KEY `patient_id` (`patient_id`);

--
-- 在导出的表使用AUTO_INCREMENT
--

--
-- 使用表AUTO_INCREMENT `appointments`
--
ALTER TABLE `appointments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- 使用表AUTO_INCREMENT `auditors`
--
ALTER TABLE `auditors`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- 使用表AUTO_INCREMENT `certification`
--
ALTER TABLE `certification`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `groupmeetings`
--
ALTER TABLE `groupmeetings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- 使用表AUTO_INCREMENT `groupnotes`
--
ALTER TABLE `groupnotes`
  MODIFY `note_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- 使用表AUTO_INCREMENT `groups`
--
ALTER TABLE `groups`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- 使用表AUTO_INCREMENT `mentaldiseases`
--
ALTER TABLE `mentaldiseases`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- 使用表AUTO_INCREMENT `patientdailyrecords`
--
ALTER TABLE `patientdailyrecords`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=118;

--
-- 使用表AUTO_INCREMENT `patientnotes`
--
ALTER TABLE `patientnotes`
  MODIFY `note_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- 使用表AUTO_INCREMENT `patients`
--
ALTER TABLE `patients`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=303;

--
-- 使用表AUTO_INCREMENT `therapists`
--
ALTER TABLE `therapists`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- 使用表AUTO_INCREMENT `therapist_assigned_patients`
--
ALTER TABLE `therapist_assigned_patients`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- 限制导出的表
--

--
-- 限制表 `appointments`
--
ALTER TABLE `appointments`
  ADD CONSTRAINT `appointments_ibfk_1` FOREIGN KEY (`therapist_id`) REFERENCES `therapists` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `appointments_ibfk_2` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`id`) ON DELETE CASCADE;

--
-- 限制表 `groupmeetings`
--
ALTER TABLE `groupmeetings`
  ADD CONSTRAINT `groupmeetings_ibfk_1` FOREIGN KEY (`group_id`) REFERENCES `groups` (`id`) ON DELETE CASCADE;

--
-- 限制表 `groupnotes`
--
ALTER TABLE `groupnotes`
  ADD CONSTRAINT `groupnotes_ibfk_1` FOREIGN KEY (`group_id`) REFERENCES `groups` (`id`) ON DELETE CASCADE;

--
-- 限制表 `grouppatient`
--
ALTER TABLE `grouppatient`
  ADD CONSTRAINT `grouppatient_ibfk_1` FOREIGN KEY (`group_id`) REFERENCES `groups` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `grouppatient_ibfk_2` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`id`) ON DELETE CASCADE;

--
-- 限制表 `patientdailyrecords`
--
ALTER TABLE `patientdailyrecords`
  ADD CONSTRAINT `patientdailyrecords_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`id`) ON DELETE CASCADE;

--
-- 限制表 `patientnotes`
--
ALTER TABLE `patientnotes`
  ADD CONSTRAINT `patientnotes_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`id`),
  ADD CONSTRAINT `patientnotes_ibfk_2` FOREIGN KEY (`therapist_id`) REFERENCES `therapists` (`id`);

--
-- 限制表 `patienttherapistdisease`
--
ALTER TABLE `patienttherapistdisease`
  ADD CONSTRAINT `patienttherapistdisease_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `patienttherapistdisease_ibfk_2` FOREIGN KEY (`therapist_id`) REFERENCES `therapists` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `patienttherapistdisease_ibfk_3` FOREIGN KEY (`disease_id`) REFERENCES `mentaldiseases` (`id`) ON DELETE CASCADE;

--
-- 限制表 `therapist_assigned_patients`
--
ALTER TABLE `therapist_assigned_patients`
  ADD CONSTRAINT `therapist_assigned_patients_ibfk_1` FOREIGN KEY (`therapist_id`) REFERENCES `therapists` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `therapist_assigned_patients_ibfk_2` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
