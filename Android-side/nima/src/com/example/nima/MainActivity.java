package com.example.nima;

import android.net.Uri;
import android.os.Bundle;
import android.os.Environment;
import android.os.Handler;
import android.os.Looper;
import android.os.Message;
import android.os.StrictMode;
import android.provider.MediaStore;
import android.app.Activity;
import android.content.Intent;
import android.graphics.Bitmap;
import android.util.Log;
import android.view.View;
import android.view.Window;
import android.view.WindowManager;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.TextView;
import java.net.URL;
import java.net.HttpURLConnection;
import java.net.URLConnection;
import java.io.BufferedInputStream;
import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;

import org.apache.http.HttpResponse;
import org.apache.http.HttpStatus;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.protocol.HTTP;
import org.apache.http.util.ByteArrayBuffer;
import org.apache.http.util.EncodingUtils;
import org.apache.http.util.EntityUtils;
import org.json.JSONObject;






public class MainActivity extends Activity {

	private static final int RESULT_CAPTURE_IMAGE = 1;
	
	private String srcPath = "/sdcard/myImage/image_ready.jpg";
	
	private String up_Url="";
	private String down_Url="";
	
	private TextView mText1;
	private TextView mText2;
	private TextView mText3;
	private TextView number_Text;
	private TextView result_Text;
	private Button mButton;
	private Button pButton;
	private Button qButton;
	
	private Button wButton;
	private EditText edi;
	
	
	@Override
	    protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		this.requestWindowFeature(Window.FEATURE_NO_TITLE);//去掉标题栏
		this.getWindow().setFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN, WindowManager.LayoutParams.FLAG_FULLSCREEN);//去掉信息栏
		setContentView(R.layout.activity_main);
		
		number_Text=(TextView)findViewById(R.id.textView1);
		
		mText2=(TextView)findViewById(R.id.textView2);
		
		mText3=(TextView)findViewById(R.id.textView6);
		
		mText1=(TextView)findViewById(R.id.textView3);
        result_Text=(TextView)findViewById(R.id.textView4);
		
        
        
        
		mButton=(Button)findViewById(R.id.button1);
		pButton=(Button)findViewById(R.id.button2);
	    qButton=(Button)findViewById(R.id.button3);
		wButton=(Button)findViewById(R.id.button4);

		edi=(EditText)findViewById(R.id.editText1);
		
		
		
		wButton.setOnClickListener(new View.OnClickListener() {
			
			@Override
			public void onClick(View arg0) {
				// TODO Auto-generated method stub
				
				up_Url=edi.getText().toString();
				Log.e("SMD", up_Url); 
				up_Url="http://"+up_Url+"/cat.php";
				Log.e("SMD", up_Url); 
				
				down_Url=edi.getText().toString();
				Log.e("SMD", down_Url); 
				down_Url="http://"+down_Url+"/json.php";
				Log.e("SMD", down_Url);
				
				mText1.setText("文件路径：\n" + srcPath);
				mText2.setText("上传：\n" + up_Url);
				mText3.setText("下载：\n"+down_Url);
				
			}
		});
		
		
		
		
		
		
		
		//设置上传按键监听
		mButton.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View arg0) {
					  		
	
			    new Thread(new Runnable() {
				public void run() {
			   // TODO Auto-generated method stub
					uploadFile(up_Url);
				}}).start();
			}
		});
		

		  
		
