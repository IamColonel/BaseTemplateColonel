CREATE TABLE `playersTattoos` (
  `id` int(11) NOT NULL,
  `identifier` varchar(255) NOT NULL,
  `tattoos` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


ALTER TABLE `playersTattoos`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `playersTattoos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;