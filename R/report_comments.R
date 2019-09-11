#' Builds a list containing Roxygen formated strings used for generating MBE702 survey results report (not for end user)
#'
#' @param dats a list object returned from \code{process_input()}
#' @return a heatmap of responses.
#' @examples
#' report_comments(ma)

report_comments <- function(dats){
  IDs = dats[[1]]
  comments = dats[[4]]

  comments <- as.data.frame(comments)
  comments$names = IDs
  comments <- tidyr::gather(comments, key = "section", value = "comment", -c("names"))
  comments <- comments[! is.na(comments$comment),]
  comments <- comments[! comments$comment == "",]
  comments <- comments[! comments$comment == " ",]
  comments$string = paste0("#' ","* ", comments$names," : ", comments$comment,"\n")
  comments
  l <- list(dplyr::filter(comments, section == "Comment_Abstract")$string,
            dplyr::filter(comments, section == "Comment_Introduction")$string,
            dplyr::filter(comments, section == "Comment_Methods")$string,
            dplyr::filter(comments, section == "Comment_Results ")$string,
            dplyr::filter(comments, section == "Comment_Communication")$string,
            dplyr::filter(comments, section == "Comment_Acknowledgments")$string,
            dplyr::filter(comments, section == "Comment_Skills")$string,
            dplyr::filter(comments, section == "Comment_Slides")$string,
            dplyr::filter(comments, section == "Comment_Questions ")$string,
            dplyr::filter(comments, section == "General_Comments ")$string)

  invisible(l)
}