qButton.setOnClickListener(new View.OnClickListener() {
	
	@Override
	public void onClick(View v) {
		// TODO Auto-generated method stub
	
		
		new NetThread().start();
	
		
	}
});
		

		
		
		//设置相机拍照按键监听
       	pButton.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {				
				
				File file = new File("/sdcard/myImage/");  
            	if(!file.exists()){
            		file.mkdirs();// 创建文件夹 
            	}           	
            	Intent imageCaptureIntent = new Intent(MediaStore.ACTION_IMAGE_CAPTURE);
                 imageCaptureIntent.putExtra(MediaStore.EXTRA_OUTPUT,
                 Uri.fromFile(new File("/sdcard/myImage/image_ready.jpg")));
                 startActivityForResult(imageCaptureIntent, RESULT_CAPTURE_IMAGE);
			}
		});
				
	}
	

	


	
	
	

	
	class NetThread extends Thread{

		@Override
		public void run() {
			
			try
	        {
				//String requestUrl="http://192.168.1.101/json.php";
				String result="";
			try
				{
				Log.e("SMD", "in1");
				Log.e("SMD", "in2"); 
					URL url=new URL(down_Url);
					Log.e("SMD", "in99"); 
					HttpURLConnection connection=(HttpURLConnection)url.openConnection();
				Log.e("SMD", "in100");  
				connection.setDoOutput(true);
				 connection.setDoInput(true);
				 connection.setRequestMethod("GET");
					 connection.setUseCaches(false);
				 connection.setInstanceFollowRedirects(false);
					 connection.setRequestProperty("Content-Type",
				                "application/x-www-form-urlencoded");
					 Log.e("SMD", "in2"); 
					  InputStream is= connection.getInputStream();
					 Log.e("SMD", "in3");
			      BufferedReader reader=new BufferedReader(new InputStreamReader(connection.getInputStream(),"GBK"));
			      String line="";
			      StringBuffer buffer=new StringBuffer();
			      
			      while((line=reader.readLine())!=null){
			       buffer.append(line);
				      }
			      result=buffer.toString();
				      Log.e("SMD",result); 
				      JSONObject jsonObject = new JSONObject(result);
				      String re_number = jsonObject.getString("number");
				      String re_result = jsonObject.getString("result");
				      
				      Log.e("SMD", "in44");
				      
				      Message msg = new Message();
					  Bundle b = new Bundle();
					  
					  Log.e("SMD", "in99");
			          b.putString("number_q", re_number);
			          b.putString("result_q", re_result);
			          
			          Log.e("SMD", "in66");
			          
			          msg.setData(b);
			          handler.sendMessage(msg);
			          
			          Log.e("SMD", "in77");
			          

				}
				
				catch (Exception e)
				{
					   e.printStackTrace();
			    }
	        }
			catch(Exception e)
			{
				
				Log.v("url response", "false");
				e.printStackTrace();
			}
			
		}
		
	}
	
	
	
	
	
	
	
	
	
    
   
		

  
 
   

	//图片上传函数
	private void uploadFile(String uploadUrl)
	{
		
		//mText2.setText("fuck!");
		String end = "\r\n";
	    String twoHyphens = "--";
	    String boundary = "******";
		  // tuitui="http://192.168.1."+tuitui+"/cat.php";
		  
		   try
	    {
	    	URL ur1=new URL(uploadUrl);
	    	HttpURLConnection httpURLConnection = (HttpURLConnection) ur1.openConnection();
	    		    	
	    	 httpURLConnection.setDoInput(true);
	         httpURLConnection.setDoOutput(true);
	         httpURLConnection.setUseCaches(false);
	         
	         httpURLConnection.setRequestMethod("POST");
	         httpURLConnection.setRequestProperty("Connection", "Keep-Alive");
	         httpURLConnection.setRequestProperty("Charset", "UTF-8");
	         httpURLConnection.setRequestProperty("Content-Type",
	             "multipart/form-data;boundary=" + boundary);
	         
	         DataOutputStream dos = new DataOutputStream(
	                 httpURLConnection.getOutputStream());
	         dos.writeBytes(twoHyphens + boundary + end);
	         dos.writeBytes("Content-Disposition: form-data; name=\"uploadedfile\"; filename=\""
	                 + srcPath.substring(srcPath.lastIndexOf("/") + 1)
	                 + "\""
	                 + end);
	         dos.writeBytes(end);
	         
	         //mText2.setText("fuck1!");
	         FileInputStream fis = new FileInputStream(srcPath);
	         byte[] buffer = new byte[1024];   
	         int count = 0;
	         
	         while ((count = fis.read(buffer)) != -1)
	         {
	           dos.write(buffer, 0, count);
	         }
	         fis.close();
	         
	         
	         dos.writeBytes(end);
	         dos.writeBytes(twoHyphens + boundary + twoHyphens + end);
	         dos.flush();
	         
	         //mText2.setText("fuck2!");
	         
	         InputStream is = httpURLConnection.getInputStream();
	 //        InputStreamReader isr = new InputStreamReader(is, "utf-8");
	//         BufferedReader br = new BufferedReader(isr);
	//         String result = br.readLine();
	                    
	         
	         dos.close(); 
	         is.close();
	         
	    }
	
	    catch (Exception e)
	    {
	    	
	    	e.printStackTrace();
	      setTitle(e.getMessage());
	    }

		}
	
	
	
	
	
	
	Handler handler =new Handler(){
		public void handleMessage(Message msg)  
	    {  
			Log.e("SMD", "in88");
	      Bundle b = msg.getData();
	      
	      number_Text.setText(b.getString("number_q"));
	      Log.e("SMD",b.getString("number_q"));
	      Log.e("SMD",b.getString("result_q"));
	      if(b.getString("result_q").equals("dui"))
	      {
	    	  result_Text.setText("恭喜！");
	    	  
	      }
	      
	      else
	      {
	    	  result_Text.setText("抱歉！");
	      }
	     
	     
	      
	    } 
		
	};
	
	
	
	
	}











