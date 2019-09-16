#' Generates a boxplot from MBE702 survey data (not for end user)
#'
#' @param dats a list object returned from \code{process_input()}
#' @param plot a \code{BOOL} to determine if to plot the result. Defaults to \code{TRUE}.
#' @return an invisible ggplot boxplot of the input data.
#'
#' @export
#' @import ggplot2


report_boxplot <- function(dats, plot = TRUE){

plot_data = tidyr::gather(as.data.frame(dats[[3]]),key = "Question", value = "Response")
plot_data$Question <- factor(plot_data$Question,levels = c("Abstract","Introduction","Methods","Results_Discussion","Communication",
                                                           "Acknowledgments","Presentation_Skills","Slide_Quality","Questions"))
p <- ggplot2::ggplot(data = plot_data, aes(x = Question, y = Response)) +
  geom_boxplot(fill = "cornflowerblue") +
  theme_bw() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1),
        plot.title = element_text(hjust = 0.5)) +
  labs(title = "MBE702 Seminar Survey Score Distribution", x = "Section") #+
  #scale_y_continuous(breaks = c(0,1,2,3,4), labels = c("Not present", "Needs work", "Sufficient", "Good", "Excellent"))

if(plot == TRUE){
  plot(p)
}

invisible(p)
}


