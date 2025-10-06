r_files <- list.files(
  +     path = ".",              # Search in the current working directory
  +     pattern = "\\.R$",       # Match files ending with .R (case-sensitive)
  +     full.names = TRUE,       # Return full file paths
  +     recursive = TRUE         # Include subdirectories
  + )
> # Using a for loop:
  > for (file in r_files) {
    +     source(file)
    + }
