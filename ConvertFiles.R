library(foreach)
library(feather)
library(readstata13)
library(tools)

# CHDAO 15.01.2021 Change to use relative path
# Old commands are marked with "DROPPED", just above the actual commands
# CHDAO 15.01.2021

# DROPPED file_path <- "E:/IeDEA/Quality checks/SMARTZIM_20200916/Old/

# Current working directory contains this script file, and subfolders are \New and \Old
# DROPPED No need setwd (dirname(rstudioapi::getSourceEditorContext()$path))

# Create path to subfolder Data\Old first
file_path <- file.path(getwd(), "Data", "Old")

# Loop to read each file in that directory and convert to format "feather"
print ("Start converting files in Old subfolder")
foreach(tab=dir(file_path)) %do%{
  
  #  Convert only .dta file to feather
  if (toupper(file_ext(tab)) == "DTA") { 
    print(tab)#;print(Sys.time())
    
    tabwrite <- substr(tab,1,nchar(tab)-3)     # get the file name, including . and remove "dta" 
    
    # DROPPED temp <- read.dta13(paste0(file_path,tab))
    temp <- read.dta13(file.path(file_path,tab)) # read file content into temp var
    
    # DROPPED write_feather(temp,paste0(file_path,tabwrite,"feather"))
    write_feather(temp,file.path(file_path,paste0(tabwrite,"feather"))) # write file content in feather format
                                                                        # save in the same folder
    
    rm(temp) # remove 
    #print(tab);#print(Sys.time())
  }
}
print ("Converting files in Old subfolder finished")
print(Sys.time())

# DROPPED file_path <- "E:/IeDEA/Quality checks/SMARTZIM_20200916/New/"

# Then create path to subfolder Data\New
file_path <- file.path(getwd(), "Data", "New")

# Loop to read each file in that directory and convert to format "feather"
print ("Start converting files in New subfolder")
#print(Sys.time())

foreach(tab=dir(file_path)) %do%{
  
  #  Convert only .dta file to feather
  if (toupper(file_ext(tab)) == "DTA") { 
    print(tab);#print(Sys.time())
    
    tabwrite <- substr(tab,1,nchar(tab)-3)     # get the file name, including . and remove "dta" 
    # DROPPED temp <- read.dta13(paste0(file_path,tab))
    temp <- read.dta13(file.path(file_path,tab)) # read file content into temp var
    
    # DROPPED write_feather(temp,paste0(file_path,tabwrite,"feather"))
    write_feather(temp,file.path(file_path,paste0(tabwrite,"feather"))) # write file content in feather format
                                                                        # save in the same folder
    
    rm(temp)
    #print(tab);#print(Sys.time())
  }  
}
print ("Converting files in New subfolder finished")
print(Sys.time())

rm(tab)
rm(tabwrite)
rm(file_path)