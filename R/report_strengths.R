#' Builds a list containing Roxygen formated strings used for generating MBE702 survey results report (not for end user)
#'
#' @param dats a list object returned from \code{process_input()}
#' @return a histogram of responses.
#'
#' @export


report_strengths <- function(dats){
  IDs = dats[[1]]
  comments = dats[[4]]
  
  strengths = comments[,2] %>% str_split(.,",") %>% unlist() %>% str_remove(., "^ ")
  p <- ggplot(data = data.frame(x = strengths) , aes(x = x)) +
    geom_bar(stat = "count") +
    theme_bw() +
    coord_flip() +
    labs(y = "Number of Respondants", x = "Strength")
  p
}