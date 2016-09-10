USE measurement;

CREATE TABLE `temperatures` (
  `id`           int(11) NOT NULL AUTO_INCREMENT,
  `server_id`    int(11) NOT NULL,
  `temperature`  int(11) NOT NULL,
  `careted_at`   datetime NOT NULL,
  `careted_user` int(11) NOT NULL,
  `updated_at`   datetime NOT NULL,
  `updated_user` int(11) NOT NULL,
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `temperatures` 
  (`id`, `server_id`, `temperature`, `careted_at`, `careted_user`, `updated_at`, `updated_user`) 
  VALUES 
  (1, 1, 29, NOW(), 1, NOW(), 1);