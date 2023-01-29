-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 29, 2023 at 12:26 PM
-- Server version: 10.4.22-MariaDB
-- PHP Version: 8.1.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `evidencija`
--

-- --------------------------------------------------------

--
-- Table structure for table `korisnici`
--

CREATE TABLE `korisnici` (
  `id` int(11) NOT NULL,
  `ime` varchar(100) NOT NULL,
  `prezime` varchar(100) NOT NULL,
  `telefon` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `struka` varchar(100) NOT NULL,
  `ime_vozila` varchar(100) NOT NULL,
  `lozinka` varchar(100) NOT NULL,
  `rola` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `korisnici`
--

INSERT INTO `korisnici` (`id`, `ime`, `prezime`, `telefon`, `email`, `struka`, `ime_vozila`, `lozinka`, `rola`) VALUES
(7, 'Nenad', 'Antic', '312312', 'nenad@gmail.com', '', '', '**********', 'administrator'),
(8, 'Bob', 'Bobic', '53523253', 'bob@gmail.com', 'Auto limar', '', '**********', 'radnik'),
(9, 'jova', 'jovic', '23513412', 'jj@gmail.com', '', 'megan', '**********', 'musterija'),
(11, 'Proba', 'hh', '412412', 'ss@gmail.com', 'auto elektricar\r\n', 'yugo', '**********', 'radnik');

-- --------------------------------------------------------

--
-- Table structure for table `musterija`
--

CREATE TABLE `musterija` (
  `id` int(11) NOT NULL,
  `ime` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `id_vozilo` int(11) NOT NULL,
  `ime_vozila` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `radnik`
--

CREATE TABLE `radnik` (
  `id` int(11) NOT NULL,
  `ime` varchar(100) NOT NULL,
  `prezime` varchar(100) NOT NULL,
  `telefon` varchar(30) NOT NULL,
  `struka` varchar(100) NOT NULL,
  `id_vozilo` int(11) NOT NULL,
  `ime_vozila` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `radnik`
--

INSERT INTO `radnik` (`id`, `ime`, `prezime`, `telefon`, `struka`, `id_vozilo`, `ime_vozila`) VALUES
(1, 'Bob', 'Bobic', '0635555', 'Auto limar', 2, 'PASAT\r\n');

-- --------------------------------------------------------

--
-- Table structure for table `vozilo`
--

CREATE TABLE `vozilo` (
  `id` int(11) NOT NULL,
  `id_musterija` int(11) NOT NULL,
  `Naziv` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `korisnici`
--
ALTER TABLE `korisnici`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `musterija`
--
ALTER TABLE `musterija`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `radnik`
--
ALTER TABLE `radnik`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `vozilo`
--
ALTER TABLE `vozilo`
  ADD PRIMARY KEY (`id`),
  ADD KEY `musterija_vozilo` (`id_musterija`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `korisnici`
--
ALTER TABLE `korisnici`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `musterija`
--
ALTER TABLE `musterija`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `radnik`
--
ALTER TABLE `radnik`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `vozilo`
--
ALTER TABLE `vozilo`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `musterija`
--
ALTER TABLE `musterija`
  ADD CONSTRAINT `musterija_ibfk_1` FOREIGN KEY (`id`) REFERENCES `korisnici` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `vozilo`
--
ALTER TABLE `vozilo`
  ADD CONSTRAINT `musterija_vozilo` FOREIGN KEY (`id_musterija`) REFERENCES `musterija` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `vozilo_ibfk_1` FOREIGN KEY (`id`) REFERENCES `radnik` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
