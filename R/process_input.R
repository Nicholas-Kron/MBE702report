#' Breaks up input matrix into usable groupings of data.
#'
#' @param ma input matrix.
#' @return an invisible \code{LIST} with 4 items.
#' \describe{
#'    \item{\code{LIST[[1]]}}{Respondant IDs, either C# or faculty name.}
#'    \item{\code{LIST[[2]]}}{Raw ratings on a scale from "Not present" to "Excellent".}
#'    \item{\code{LIST[[3]]}}{Numeric equivalent to \code{LIST[[2]]}.}
#'    \item{\code{LIST[[4]]}}{Comments for all sections.}
#' }
#'


process_input <- function(ma){
  new_names = c("Timestamp","Name_or_C#","Abstract","Comment_Abstract","Introduction",
                "Comment_Introduction","Methods","Comment_Methods","Results_Discussion",
                "Comment_Results","Communication","Comment_Communication","Acknowledgments",
                "Comment_Acknowledgments","Presentation_Skills","Comment_Skills","Slide_Quality",
                "Comment_Slides","Questions","Comment_Questions","General_Comments")
  dat = as.matrix(ma)
  colnames(dat) = new_names
  ratings_factor = dat[,c("Abstract","Introduction","Methods","Results_Discussion","Communication",
                          "Acknowledgments","Presentation_Skills","Slide_Quality","Questions")]
  ratings_factor[ratings_factor == ""] = NA
  comments = dat[,c("Comment_Abstract","Comment_Introduction","Comment_Methods","Comment_Results",
                    "Comment_Communication","Comment_Acknowledgments","Comment_Skills","Comment_Slides",
                    "Comment_Questions","General_Comments")]
  IDs = dat[,"Name_or_C#"]
  IDs = lapply(X = IDs, FUN = function(x){
    stringr::str_replace(x,
                         pattern = "[\\s][cC][0-9\\-]{2,}|[cC][0-9\\-]{2,}|[\\s0-9\\-]{2,}",replacement = "Student")
  })
  ratings_numeric = ratings_factor
  ratings_numeric[ratings_numeric == "Excellent"] = 4
  ratings_numeric[ratings_numeric == "Good"] = 3
  ratings_numeric[ratings_numeric == "Sufficient"] = 2
  ratings_numeric[ratings_numeric == "Needs work"] = 1
  ratings_numeric[ratings_numeric == "Not present"] = 0
  storage.mode(ratings_numeric) <- "numeric"
  invisible(
    list(IDs,ratings_factor,ratings_numeric,comments)
  )
}
