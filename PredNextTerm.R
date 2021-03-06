PredNextTerm <- function(inStr)
{
  assign("mesg", "in PredNextTerm", envir = .GlobalEnv)
  
  # Clean up the input string and extract only the words with no leading and trailing white spaces
  inStr <- CleanInputString(inStr);
  
  # Split the input string across white spaces and then extract the length
  inStr <- unlist(strsplit(inStr, split=" "));
  inStrLen <- length(inStr);
  
  nxtTermFound <- FALSE;
  predNxtTerm <- as.character(NULL);
  #mesg <<- as.character(NULL);
  # 1. First test the Four Gram using the four gram data frame
  if (inStrLen >= 3 & !nxtTermFound)
  {
    # Assemble the terms of the input string separated by one white space each
    inStr1 <- paste(inStr[(inStrLen-2):inStrLen], collapse=" ");
    
    # Subset the Four Gram data frame 
    searchStr <- paste("^",inStr1, sep = "");
    fDF4Temp <- fDF4[grep (searchStr, fDF4$terms), ];
    
    # Check to see if any matching record returned
    if ( length(fDF4Temp[, 1]) > 1 )
    {
      predNxtTerm <- fDF4Temp[1,1];
      nxtTermFound <- TRUE;
      wcloud<-fDF4Temp
      mesg <<- "Next word is predicted using 4-gram."
    }
    fDF4Temp <- NULL;
  }
  
  # 2. Next test the Three Gram using the three gram data frame
  if (inStrLen >= 2 & !nxtTermFound)
  {
    # Assemble the terms of the input string separated by one white space each
    inStr1 <- paste(inStr[(inStrLen-1):inStrLen], collapse=" ");
    
    # Subset the Three Gram data frame 
    searchStr <- paste("^",inStr1, sep = "");
    fDF3Temp <- fDF3[grep (searchStr, fDF3$terms), ];
    
    # Check to see if any matching record returned
    if ( length(fDF3Temp[, 1]) > 1 )
    {
      predNxtTerm <- fDF3Temp[1,1];
      nxtTermFound <- TRUE;
      wcloud<-fDF3Temp
      mesg <<- "Next word is predicted using 3-gram."
    }
    fDF3Temp <- NULL;
  }
  
  # 3. Next test the Two Gram using the three gram data frame
  if (inStrLen >= 1 & !nxtTermFound)
  {
    # Assemble the terms of the input string separated by one white space each
    inStr1 <- inStr[inStrLen];
    
    # Subset the Two Gram data frame 
    searchStr <- paste("^",inStr1, sep = "");
    fDF2Temp <- fDF2[grep (searchStr, fDF2$terms), ];
    
    # Check to see if any matching record returned
    if ( length(fDF2Temp[, 1]) > 1 )
    {
      predNxtTerm <- fDF2Temp[1,1];
      nxtTermFound <- TRUE;
      wcloud<-fDF2Temp
      mesg <<- "Next word is predicted using 2-gram.";
    }
    fDF2Temp <- NULL;
  }
  
  # 4. If no next term found in Four, Three and Two Grams return the most
  #    frequently used term from the One Gram using the one gram data frame
  if (!nxtTermFound & inStrLen > 0)
  {
    predNxtTerm <- fDF1$terms[1];
    wcloud<-fDF1
    mesg <- "No next word found, the most frequent word is selected as next word."
  }
  
  nextTerm <- word(predNxtTerm, -1);
  
  if (inStrLen > 0){
    dfTemp1 <- list(nextTerm=nextTerm, mesg=mesg, wcloud=wcloud);
    return(dfTemp1);
  } else {
    nextTerm <- "";
    mesg <-"";
    wcloud<-"";
    dfTemp1 <- list(nextTerm=nextTerm, mesg=mesg, wcloud=wcloud);
    return(dfTemp1);
  }
}