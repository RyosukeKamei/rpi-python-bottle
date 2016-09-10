USE measurement;

CREATE TABLE `temperatures` (
  `id`           int(11) NOT NULL AUTO_INCREMENT,
  `server_id`    int(11) NOT NULL,
  `temperature`  double(3, 10) NOT NULL,
  `careted_at`   int(14) NOT NULL,
  `careted_user` int(11) NOT NULL,
  `updated_at`   int(14) NOT NULL,
  `updated_user` int(11) NOT NULL,
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `temperatures` 
  (`id`, `server_id`, `temperature`, `careted_at`, `careted_user`, `updated_at`, `updated_user`) 
  VALUES 
  (1, 1, 29.123456789, 20160101001122, 1, 20160101001122, 1);