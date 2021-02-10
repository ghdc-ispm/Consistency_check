
# CHDAO 18.01.2021
# Script to generate HTML data consistency report, by knitting "Consistency_report.rmd" document
# into sub directory, named according to "cohort" and "fu_close_dmy" (dataset version)
# Input : copy 2 datasets into sub directory "\Data" (into "Old" and "New" consequently)
# Output : in sub directory "\Output"

library(data.table)
library(feather)

# CHDAO 18.01.2021 Read meta data
filepath_read <- file.path(getwd(), "Data", "New")

if (file.exists(file.path(filepath_read, "META.feather"))) {
  # if file META exists read it
  metaa <- data.table(read_feather(file.path(filepath_read, "META.feather")))
  # build up sub directory name = "cohort_fu_close_dmy"
  output_subdir <- paste(metaa$cohort[1], format(max(metaa$fu_close_dmy), "%Y%m%d"),sep='_')
} else {
  # if not read tblCENTER instead
  metaa <- data.table(read_feather(file.path(filepath_read, "tblCENTER.feather")))
  # build up sub directory name = "cohort_fu_close_dmy"
  output_subdir <- paste(metaa$program[1], format(max(metaa$close_d), "%Y%m%d"),sep='_')
}

# CHDAO 18.01.2021
rm(filepath_read)
rm(metaa)

# CHDAO 18.01.2021
# create sub directory in Output
ifelse(!dir.exists(file.path("Output", output_subdir)), dir.create(file.path("Output", output_subdir)), FALSE)

filename <- "Consistency_report_v3"

output_dir <- file.path("Output", output_subdir)
output_file <- paste(paste(Sys.Date(), filename, sep='_'),'.html',sep='') # suffix filename with sysdate

# Create output HTML, with customized file name and in corresponding sub directory
rmarkdown::render(paste(filename, '.Rmd',sep=''),
                  output_dir = output_dir,
                  output_file = output_file
                 )
# then view report
browseURL(file.path(output_dir,output_file))

# release all global var          
rm(output_file)
rm(output_dir)
rm(filename)
rm(output_subdir)
