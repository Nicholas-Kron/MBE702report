#' Checks matrix for proper formating
#'
#' @param ma input matrix.
#' @return returns \code{TRUE} if properly formated, \code{FALSE} if not.
#' @export


check_input <- function(ma){
  check_names <- c("Timestamp",
                   "Student..C..or.faculty.name",
                   "General.feedback..only.select.one.per.row...To.what.extent.did......The.speaker.explain.the.importance.of.the.topic...",
                   "General.feedback..only.select.one.per.row...To.what.extent.did......This.seminar.discuss.how.the.research.was.performed..",
                   "General.feedback..only.select.one.per.row...To.what.extent.did......The.speaker.discuss.the.significance.of.the.results.presented..",
                   "General.feedback..only.select.one.per.row...To.what.extent.did......The.speaker.suggest.future.directions.or.next.steps.needed.in.this.research.area..",
                   "What.were.one.or.two.key.points.you.will.take.away.from.this.seminar.",
                   "What.were.the.speaker.s.strengths...choose.all.that.apply.or.leave.blank.",
                   "What.are.some.areas.the.speaker.could.improve...choose.all.that.apply.or.leave.blank.",
                   "Quality.rating..Rate.for.the.quality.of.research.presented.",
                   "Quality.rating..Rate.for.the.overall.quality.of.presentation.")
    if(all(colnames(ma) == check_names)){
    return(TRUE)
  }
  else{
    return(FALSE)
  }
}
