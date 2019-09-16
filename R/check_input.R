#' Checks matrix for proper formating
#'
#' @param ma input matrix.
#' @return returns \code{TRUE} if properly formated, \code{FALSE} if not.
#' @export


check_input <- function(ma){
  check_names <- c("Timestamp","MBE.Students.C..or.Staff.Name","Abstract..._.","Comment","Introduction.._.","Comment.1","Methods.._.","Comment.2","Results..if.applicable..and.Discussion.._.","Comment.3","Communication.of.Research.Importance.._.","Comment.4","Acknowledgments.._.","Comment.5","Preparedness.and.Presentation.Skills..._.","Comment.6","Slide.Quality.._.","Comment.7","Ability.to.Answer.Questions.._.","Comment.8","General.Comments")
  if(all(colnames(ma) == check_names)){
    return(TRUE)
  }
  else{
    return(FALSE)
  }
}
