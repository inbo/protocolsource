
## -----------------------------------------------------------------------------------------------------------
theme_nothing <- function(base_size = 9)
{
  theme_bw(base_size = base_size) %+replace%
    theme(
      line             = element_blank(),
      axis.text = element_blank()
    )
}

## -----------------------------------------------------------------------------------------------------------
calc_discs <- function(aantal, bedekking) {
  set.seed(354)
  p <- ppp(runif(aantal), 
           runif(aantal))
  w <- as.owin(list(xrange = c(0,1), yrange = c(0,1)))
  disc_radius <- list(minimum = NA,
                      objective = 1)
  max_x <- 0.35
  while (disc_radius$objective > 1e-05) {
    disc_radius <- optimize(
      function(x) {
        (bedekking - 
           area.owin(
             discs(
               centres = p, 
               radii = rep(x, p$n),
               mask = TRUE
             )
           ) / area.owin(w)
        )^2
      },
      interval = c(0, max_x)
    )
    max_x <- max_x / 2
  }
  
  
  p <- discs(centres = p, 
             radii = rep(disc_radius$minimum, p$n),
             mask = FALSE,
             npoly = 2^4, 
             separate = FALSE)
  
  p <- as.data.frame(p)
  p$id <- if (is.null(p$id)) {
    p$id <- 1
    p$sign <- 1
  } else {
    p$id
  }
  
  return(as_tibble(p))
}


## -----------------------------------------------------------------------------------------------------------
plot_discs <- function(klasse, data, bedekking, aantal, gecombineerd) {
  one_percent <- data.frame(
    id = rep(1, 4),
    x = c(0, 0, 0.1, 0.1),
    y = c(0, 0.1, 0.1, 0)
  )
  
  custom_title <- ifelse(gecombineerd,
                         paste0(klasse, 
                                " (bedekking in figuur = ",
                                bedekking,
                                "% en aantal in figuur = ",
                                aantal,
                                ")"
                         ),
                         paste0(klasse, 
                                " (bedekking in figuur = ",
                                bedekking,
                                "%)"
                         )
  )
  
  
  data %>%
    ggplot(aes(x = x, y = y)) + 
    geom_polygon(aes(group = id), fill = "springgreen4") + 
    geom_polygon(data = one_percent, colour = "blue4", fill = NA) +
    scale_x_continuous(limits = c(0,1), expand = c(0,0)) + 
    scale_y_continuous(limits = c(0,1), expand = c(0,0)) + 
    coord_equal() + 
    theme_nothing() +
    labs(title = custom_title) +
    theme(plot.title = element_text(size = 9),
          legend.position = "none",
          axis.title = element_blank())
}



