#' Generates a boxplot from survey data
#'
#' @param dats a list object returned from \code{process_input()}
#' @return a boxplot of the input data
#' @examples
#' report_boxplot(ma)

report_boxplot <- function(dats){

dats[[3]] %>%
    as.data.frame() %>%
    tidyr::gather(key = "Question", value = "Response") %>%
    ggplot2::ggplot(data = ., aes(x = Question, y = Response)) + geom_boxplot()

}
