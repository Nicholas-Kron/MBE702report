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
#' @export


process_input <- function(ma){
  new_names = c("Timestamp","Name_or_C#","explain_importance","methods","results",
                "future_directions","take_away","strengths","improvement",
                "research_quality","overall_quality")
  dat = as.matrix(ma)
  colnames(dat) = new_names
  comments = dat[,c("take_away","strengths","improvement")]
  comments = apply(comments, c(1,2), FUN = function(x){
    str_replace_all(x, "[\r\n]" , "")})
  IDs = dat[,"Name_or_C#"]
  IDs = lapply(X = IDs, FUN = function(x){
    stringr::str_replace(x,
                         pattern = "[\\s][cC][0-9\\-]{2,}|[cC][0-9\\-]{2,}|[\\s0-9\\-]{2,}",replacement = "Student")
  })
  ratings = dat[,c("explain_importance","methods","results","future_directions","research_quality","overall_quality")]
  ratings_factor = apply(ratings, c(1,2), FUN = function(x){
    str_remove(x, "[0-9][:] ")})
  ratings_factor[ratings_factor == ""] = NA
  ratings_numeric = apply(ratings, c(1,2), FUN = function(x){
    str_remove(x, "[:] [aA-zZ ]*")})
  ratings_numeric[ratings_factor == ""] = 0
  storage.mode(ratings_numeric) <- "numeric"
  invisible(
    list(IDs,ratings_factor,ratings_numeric,comments)
  )
}


