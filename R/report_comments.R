#' Builds a list containing Roxygen formated strings used for generating MBE702 survey results report (not for end user)
#'
#' @param dats a list object returned from \code{process_input()}
#' @return a heatmap of responses.
#'
#' @export


report_comments <- function(dats){
  IDs = dats[[1]]
  comments = dats[[4]]
  
  strengths = comments[,2] %>% str_split(.,",") %>% unlist() %>% str_remove(., "^ ")
  p <- ggplot(data = data.frame(x = strengths) , aes(x = x)) +
    geom_bar(stat = "count") +
    theme_bw() +
    coord_flip() +
    labs(y = "Number of Respondants", x = "Strength") 

  comments <- as.data.frame(comments[,c(1,3)])
  comments$names = IDs
  comments <- tidyr::gather(comments, key = "section", value = "comment", -c("names"))
  comments <- comments[! is.na(comments$comment),]
  comments <- comments[! comments$comment == "",]
  comments <- comments[! comments$comment == " ",]
  comments$string = paste0("#' ","* ", comments$names," : ", comments$comment,"\n")
  comments
  comments$section
  l <- list(dplyr::filter(comments, section == "take_away")$string,
            dplyr::filter(comments, section == "improvement")$string)

  invisible(list(l,p))
}

