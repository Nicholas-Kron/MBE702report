#' Builds a response heatmap from an MBE702 survey (not for end user)
#'
#' @param dats a list object returned from \code{process_input()}
#' @return a heatmap of responses.
#'
#' @export
#' @import ggplot2 ComplexHeatmap circlize grid


report_heatmap <- function(dats){
  IDs = dats[[1]]
  faculty = unlist(IDs)
  faculty[faculty != "Student"] = "Faculty"
  
  mat = dats[[3]]
  rownames(mat) = IDs
  
  col_fun = circlize::colorRamp2(c(1, 2, 3, 4, 5),
                                 c("grey", "red", "yellow", "darkolivegreen1", "green"))
  
  c_anot =  ComplexHeatmap::HeatmapAnnotation(
    section_means = colMeans(dats[[3]],
                             na.rm = TRUE),
    col = list(section_means = col_fun),
    show_legend = FALSE,
    annotation_name_side = "left"
  )
  ht = ComplexHeatmap::Heatmap(
    name = "Response",
    column_title = "MBE702 Individual Responses",
    matrix = mat,
    row_names_side = "left",
    row_names_gp = gpar(fontsize = 10),
    column_names_side = "top",
    cluster_columns = FALSE,
    show_row_dend = FALSE,
    split = faculty,
    col = structure(
      c("grey", "red", "yellow", "darkolivegreen1", "green"),
      names = c ("1", "2", "3", "4", "5")),
      bottom_annotation = c_anot,
      rect_gp = gpar(col = "white", lwd = 2)
    )
    r_anot = rowAnnotation(
      individual_means = rowMeans(dats[[3]],
                                  na.rm = TRUE),
      col = list(individual_means = col_fun),
      show_legend = FALSE
    )
    
    ComplexHeatmap::draw(ht + r_anot)
}

