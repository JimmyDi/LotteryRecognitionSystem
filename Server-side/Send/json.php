<?php
  $file_path = "findc.txt";
  $file = fopen($file_path,"r");
   while(!feof($file))
    {
       
       $number=fgets($file);
       
    }

       fclose($file);
  
    if ($number=="05070918293002")
      {
          $result="dui";
      }
    else
        {
         $result="cuo";
          
        }

   $data = array('number'=>$number,'result'=>$result);
   print json_encode($data);


 
?>