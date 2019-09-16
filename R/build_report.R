#' Builds a PDF report from MBE702 response survey CSV
#'
#' @param infile a \code{STRING} path to where the target .csv survey results file is located

build_report <- function(infile){
  path = path.expand(infile)
  if (file.exists(path) == FALSE){
    stop("The file does not exist")
  }

  speaker = basename(path)
  speaker = stringr::str_remove(speaker, ".csv")
  speaker = stringr::str_remove(speaker, "MBE702_")
  output.dir = dirname(path)
  Rfile = file.path(output.dir,paste0(speaker,"_MBE702_report.R"))
  raw = read.csv(path)
  processed = MBE702report::process_input(raw)
  comments = MBE702report::report_comments(processed)
  talk_date = stringr::str_extract(raw[1,1], "[0-9]{4}/[0-9]{2}/[0-9]{2}")

  ###generate R file for rmarkdown to render
  sink(Rfile)
  cat(paste0("#'","---\n",collapse = NULL))
  cat(paste0("#'","title: ", "MBE702 Survey Report for ", speaker,"\n",collapse = NULL))
  cat(paste0("#'",'author: "MBE Student Representatives"\n',collapse = NULL))
  cat(paste0("#'",'date: ', talk_date,'\n',collapse = NULL))
  cat(paste0("#'","output: html_document\n",collapse = NULL))
  cat(paste0("#'","---\n", collapse = NULL))
  cat("\n" )
  cat("\n" )
  #set up chunk
  cat("#+ setup, include=FALSE\n")
  cat("knitr::opts_chunk$set(collapse = TRUE)\n" )
  cat("\n" )
  #data import
  cat("#+ data import, include=FALSE\n")
  cat(paste0("dats = read.csv('",path,"')\n") )
  cat("dats = process_input(dats)")
  cat("\n" )
  #The report begins here.

  #heatmap
  cat(paste0("#'","# Individual Responses\n"))
  cat(paste0("#'","******\n"))
  cat("#+ heatmap-report, fig.width=5, fig.height=8, fig.align = 'center', out.width = '50%',echo = FALSE\n")
  #cat("data[[2]]\n" )
  cat("MBE702report::report_heatmap(dats)\n" )
  cat("#' \n" )

  #boxplot
  cat(paste0("#'","# Response Distribution\n"))
  cat(paste0("#'","******\n"))
  cat("#+ boxplot-report, fig.width=4, fig.height=4, fig.align = 'center', out.width = '50%', echo = FALSE,warning=FALSE\n")
  cat("MBE702report::report_boxplot(dats, plot = TRUE)\n" )
  cat("#' \n" )


  #Comments section
  cat(paste0("#'","# Comments\n"))
  cat(paste0("#'","******\n"))
  cat(paste0("#'"),"## Abstract\n")
  cat(unlist(comments[1]), sep ="")
  cat("#' \n" )
  cat(paste0("#'"),"## Introduction\n")
  cat(unlist(comments[2]), sep ="")
  cat("#' \n" )
  cat(paste0("#'"),"## Materials and Methods\n")
  cat(unlist(comments[3]), sep ="")
  cat("#' \n" )
  cat(paste0("#'"),"## Results (if applicable) and Discussion\n")
  cat(unlist(comments[4]), sep ="")
  cat("#' \n" )
  cat(paste0("#'"),"## Communication of Research Importance\n")
  cat(unlist(comments[5]), sep ="")
  cat("#' \n" )
  cat(paste0("#'"),"## Acknowledgments\n")
  cat(unlist(comments[6]), sep ="")
  cat("#' \n" )
  cat(paste0("#'"),"## Preparedness and Presentation Skills\n")
  cat(unlist(comments[7]), sep ="")
  cat("#' \n" )
  cat(paste0("#'"),"## Slide Quality\n")
  cat(unlist(comments[8]), sep ="")
  cat("#' \n" )
  cat(paste0("#'"),"## Ability to Answer Questions\n")
  cat(unlist(comments[9]), sep ="")
  cat("#' \n" )
  cat(paste0("#'"),"## General Comments\n")
  cat(unlist(comments[10]), sep ="")


  sink()



  ##render the final report
  rmarkdown::render(
  input = Rfile,
  output_file = paste0(speaker,"_MBE702_report.html"),
  output_format = "html_document",
  output_dir = output.dir
  )
}

