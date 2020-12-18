### Jittering Points in R
library(ggplot2)
library(ggmap)
library(gridExtra)

?geom_jitter

set.seed(272)

#Load trap data & DC map
dc_traps <- read.csv(file = "dc_trap_sites.csv", header = TRUE)
#dc_traps_unique <- read.csv(file = "dc_trap_unique.csv", header = TRUE)
dc_map <- get_stamenmap(bbox = c(left = -77.13, bottom = 38.81, right = -76.92, top = 39.0), maptype = "terrain", zoom = 12)

#Unqiue location base map
ggmap(dc_map) + geom_point(data = dc_traps, aes(x = LONGITUDE, y = LATITUDE), col = "red")
#With jittered points
ggmap(dc_map) + geom_jitter(data = dc_traps, aes(x = LONGITUDE, y = LATITUDE), col = "blue", width = 0.005, height = 0.005)

dc_traps_unique <- dc_traps[!duplicated(dc_traps$LONGITUDE) | !duplicated(dc_traps$LATITUDE),]
dc_traps_unique$lat_mod <- dc_traps_unique$LATITUDE + runif(nrow(dc_traps_unique), min = -0.01, max = 0.01)
dc_traps_unique$lon_mod <- dc_traps_unique$LONGITUDE + runif(nrow(dc_traps_unique), min = -0.01, max = 0.01)

#Unqiue location base map
ggmap(dc_map) + geom_point(data = dc_traps_unique, aes(x = LONGITUDE, y = LATITUDE), col = "red")
#With jittered points
ggmap(dc_map) + geom_point(data = dc_traps_unique, aes(x = lon_mod, y = lat_mod), col = "blue")

ggmap(dc_map) + geom_point(data = dc_traps_unique, aes(x = LONGITUDE, y = LATITUDE), col = "red") +
  geom_point(data = dc_traps_unique, aes(x = lon_mod, y = lat_mod), col = "blue") + ggtitle("Comparing Raw and Adjusted Data")

#Try again with less jitter
dc_traps_unique$lat_mod2 <- dc_traps_unique$LATITUDE + runif(nrow(dc_traps_unique), min = -0.0015, max = 0.0015)
dc_traps_unique$lon_mod2 <- dc_traps_unique$LONGITUDE + runif(nrow(dc_traps_unique), min = -0.0015, max = 0.0015)

ggmap(dc_map) + geom_point(data = dc_traps_unique, aes(x = LONGITUDE, y = LATITUDE), col = "red") +
  geom_point(data = dc_traps_unique, aes(x = lon_mod2, y = lat_mod2), col = "blue") + ggtitle("Comparing Raw and Adjusted Data")
