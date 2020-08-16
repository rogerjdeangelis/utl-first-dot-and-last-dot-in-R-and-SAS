First dot and last dot in R and SAS                                                                                           
                                                                                                                              
    Two Solutions                                                                                                             
         a. SAS                                                                                                               
         b. R                                                                                                                 
                                                                                                                              
github                                                                                                                        
https://tinyurl.com/y3xcpdwr                                                                                                  
https://github.com/rogerjdeangelis/utl-first-dot-and-last-dot-in-R-and-SAS                                                    
                                                                                                                              
First dot and last dot in R and SAS                                                                                           
StackOverflow                                                                                                                 
https://tinyurl.com/y4nc5zpp                                                                                                  
https://stackoverflow.com/questions/11546684/how-can-i-find-the-first-and-last-occurrences-of-an-element-in-a-data-frame      
                                                                                                                              
Spaceman                                                                                                                      
https://stackoverflow.com/users/211116/spacedman                                                                              
                                                                                                                              
                                                                                                                              
/*                   _                                                                                                        
(_)_ __  _ __  _   _| |_                                                                                                      
| | `_ \| `_ \| | | | __|                                                                                                     
| | | | | |_) | |_| | |_                                                                                                      
|_|_| |_| .__/ \__,_|\__|                                                                                                     
        |_|                                                                                                                   
*/                                                                                                                            
                                                                                                                              
libname sd1 "d:/sd1";                                                                                                         
                                                                                                                              
proc sort data=sashelp.class(firstobs=7 obs=15 keep=name sex)                                                                 
           out=sd1.have;                                                                                                      
  by sex;                                                                                                                     
run;quit;                                                                                                                     
                                                                                                                              
 SD1.HAVE total obs=9                                                                                                         
                                                                                                                              
                   | RULES                                                                                                    
                   |                                                                                                          
  NAME       SEX   | FIRST_SEX LAST_SEX                                                                                       
                   |                                                                                                          
  Jane        F    |    1        0                                                                                            
  Janet       F    |    0        0                                                                                            
  Carol       F    |    0        0                                                                                            
  Judy        F    |    0        0                                                                                            
  Barbara     F    |    0        0                                                                                            
  Mary        F    |    0        1                                                                                            
  Jeffrey     M    |    1        0                                                                                            
  Henry       M    |    0        0                                                                                            
  Robert      M    |    0        1                                                                                            
                                                                                                                              
/*           _               _                                                                                                
  ___  _   _| |_ _ __  _   _| |_                                                                                              
 / _ \| | | | __| `_ \| | | | __|                                                                                             
| (_) | |_| | |_| |_) | |_| | |_                                                                                              
 \___/ \__,_|\__| .__/ \__,_|\__|                                                                                             
                |_|                                                                                                           
*/                                                                                                                            
                                                                                                                              
                                                                                                                              
WORK.WANT total obs=9                                                                                                         
                                                                                                                              
                    FIRST_                                                                                                    
  NAME       SEX      SEX     LAST_SEX                                                                                        
                                                                                                                              
  Jane        F        1          0                                                                                           
  Janet       F        0          0                                                                                           
  Carol       F        0          0                                                                                           
  Judy        F        0          0                                                                                           
  Barbara     F        0          0                                                                                           
  Mary        F        0          1                                                                                           
  Jeffrey     M        1          0                                                                                           
  Henry       M        0          0                                                                                           
  Robert      M        0          1                                                                                           
                                                                                                                              
/*         _       _   _                                                                                                      
 ___  ___ | |_   _| |_(_) ___  _ __  ___                                                                                      
/ __|/ _ \| | | | | __| |/ _ \| `_ \/ __|                                                                                     
\__ \ (_) | | |_| | |_| | (_) | | | \__ \                                                                                     
|___/\___/|_|\__,_|\__|_|\___/|_| |_|___/                                                                                     
  __ _     ___  __ _ ___                                                                                                      
 / _` |   / __|/ _` / __|                                                                                                     
| (_| |_  \__ \ (_| \__ \                                                                                                     
 \__,_(_) |___/\__,_|___/                                                                                                     
                                                                                                                              
*/                                                                                                                            
                                                                                                                              
data want_sas;                                                                                                                
  set sd1.have;                                                                                                               
  by sex;                                                                                                                     
  if first.sex then first_sex=1;                                                                                              
  else first_sex=0;                                                                                                           
  if last.sex then last_sex=1;                                                                                                
  else last_sex=0;                                                                                                            
run;quit;                                                                                                                     
                                                                                                                              
/*        ____                                                                                                                
| |__    |  _ \                                                                                                               
| `_ \   | |_) |                                                                                                              
| |_) |  |  _ <                                                                                                               
|_.__(_) |_| \_\                                                                                                              
                                                                                                                              
*/                                                                                                                            
                                                                                                                              
%utl_submit_r64('                                                                                                             
library(haven);                                                                                                               
library(SASxport);                                                                                                            
have<-read_sas("d:/sd1/have.sas7bdat");                                                                                       
want<-data.frame(have$SEX,FIRST=!duplicated(have$SEX),LAST=rev(!duplicated(rev(have$SEX))))*1;                                
want<-want[,-1];                                                                                                              
want;                                                                                                                         
write.xport(want,file="d:/xpt/want.xpt");                                                                                     
');                                                                                                                           
                                                                                                                              
%utlfkil(d/xpt/want.xpt);                                                                                                     
                                                                                                                              
proc datasets lib=work nolist;                                                                                                
 delete  want;                                                                                                                
run;quit;                                                                                                                     
                                                                                                                              
libname xpt xport "d:/xpt/want.xpt";                                                                                          
                                                                                                                              
data want;                                                                                                                    
  merge sd1.have xpt.want  ;                                                                                                  
  rename first=first_sex last=last_sex;                                                                                       
run;quit;                                                                                                                     
                                                                                                                              
libname xpt clear;                                                                                                            
                                                                                                                              
